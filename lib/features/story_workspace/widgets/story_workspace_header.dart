import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/controllers/story_workspace_controller.dart';

class StoryWorkspaceHeader extends StatelessWidget {
  final String? title, description;

  const StoryWorkspaceHeader({super.key, this.description, this.title});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StoryWorkspaceController>();

    return Obx(() {
      final story = controller.story.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? story?.title ?? 'Story Title',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            'Description: ${description ?? story?.description ?? ''}',
            maxLines: 1,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 14,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    });
  }
}
