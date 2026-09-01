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
  @override
  void onInit() {
    super.onInit();
    getStoryBlocks();
    quillController = QuillController.basic();
  }

  final storyWorkspaceController = Get.find<StoryWorkspaceController>();
  final _repository = StoryBlockRepository();
  Rxn<ContentType> selectedContentType = Rxn<ContentType>();
  late final QuillController quillController;

  final ScrollController leftPanelScrollController = ScrollController();
  final storyBlocksResponse = ApiResponse<List<StoryBlockModel>>.loading().obs;
  final RxBool isLoading = false.obs;
  final RxnString selectedBlockId = RxnString();
  final RxnString animatedBlockId = RxnString();
  final RxBool isOrderChanged = false.obs;

  // Get StoryBlocks of a Story
  Future<void> getStoryBlocks() async {
    final storyId = storyWorkspaceController.story.id!;
    try {
      storyBlocksResponse.value = ApiResponse.loading();
      final storyBlocks = await _repository.getStoryBlocks(storyId);
      storyBlocksResponse.value = ApiResponse.completed(storyBlocks);
    } catch (err) {
      storyBlocksResponse.value = ApiResponse.error(err.toString());
    }
  }

  // Create a new Story Block
  Future<StoryBlockModel> createStoryBlock(StoryBlockModel block) async {
    final storyId = storyWorkspaceController.story.id!;
    final createdStoryBlock = await _repository.createStoryBlock(
      block,
      storyId,
    );
    storyBlocksResponse.value.data!.add(createdStoryBlock);
    storyBlocksResponse.refresh();
    storyWorkspaceController.story.updatedAt = DateTime.now().toIso8601String();
    await scrollToBottom();
    await animateBlock(createdStoryBlock.id!);
    return createdStoryBlock;
  }

  // Update a StoryBlock
  Future<StoryBlockModel> updateStoryBlock(StoryBlockModel block) async {
    final updatedStoryBlock = await _repository.updateStoryBlock(
      block,
      block.id!,
    );
    final index = storyBlocksResponse.value.data!.indexWhere(
      (e) => e.id == updatedStoryBlock.id,
    );
    storyWorkspaceController.story.updatedAt = DateTime.now().toIso8601String();
    if (index != -1) {
      storyBlocksResponse.value.data![index] = updatedStoryBlock;
      storyBlocksResponse.refresh();
    }
    await animateBlock(updatedStoryBlock.id!);

    return updatedStoryBlock;
  }

  // Delete a Story Block
  Future<void> deleteStoryBlock(StoryBlockModel block) async {
    try {
      isLoading.value = true;
      await _repository.deleteStoryBlock(block.id!);
      closeEditor();
      storyBlocksResponse.value.data!.removeWhere((e) => e.id == block.id);

      storyBlocksResponse.refresh();
      storyWorkspaceController.story.updatedAt = DateTime.now()
          .toIso8601String();
    } catch (error) {
      Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // --------------------------------
  // Reorder Blocks Started
  // --------------------------------
  void reorderBlocks(int oldIndex, int newIndex) {
    final blocks = storyBlocksResponse.value.data!;

    if (newIndex > oldIndex) {
      newIndex--;
    }

    final block = blocks.removeAt(oldIndex);
    blocks.insert(newIndex, block);

    storyBlocksResponse.refresh();
    storyWorkspaceController.story.updatedAt = DateTime.now().toIso8601String();
    isOrderChanged.value = true;
  }

  Future<void> saveBlockOrder() async {
    final blocks = storyBlocksResponse.value.data!;

    final orderedIds = blocks.map((block) => block.id!).toList();
    try {
      isLoading.value = true;

      await _repository.reorderStoryBlocks(
        orderedIds,
        storyWorkspaceController.story.id!,
      );

      isOrderChanged.value = false;
    } catch (error) {
      Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // --------------------------------
  // Reorder Blocks Ended
  // --------------------------------

  // load storyblock
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

  // Open Editor
  void openEditor(ContentType type) async {
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

  // Scroll To Bottom
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

  // Animate new block
  Future<void> animateBlock(String blockId) async {
    animatedBlockId.value = blockId;

    await Future.delayed(const Duration(milliseconds: 1500));

    if (animatedBlockId.value == blockId) {
      animatedBlockId.value = null;
    }
  }

  // Close Editor
  void closeEditor() {
    selectedContentType.value = null;
    selectedBlockId.value = null;
  }

  // Onclose
  @override
  void onClose() {
    leftPanelScrollController.dispose();
    super.onClose();
  }
}
