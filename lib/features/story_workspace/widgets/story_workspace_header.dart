import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/controllers/story_workspace_controller.dart';

class StoryWorkspaceHeader extends StatelessWidget {
  final String? title, description;
  const StoryWorkspaceHeader({super.key, this.description, this.title});

  @override
  Widget build(BuildContext context) {
    final storyWorkspaceController = Get.find<StoryWorkspaceController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          storyWorkspaceController.story.title ?? "Story Title",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(
          "Description: ${storyWorkspaceController.story.description}",
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 14,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
