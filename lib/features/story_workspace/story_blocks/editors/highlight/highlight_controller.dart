import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/controllers/story_blocks_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/highlight/highlight_content.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/content_type.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/story_block_model.dart';

class HighlightController extends GetxController {
  @override
  void onInit() {
    quillController = QuillController.basic();
    super.onInit();
  }

  final storyBlocksController = Get.find<StoryBlocksController>();
  final formKey = GlobalKey<FormState>();

  final labelController = TextEditingController();
  final titleController = TextEditingController();
  late final QuillController quillController;

  StoryBlockModel? editingBlock;
  final RxBool isLoading = false.obs;

  // Create the Highlight block
  Future<void> createHighlightBlock() async {
    final quillText = quillController.document.toPlainText().trim();
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (quillText.isEmpty) {
      Get.snackbar("Validation", "Related Content content is required");
      return;
    }
    try {
      isLoading.value = true;
      final content = HighlightContent(
        descriptionOps: quillController.document.toDelta().toJson(),
        title: titleController.text.trim().toString(),
      );
      final block = StoryBlockModel(
        type: ContentType.highlight,
        label: labelController.text.trim(),
        content: content.toJson(),
      );
      final createdStoryBlock = await storyBlocksController.createStoryBlock(
        block,
      );

      storyBlocksController.closeEditor();

      clearHighlightEditor();
    } catch (err) {
      Get.snackbar("Error", err.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Update the Highlight Block
  Future<void> updateHighlightBlock() async {
    final quillText = quillController.document.toPlainText().trim();
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (quillText.isEmpty) {
      Get.snackbar("Validation", "Related Content content is required");
      return;
    }
    try {
      isLoading.value = true;
      final content = HighlightContent(
        descriptionOps: quillController.document.toDelta().toJson(),
        title: titleController.text.trim(),
      );
      final block = StoryBlockModel(
        id: editingBlock!.id,
        storyId: editingBlock!.storyId,
        type: ContentType.highlight,
        label: labelController.text.trim(),
        content: content.toJson(),
        position: editingBlock!.position,
      );
      final updatedStoryBlock = await storyBlocksController.updateStoryBlock(
        block,
      );

      storyBlocksController.closeEditor();
    } catch (err) {
      Get.snackbar("Error", err.toString());
    } finally {
      isLoading.value = false;
      clearHighlightEditor();
    }
  }

  // Loading the Highlight block
  void loadHighlightContent(StoryBlockModel block) {
    editingBlock = block;
    labelController.text = block.label ?? "";

    final descriptionOps = block.content?['descriptionOps'];
    if (descriptionOps != null) {
      quillController.document = Document.fromJson(
        List<Map<String, dynamic>>.from(descriptionOps),
      );
    }
    titleController.text = block.content?["title"] ?? "";
  }

  // Clear Highlight Editor
  void clearHighlightEditor() {
    labelController.clear();
    quillController.clear();
    titleController.clear();
    editingBlock = null;
  }

  @override
  void onClose() {
    labelController.dispose();
    quillController.dispose();
    super.onClose();
  }
}
