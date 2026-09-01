import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/controllers/story_blocks_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/quotation/quotation_content.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/content_type.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/story_block_model.dart';

class QuotationController extends GetxController {
  final storyBlocksController = Get.find<StoryBlocksController>();
  final formKey = GlobalKey<FormState>();

  final labelController = TextEditingController();
  final quoteTextController = TextEditingController();
  final authorController = TextEditingController();

  StoryBlockModel? editingBlock;
  final RxBool isLoading = false.obs;

  // Create the Quotation block
  Future<void> createQuotationBlock() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;
      final content = QuotationContent(
        author: authorController.text.trim().toString(),
        quote: quoteTextController.text.trim().toString(),
      );
      final block = StoryBlockModel(
        type: ContentType.quotation,
        label: labelController.text.trim(),
        content: content.toJson(),
      );
      final createdStoryBlock = await storyBlocksController.createStoryBlock(
        block,
      );

      storyBlocksController.closeEditor();

      clearQuotationEditor();
    } catch (err) {
      Get.snackbar("Error", err.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Update the Quotation Block
  Future<void> updateQuotationBlock() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;
      final content = QuotationContent(
        author: authorController.text.trim(),
        quote: quoteTextController.text.trim(),
      );
      final block = StoryBlockModel(
        id: editingBlock!.id,
        storyId: editingBlock!.storyId,
        type: ContentType.quotation,
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
      clearQuotationEditor();
    }
  }

  // Loading the Quotation block
  void loadQuotationContent(StoryBlockModel block) {
    editingBlock = block;
    labelController.text = block.label ?? "";

    quoteTextController.text = block.content?["quote"] ?? "";
    authorController.text = block.content?["author"] ?? "";
  }

  // Clear Quotation Editor
  void clearQuotationEditor() {
    labelController.clear();
    authorController.clear();
    quoteTextController.clear();
    editingBlock = null;
  }
}
