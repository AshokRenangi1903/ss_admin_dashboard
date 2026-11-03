import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story/controller/story_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/controllers/story_workspace_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/controllers/story_blocks_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/card/card_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/highlight/highlight_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/image/image_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/link/link_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/paragraph/paragraph_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/quotation/quotation_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/related_content/related_content_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/scientist_card/scientist_card_controller.dart';

class StoryWorkspaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoryController>(() => StoryController());
    Get.lazyPut<StoryWorkspaceController>(() => StoryWorkspaceController());

    Get.lazyPut<StoryBlocksController>(() => StoryBlocksController());

    Get.lazyPut<ParagraphController>(() => ParagraphController());
    Get.lazyPut<CardController>(() => CardController());
    Get.lazyPut<HighlightController>(() => HighlightController());
    Get.lazyPut<ImageController>(() => ImageController());
    Get.lazyPut<LinkController>(() => LinkController());
    Get.lazyPut<QuotationController>(() => QuotationController());
    Get.lazyPut<RelatedContentController>(() => RelatedContentController());
    Get.lazyPut<ScientistCardController>(() => ScientistCardController());
  }
}
