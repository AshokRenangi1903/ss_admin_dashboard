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
                // padding: EdgeInsets.all(12),
                width: 390,
                height: 800,
                decoration: BoxDecoration(
                  color: AppColors.pageBgColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Story Details Heading
                      Padding(
                        padding: EdgeInsetsGeometry.fromLTRB(30, 30, 30, 0),
                        child: PreviewStoryHeader(
                          storyTitle:
                              storyWorkspaceController.story.title ?? "",
                          storyDescription:
                              storyWorkspaceController.story.description ?? "",
                          discipline:
                              storyWorkspaceController.story.discipline ?? "",
                          subject: storyWorkspaceController.story.subject ?? "",
                          geolocation:
                              storyWorkspaceController.story.geolocation ?? "",
                          scientists:
                              storyWorkspaceController.story.scientistNames ??
                              [],
                          time:
                              storyWorkspaceController
                                  .story
                                  .estimatedReadTime ??
                              "",
                        ),
                      ),

                      // Story Blocks Preview
                      Padding(
                        padding: EdgeInsetsGeometry.all(20),

                        child: Column(
                          children: [
                            ...storyBlocks.map(
                              (block) => Column(
                                children: [
                                  PreviewStoryBlockRender(block: block),
                                  SizedBox(height: 12),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Updated At Time Stamp
                      Container(
                        height: 100,
                        decoration: BoxDecoration(color: AppColors.blue),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Updated At",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                formatDateTime(
                                  storyWorkspaceController.story.updatedAt!,
                                ),
                                style: TextStyle(color: Colors.white),
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
