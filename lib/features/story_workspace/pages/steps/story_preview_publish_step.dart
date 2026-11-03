import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ss_admin_dashboard/features/story_workspace/controllers/story_workspace_controller.dart';
import 'package:ss_admin_dashboard/shared/helpers/format_date_time.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/controllers/story_blocks_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/widgets/preview_blocks/preview_story/preview_story_block_render.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/widgets/preview_blocks/preview_story/preview_story_header.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class StoryPreviewPublishStep extends StatelessWidget {
  const StoryPreviewPublishStep({super.key});

  @override
  Widget build(BuildContext context) {
    final storyBlocksController = Get.find<StoryBlocksController>();
    final storyWorkspaceController = Get.find<StoryWorkspaceController>();

    return Obx(() {
      final story = storyWorkspaceController.story.value;

      if (story == null) {
        return const Center(child: Text('Story details unavailable.'));
      }

      final storyBlocks =
          storyBlocksController.storyBlocksResponse.value.data ?? [];

      return Center(
        child: Theme(
          data: Theme.of(context).copyWith(
            textTheme: GoogleFonts.sourceSerif4TextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 390,
                height: 800,
                decoration: BoxDecoration(
                  color: AppColors.pageBgColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                        child: PreviewStoryHeader(
                          storyTitle: story.title ?? '',
                          storyDescription: story.description ?? '',
                          discipline: story.discipline ?? '',
                          subject: story.subject ?? '',
                          geolocation: story.geolocation ?? '',
                          scientists: story.scientistNames ?? [],
                          time: story.estimatedReadTime ?? '',
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            ...storyBlocks.map(
                              (block) => Column(
                                children: [
                                  PreviewStoryBlockRender(block: block),
                                  const SizedBox(height: 12),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        height: 100,
                        decoration: BoxDecoration(color: AppColors.blue),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Updated At',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                story.updatedAt == null
                                    ? 'Not available'
                                    : formatDateTime(story.updatedAt!),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
