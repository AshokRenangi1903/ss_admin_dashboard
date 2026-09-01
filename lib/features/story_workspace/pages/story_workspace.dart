import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
import 'package:ss_admin_dashboard/features/story_workspace/widgets/story_workspace_body.dart';
import 'package:ss_admin_dashboard/features/story_workspace/widgets/story_workspace_header.dart';
import 'package:ss_admin_dashboard/features/story_workspace/widgets/story_workspace_stepper.dart';

class StoryWorkspace extends StatelessWidget {
  const StoryWorkspace({super.key});

  @override
  Widget build(BuildContext context) {
    final storyWorkspaceController = Get.put(StoryWorkspaceController());
    final storyBlocksController = Get.put(StoryBlocksController());
    final paragraphController = Get.put(ParagraphController());
    final imageController = Get.put(ImageController());
    final cardController = Get.put(CardController());
    final highlightController = Get.put(HighlightController());
    final quotationController = Get.put(QuotationController());
    final linkController = Get.put(LinkController());
    final relatedContentController = Get.put(RelatedContentController());
    final scientistController = Get.put(ScientistCardController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StoryWorkspaceHeader(),
            Center(child: StoryWorkspaceStepper()),
            Expanded(child: StoryWorkspaceBody()),
          ],
        ),
      ),
    );
  }
}
