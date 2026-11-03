import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/core/response/api_response.dart';
import 'package:ss_admin_dashboard/features/story_workspace/controllers/story_workspace_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/card/card_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/highlight/highlight_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/image/image_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/link/link_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/paragraph/paragraph_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/quotation/quotation_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/related_content/related_content_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/scientist_card/scientist_card_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/content_type.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/story_block_model.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/repository/story_block_repository.dart';

class StoryBlocksController extends GetxController {
  final StoryWorkspaceController storyWorkspaceController =
      Get.find<StoryWorkspaceController>();

  final StoryBlockRepository _repository = StoryBlockRepository();

  Rxn<ContentType> selectedContentType = Rxn<ContentType>();

  late final QuillController quillController;

  final ScrollController leftPanelScrollController = ScrollController();

  final storyBlocksResponse = ApiResponse<List<StoryBlockModel>>.loading().obs;

  final RxBool isLoading = false.obs;
  final RxnString selectedBlockId = RxnString();
  final RxnString animatedBlockId = RxnString();
  final RxBool isOrderChanged = false.obs;

  @override
  void onInit() {
    super.onInit();
    quillController = QuillController.basic();
    _initialize();
  }

  Future<void> _initialize() async {
    final storyLoaded = await storyWorkspaceController.storyLoadFuture;

    if (storyLoaded) {
      await getStoryBlocks();
    }
  }

  // Upload image for Image Block or Scientist Card.
  Future<String> uploadImage(List<int> bytes, String filename) {
    return _repository.uploadImage(bytes, filename);
  }

  // Get story blocks.
  Future<void> getStoryBlocks() async {
    final storyId = storyWorkspaceController.story.value?.id;

    if (storyId == null || storyId.isEmpty) {
      storyBlocksResponse.value = ApiResponse.error('Story not found.');
      return;
    }

    try {
      storyBlocksResponse.value = ApiResponse.loading();

      final storyBlocks = await _repository.getStoryBlocks(storyId);

      storyBlocksResponse.value = ApiResponse.completed(storyBlocks);
    } catch (error) {
      storyBlocksResponse.value = ApiResponse.error(error.toString());
    }
  }

  // Update the story's updatedAt locally.
  void _updateStoryTimestamp() {
    final story = storyWorkspaceController.story.value;

    if (story != null) {
      story.updatedAt = DateTime.now().toIso8601String();
      storyWorkspaceController.story.refresh();
    }
  }

  // Create a new story block.
  Future<StoryBlockModel> createStoryBlock(StoryBlockModel block) async {
    final storyId = storyWorkspaceController.story.value?.id;

    if (storyId == null || storyId.isEmpty) {
      throw Exception('Story not found.');
    }

    final createdStoryBlock = await _repository.createStoryBlock(
      block,
      storyId,
    );

    final blocks = storyBlocksResponse.value.data;

    if (blocks == null) {
      throw Exception('Story blocks have not been loaded.');
    }

    blocks.add(createdStoryBlock);
    storyBlocksResponse.refresh();

    _updateStoryTimestamp();

    await scrollToBottom();
    await animateBlock(createdStoryBlock.id!);

    return createdStoryBlock;
  }

  // Update a story block.
  Future<StoryBlockModel> updateStoryBlock(StoryBlockModel block) async {
    final updatedStoryBlock = await _repository.updateStoryBlock(
      block,
      block.id!,
    );

    final blocks = storyBlocksResponse.value.data;

    if (blocks == null) {
      throw Exception('Story blocks have not been loaded.');
    }

    final index = blocks.indexWhere((item) => item.id == updatedStoryBlock.id);

    if (index != -1) {
      blocks[index] = updatedStoryBlock;
      storyBlocksResponse.refresh();
    }

    _updateStoryTimestamp();

    await animateBlock(updatedStoryBlock.id!);

    return updatedStoryBlock;
  }

