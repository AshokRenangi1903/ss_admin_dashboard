import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/controllers/story_blocks_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/scientist_card/scientist_card_content.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/content_type.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/story_block_model.dart';

class ScientistCardController extends GetxController {
  @override
  void onInit() {
    quillController = QuillController.basic();
    super.onInit();
  }

  final storyBlocksController = Get.find<StoryBlocksController>();
  final formKey = GlobalKey<FormState>();

  final labelController = TextEditingController();
  final titleController = TextEditingController();
  final birthController = TextEditingController();
  final deathController = TextEditingController();
  final scientistNameController = TextEditingController();
  final scientistImageUrlController = TextEditingController();
  late final QuillController quillController;

  StoryBlockModel? editingBlock;
  final RxBool isLoading = false.obs;

  // Create the Scientist Card block
  Future<void> createScientistCardBlock() async {
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
      final content = ScientistCardContent(
        descriptionOps: quillController.document.toDelta().toJson(),
        title: titleController.text.trim(),
        birth: birthController.text.trim(),
        death: deathController.text.trim(),
        imageUrl: scientistImageUrlController.text.trim(),
        scientistName: scientistNameController.text.trim(),
      );
      final block = StoryBlockModel(
        type: ContentType.scientist_card,
        label: labelController.text.trim(),
        content: content.toJson(),
      );
      final createdStoryBlock = await storyBlocksController.createStoryBlock(
        block,
      );

      storyBlocksController.closeEditor();

      clearScientistCardEditor();
    } catch (err) {
      Get.snackbar("Error", err.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Update the Scientist Card Block
  Future<void> updateScientistCardBlock() async {
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
      final content = ScientistCardContent(
        descriptionOps: quillController.document.toDelta().toJson(),
        title: titleController.text.trim(),
        birth: birthController.text.trim(),
        death: deathController.text.trim(),
        imageUrl: scientistImageUrlController.text.trim(),
        scientistName: scientistNameController.text.trim(),
      );
      final block = StoryBlockModel(
        id: editingBlock!.id,
        storyId: editingBlock!.storyId,
        type: ContentType.scientist_card,
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
      clearScientistCardEditor();
    }
  }

  // Clear Scientist Card Editor
  void clearScientistCardEditor() {
    labelController.clear();
    quillController.clear();
    titleController.clear();
    scientistNameController.clear();
    birthController.clear();
    deathController.clear();
    scientistImageUrlController.clear();
    editingBlock = null;
  }

  // Loading the Highlight block
  void loadScientistCardContent(StoryBlockModel block) {
    editingBlock = block;
    labelController.text = block.label ?? "";
    titleController.text = block.content?["title"] ?? "";
    birthController.text = block.content?["birth"] ?? "";
    deathController.text = block.content?["death"] ?? "";
    scientistImageUrlController.text = block.content?["imageUrl"] ?? "";
    scientistNameController.text = block.content?["scientistName"] ?? "";

    final descriptionOps = block.content?['descriptionOps'];
    if (descriptionOps != null) {
      quillController.document = Document.fromJson(
        List<Map<String, dynamic>>.from(descriptionOps),
      );
    }
  }

  @override
  void onClose() {
    labelController.dispose();
    quillController.dispose();
    super.onClose();
  }
}
