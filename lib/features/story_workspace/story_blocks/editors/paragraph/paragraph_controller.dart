import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/controllers/story_blocks_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/paragraph/paragraph_content.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/content_type.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/story_block_model.dart';

class ParagraphController extends GetxController {
  @override
  void onInit() {
    quillController = QuillController.basic();
    super.onInit();
  }

  final storyBlocksController = Get.find<StoryBlocksController>();

  final formKey = GlobalKey<FormState>();
  late final QuillController quillController;
  final labelController = TextEditingController();
  RxBool isLoading = false.obs;
  StoryBlockModel? editingBlock;

  // Creating a Paragraph Block.
  Future<void> createParagraphBlock() async {
    final quillText = quillController.document.toPlainText().trim();
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (quillText.isEmpty) {
      Get.snackbar("Validation", "Paragraph content is required");
      return;
    }

    try {
      isLoading.value = true;
      final content = ParagraphContent(
        ops: quillController.document.toDelta().toJson(),
      );
      final block = StoryBlockModel(
        type: ContentType.paragraph,
        label: labelController.text.trim(),
        content: content.toJson(),
      );
      final createdStoryBlock = await storyBlocksController.createStoryBlock(
        block,
      );

      storyBlocksController.closeEditor();

      clearParagraphEditor();
    } catch (err) {
      Get.snackbar("Error", err.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Update the Paragraph Block
  Future<void> updateParagraphBlock() async {
    final quillText = quillController.document.toPlainText().trim();
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (quillText.isEmpty) {
      Get.snackbar("Validation", "Paragraph content is required");
      return;
    }

    try {
      isLoading.value = true;
      final content = ParagraphContent(
        ops: quillController.document.toDelta().toJson(),
      );
      final block = StoryBlockModel(
        id: editingBlock!.id,
        storyId: editingBlock!.storyId,
        type: ContentType.paragraph,
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
      clearParagraphEditor();
    }
  }

  // Loading the paragraph
  void loadParagraphContent(StoryBlockModel block) {
    editingBlock = block;
    labelController.text = block.label ?? "";

    final ops = block.content?['ops'];
    if (ops != null) {
      quillController.document = Document.fromJson(
        List<Map<String, dynamic>>.from(ops),
      );
    }
  }

  // Clear paragraph Editor
  void clearParagraphEditor() {
    labelController.clear();
    quillController.clear();
    editingBlock = null;
  }

  @override
  void onClose() {
    labelController.dispose();
    quillController.dispose();
    super.onClose();
  }
}
