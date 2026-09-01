import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/controllers/story_blocks_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/related_content/related_content.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/related_content/related_content_section.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/content_type.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/story_block_model.dart';

class RelatedContentController extends GetxController {
  @override
  void onInit() {
    quillController = QuillController.basic();
    super.onInit();
  }

  final storyBlocksController = Get.find<StoryBlocksController>();

  final formKey = GlobalKey<FormState>();
  late final QuillController quillController;
  final selectedSection = RelatedContentSection.present.obs;

  final labelController = TextEditingController();
  RxBool isLoading = false.obs;
  StoryBlockModel? editingBlock;

  // Creating a Related Content Block.
  Future<void> createRelatedContentBlock() async {
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
      final content = RelatedContent(
        section: selectedSection.value.name,
        ops: quillController.document.toDelta().toJson(),
      );
      final block = StoryBlockModel(
        type: ContentType.related_content,
        label: labelController.text.trim(),
        content: content.toJson(),
      );
      final createdStoryBlock = await storyBlocksController.createStoryBlock(
        block,
      );

      storyBlocksController.closeEditor();

      clearRelatedContentEditor();
    } catch (err) {
      Get.snackbar("Error", err.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Update the Related Content Block
  Future<void> updateRelatedContentBlock() async {
    final quillText = quillController.document.toPlainText().trim();
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (quillText.isEmpty) {
      Get.snackbar("Validation", "Related content is required");
      return;
    }

    try {
      isLoading.value = true;
      final content = RelatedContent(
        section: selectedSection.value.name,
        ops: quillController.document.toDelta().toJson(),
      );
      final block = StoryBlockModel(
        id: editingBlock!.id,
        storyId: editingBlock!.storyId,
        type: ContentType.related_content,
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
      clearRelatedContentEditor();
    }
  }

  // Loading the Related Content
  void loadRelatedContent(StoryBlockModel block) {
    editingBlock = block;
    labelController.text = block.label ?? "";

    selectedSection.value = RelatedContentSection.values.firstWhere(
      (e) => e.name == block.content?['section'],
    );

    final ops = block.content?['ops'];
    if (ops != null) {
      quillController.document = Document.fromJson(
        List<Map<String, dynamic>>.from(ops),
      );
    }
  }

  // Clear Relate Content Editor
  void clearRelatedContentEditor() {
    labelController.clear();
    selectedSection.value = RelatedContentSection.past;
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