  // Delete a story block.
  Future<void> deleteStoryBlock(StoryBlockModel block) async {
    try {
      isLoading.value = true;

      await _repository.deleteStoryBlock(block.id!);

      closeEditor();

      storyBlocksResponse.value.data?.removeWhere(
        (item) => item.id == block.id,
      );

      storyBlocksResponse.refresh();
      _updateStoryTimestamp();
    } catch (error) {
      Get.snackbar('Error', error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Reorder blocks locally.
  void reorderBlocks(int oldIndex, int newIndex) {
    final blocks = storyBlocksResponse.value.data;

    if (blocks == null || oldIndex < 0 || oldIndex >= blocks.length) {
      return;
    }

    if (newIndex > oldIndex) {
      newIndex--;
    }

    if (newIndex < 0 || newIndex >= blocks.length) {
      return;
    }

    final block = blocks.removeAt(oldIndex);
    blocks.insert(newIndex, block);

    storyBlocksResponse.refresh();
    _updateStoryTimestamp();
    isOrderChanged.value = true;
  }

  // Save block order to the backend.
  Future<void> saveBlockOrder() async {
    final blocks = storyBlocksResponse.value.data;
    final storyId = storyWorkspaceController.story.value?.id;

    if (blocks == null || storyId == null || storyId.isEmpty) {
      Get.snackbar('Error', 'Story or story blocks not found.');
      return;
    }

    try {
      isLoading.value = true;

      final orderedIds = blocks.map((block) => block.id!).toList();

      await _repository.reorderStoryBlocks(orderedIds, storyId);

      isOrderChanged.value = false;
    } catch (error) {
      Get.snackbar('Error', error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Load an existing story block into its editor.
  void loadBlock(StoryBlockModel block) {
    openEditor(block.type!);
    selectedBlockId.value = block.id;

    switch (block.type!) {
      case ContentType.paragraph:
        Get.find<ParagraphController>().loadParagraphContent(block);
        break;
      case ContentType.card:
        Get.find<CardController>().loadCardContent(block);
        break;
      case ContentType.highlight:
        Get.find<HighlightController>().loadHighlightContent(block);
        break;
      case ContentType.image:
        Get.find<ImageController>().loadImageContent(block);
        break;
      case ContentType.link:
        Get.find<LinkController>().loadLinkContent(block);
        break;
      case ContentType.quotation:
        Get.find<QuotationController>().loadQuotationContent(block);
        break;
      case ContentType.related_content:
        Get.find<RelatedContentController>().loadRelatedContent(block);
        break;
      case ContentType.scientist_card:
        Get.find<ScientistCardController>().loadScientistCardContent(block);
        break;
    }
  }

  // Open an editor and clear its previous content.
  void openEditor(ContentType type) {
    selectedContentType.value = type;

    switch (type) {
      case ContentType.paragraph:
        Get.find<ParagraphController>().clearParagraphEditor();
        break;
      case ContentType.card:
        Get.find<CardController>().clearCardEditor();
        break;
      case ContentType.highlight:
        Get.find<HighlightController>().clearHighlightEditor();
        break;
      case ContentType.image:
        Get.find<ImageController>().clearImageEditor();
        break;
      case ContentType.link:
        Get.find<LinkController>().clearLinkEditor();
        break;
      case ContentType.quotation:
        Get.find<QuotationController>().clearQuotationEditor();
        break;
      case ContentType.related_content:
        Get.find<RelatedContentController>().clearRelatedContentEditor();
        break;
      case ContentType.scientist_card:
        Get.find<ScientistCardController>().clearScientistCardEditor();
        break;
    }
  }

  // Close the editor.
  void closeEditor() {
    selectedContentType.value = null;
    selectedBlockId.value = null;
  }

  // Scroll the left panel to the bottom.
  Future<void> scrollToBottom() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!leftPanelScrollController.hasClients) return;

      leftPanelScrollController.animateTo(
        leftPanelScrollController.position.maxScrollExtent + 50,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

  // Temporarily highlight a block.
  Future<void> animateBlock(String blockId) async {
    animatedBlockId.value = blockId;

    await Future.delayed(const Duration(milliseconds: 1500));

    if (animatedBlockId.value == blockId) {
      animatedBlockId.value = null;
    }
  }

  @override
  void onClose() {
    leftPanelScrollController.dispose();
    quillController.dispose();
    super.onClose();
  }
}
