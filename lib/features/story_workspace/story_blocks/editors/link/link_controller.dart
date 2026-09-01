import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/controllers/story_blocks_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/link/link_content.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/content_type.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/story_block_model.dart';

class LinkController extends GetxController {
  final storyBlocksController = Get.find<StoryBlocksController>();
  final formKey = GlobalKey<FormState>();

  final labelController = TextEditingController();
  final titleController = TextEditingController();
  final urlController = TextEditingController();

  StoryBlockModel? editingBlock;
  final RxBool isLoading = false.obs;

  // Create the Link block
  Future<void> createLinkBlock() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;
      final content = LinkContent(
        title: titleController.text.trim(),
        url: urlController.text.trim(),
      );
      final block = StoryBlockModel(
        type: ContentType.link,
        label: labelController.text.trim(),
        content: content.toJson(),
      );
      
      final createdStoryBlock = await storyBlocksController.createStoryBlock(
        block,
      );

      storyBlocksController.closeEditor();

      clearLinkEditor();
    } catch (err) {
      Get.snackbar("Error", err.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Update the Link Block
  Future<void> updateLinkBlock() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;
      final content = LinkContent(
        title: titleController.text.trim(),
        url: urlController.text.trim(),
      );
      final block = StoryBlockModel(
        id: editingBlock!.id,
        storyId: editingBlock!.storyId,
        type: ContentType.link,
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
      clearLinkEditor();
    }
  }

  // Loading the Card block
  void loadLinkContent(StoryBlockModel block) {
    editingBlock = block;
    labelController.text = block.label ?? "";

    titleController.text = block.content?["title"] ?? "";
    urlController.text = block.content?["url"] ?? "";
  }

  // Clear Card Editor
  void clearLinkEditor() {
    labelController.clear();
    titleController.clear();
    urlController.clear();
    editingBlock = null;
  }
}
