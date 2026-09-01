import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/core/response/status.dart';
import 'package:ss_admin_dashboard/core/routes/routes_name.dart';
import 'package:ss_admin_dashboard/features/story/controller/story_controller.dart';
import 'package:ss_admin_dashboard/features/story/widgets/shimmer_story_list.dart';
import 'package:ss_admin_dashboard/features/story/widgets/story_card.dart';
import 'package:ss_admin_dashboard/features/story/widgets/story_dialogue.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/empty_box.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/loading_dots.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/rocket_loading.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';

class StoryGrid extends StatelessWidget {
  const StoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final storyController = Get.find<StoryController>();

    return Obx(() {
      final response = storyController.storiesResponse.value;

      switch (response.status) {
        case Status.loading:
          // return RocketLoading();
          return ShimmerStoryList();
        case Status.error:
          return Column(
            children: [
              EmptyBox(),
              Text(response.message ?? "Something went wrong"),
            ],
          );
        case Status.completed:
          // final stories = response.data!;
          final stories = storyController.filteredStories;
          if (stories.isEmpty) {
            return EmptyBox();
          }
          return ListView.builder(
            itemCount: stories.length,
            itemBuilder: (BuildContext context, int index) {
              if (stories.isEmpty) {
                return LoadingDots();
              }
              return StoryCard(
                onTap: () {
                  Get.toNamed(
                    RoutesName.storyWorkspace,
                    arguments: stories[index],
                  );
                },
                onDelete: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) {
                      return Obx(() {
                        final isLoading = storyController.isLoading.value;
                        return Stack(
                          children: [
                            AlertDialog(
                              content: Text(
                                "Do you really wnat to delete this story?",
                              ),
                              actions: [
                                AppButton(
                                  text: "Cancel",
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                AppButton(
                                  text: "Delete",
                                  backgroundColor: Colors.red,
                                  onPressed: () {
                                    storyController.deleteStory(
                                      stories[index].id!,
                                    );
                                  },
                                ),
                              ],
                            ),
                            if (isLoading) LoadingDots(),
                          ],
                        );
                      });
                    },
                  );
                },
                onEdit: () {
                  storyController.loadStoryDetails(stories[index]);
                  storyController.isUpdating.value = true;
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) {
                      return StoryDialogue(
                        title: "Update Story Details",
                        buttonText: "Update",
                        onSave: storyController.updateStory,
                      );
                    },
                  );
                },
                description: stories[index].description!,
                title: stories[index].title!,
                imageUrl: stories[index].imageUrl!,
                eraTitle: stories[index].era!.title!,
                updatedAt: stories[index].updatedAt!,
              );
            },
          );

        default:
          return const SizedBox(child: Text("working"));
      }
    });
  }
}
