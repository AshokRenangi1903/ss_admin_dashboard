import 'package:flutter/material.dart';
import 'package:ss_admin_dashboard/features/story_workspace/widgets/story_workspace_body.dart';
import 'package:ss_admin_dashboard/features/story_workspace/widgets/story_workspace_header.dart';
import 'package:ss_admin_dashboard/features/story_workspace/widgets/story_workspace_stepper.dart';

class StoryWorkspace extends StatelessWidget {
  const StoryWorkspace({super.key});

  @override
  Widget build(BuildContext context) {
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
