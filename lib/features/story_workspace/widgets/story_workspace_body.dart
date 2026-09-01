import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/controllers/story_workspace_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/pages/steps/story_blocks_step.dart';
import 'package:ss_admin_dashboard/features/story_workspace/pages/steps/story_details_step.dart';
import 'package:ss_admin_dashboard/features/story_workspace/pages/steps/story_preview_publish_step.dart';

class StoryWorkspaceBody extends StatelessWidget {
  const StoryWorkspaceBody({super.key});

  @override
  Widget build(BuildContext context) {
    final storyWorkspaceController = Get.find<StoryWorkspaceController>();
    return Obx(() {
      switch (storyWorkspaceController.currentStep.value) {
        case 0:
          return SingleChildScrollView(child: StoryDetailsStep());
        case 1:
          return StoryBlocksStep();
        case 2:
          return SingleChildScrollView(child: StoryPreviewPublishStep());
        default:
          return Center(child: Text("default block"));
      }
    });
  }
}
