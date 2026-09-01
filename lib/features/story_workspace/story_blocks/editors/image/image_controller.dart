import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/controllers/story_blocks_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/image/image_content.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/content_type.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/story_block_model.dart';

class ImageController extends GetxController {
  @override
  void onInit() {
    quillController = QuillController.basic();
    super.onInit();
  }

  final storyBlocksController = Get.find<StoryBlocksController>();
  final formKey = GlobalKey<FormState>();
  final labelController = TextEditingController();
  final titleController = TextEditingController();
  final imageUrlController = TextEditingController();
  StoryBlockModel? editingBlock;

  late final QuillController quillController;
  final RxBool isLoading = false.obs;

  // Create the Image block
  Future<void> createImageBlock() async {
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
      final content = ImageContent(
        imageUrl: imageUrlController.text.trim().toString(),
        captionOps: quillController.document.toDelta().toJson(),
        title: titleController.text.trim().toString(),
      );
      final block = StoryBlockModel(
        type: ContentType.image,
        label: labelController.text.trim(),
        content: content.toJson(),
      );
      final createdStoryBlock = await storyBlocksController.createStoryBlock(
        block,
      );

      storyBlocksController.closeEditor();

      clearImageEditor();
    } catch (err) {
      Get.snackbar("Error", err.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Update the Image Block
  Future<void> updateImageBlock() async {
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
      final content = ImageContent(
        imageUrl: imageUrlController.text.trim(),
        captionOps: quillController.document.toDelta().toJson(),
        title: titleController.text.trim(),
      );
      final block = StoryBlockModel(
        id: editingBlock!.id,
        storyId: editingBlock!.storyId,
        type: ContentType.image,
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
      clearImageEditor();
    }
  }

  // Loading the image block
  void loadImageContent(StoryBlockModel block) {
    editingBlock = block;
    labelController.text = block.label ?? "";
    imageUrlController.text = block.content?["imageUrl"] ?? "";

    final captionOps = block.content?['captionOps'];
    if (captionOps != null) {
      quillController.document = Document.fromJson(
        List<Map<String, dynamic>>.from(captionOps),
      );
    }
    titleController.text = block.content?["title"] ?? "";
  }

  // Clear Editor
  void clearImageEditor() {
    labelController.clear();
    quillController.clear();
    imageUrlController.clear();
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
