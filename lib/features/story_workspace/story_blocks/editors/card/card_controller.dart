import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/controllers/story_blocks_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/card/card_content.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/content_type.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/story_block_model.dart';

class CardController extends GetxController {
  final storyBlocksController = Get.find<StoryBlocksController>();
  final formKey = GlobalKey<FormState>();

  final labelController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  StoryBlockModel? editingBlock;
  final RxBool isLoading = false.obs;

  // Create the Card block
  Future<void> createCardBlock() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;
      final content = CardContent(
        description: descriptionController.text.trim().toString(),
        title: titleController.text.trim().toString(),
      );
      final block = StoryBlockModel(
        type: ContentType.card,
        label: labelController.text.trim(),
        content: content.toJson(),
      );
      final createdStoryBlock = await storyBlocksController.createStoryBlock(
        block,
      );

      storyBlocksController.closeEditor();

      clearCardEditor();
    } catch (err) {
      Get.snackbar("Error", err.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Update the Card Block
  Future<void> updateCardBlock() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;
      final content = CardContent(
        description: descriptionController.text.trim(),
        title: titleController.text.trim(),
      );
      final block = StoryBlockModel(
        id: editingBlock!.id,
        storyId: editingBlock!.storyId,
        type: ContentType.card,
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
      clearCardEditor();
    }
  }

  // Loading the Card block
  void loadCardContent(StoryBlockModel block) {
    editingBlock = block;
    labelController.text = block.label ?? "";

    descriptionController.text = block.content?["description"] ?? "";
    titleController.text = block.content?["title"] ?? "";
  }

  // Clear Card Editor
  void clearCardEditor() {
    labelController.clear();
    descriptionController.clear();
    titleController.clear();
    editingBlock = null;
  }
}
