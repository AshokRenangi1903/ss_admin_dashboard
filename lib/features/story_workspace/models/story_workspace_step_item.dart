import 'package:flutter/material.dart';
import 'package:ss_admin_dashboard/features/story_workspace/models/story_workspace_step.dart';
import 'package:ss_admin_dashboard/features/story_workspace/pages/steps/story_blocks_step.dart';
import 'package:ss_admin_dashboard/features/story_workspace/pages/steps/story_details_step.dart';
import 'package:ss_admin_dashboard/features/story_workspace/pages/steps/story_preview_publish_step.dart';

class StoryWorkspaceStepItem {
  final String title;
  final IconData? icon;
  final Widget body;
  final StoryWorkspaceStep step;
  const StoryWorkspaceStepItem({
    required this.title,
    required this.step,
    required this.body,
    this.icon,
  });
}

List<StoryWorkspaceStepItem> storyWorkspaceStepItems = [
  StoryWorkspaceStepItem(
    title: "Information",
    step: StoryWorkspaceStep.details,
    body: StoryDetailsStep(),
  ),
  StoryWorkspaceStepItem(
    title: "Blocks",
    step: StoryWorkspaceStep.blocks,
    body: StoryBlocksStep(),
  ),
  StoryWorkspaceStepItem(
    title: "Preview & Publish",
    step: StoryWorkspaceStep.preview,
    body: StoryPreviewPublishStep(),
  ),
];
