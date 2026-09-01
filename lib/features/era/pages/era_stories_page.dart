import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/core/response/status.dart';
import 'package:ss_admin_dashboard/core/routes/routes_name.dart';
import 'package:ss_admin_dashboard/features/era/model/era_model.dart';
import 'package:ss_admin_dashboard/features/era/widgets/era_stories_header.dart';
import 'package:ss_admin_dashboard/features/story/controller/story_controller.dart';
import 'package:ss_admin_dashboard/features/story/widgets/shimmer_story_list.dart';
import 'package:ss_admin_dashboard/features/story/widgets/story_card.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/empty_box.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/loading_dots.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';

class EraStoriesPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final era = Get.arguments as EraModel;
    final storyController = Get.find<StoryController>();
    return Scaffold(
      body: Column(
        children: [
          EraStoriesHeader(
            eraTitle: era.title!,
            eraDescription: era.description!,
            storiesCount: era.storiesCount!,
          ),

          Expanded(
            child: Obx(() {
              final response = storyController.eraStoriesResponse.value;

              switch (response.status) {
                case Status.loading:
                  return ShimmerStoryList();
                case Status.error:
                  return Column(
                    children: [
                      EmptyBox(),
                      Text(response.message ?? "Something went wrong"),
                    ],
                  );
                case Status.completed:
                  final stories = response.data!;
                  if (stories.isEmpty) {
                    return EmptyBox();
                  }
                  return Column(
                    children: [
                      storyController.isOrderChanged.value
                          ? AppButton(
                              text: storyController.isLoading.value
                                  ? "Reordering.."
                                  : "Reorder",
                              onPressed: () async {
                                await storyController.saveStoriesOrder();
                              },
                            )
                          : SizedBox.shrink(),

                      // ------------------
                      // List view of the Stories
                      // ------------------
                      Expanded(
                        child: ReorderableListView.builder(
                          scrollController:
                              storyController.storiesScrollController,
                          onReorderItem: (oldIndex, newIndex) {
                            storyController.reorderStories(oldIndex, newIndex);
                          },
                          itemCount: stories.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (stories.isEmpty) {
                              return LoadingDots();
                            }
                            return KeyedSubtree(
                              key: ValueKey(stories[index].id),
                              child: StoryCard(
                                description: stories[index].description!,
                                title: stories[index].title!,
                                imageUrl: stories[index].imageUrl!,
                                eraTitle: stories[index].era!.title!,
                                updatedAt: stories[index].updatedAt!,
                                onTap: () {
                                  Get.toNamed(
                                    RoutesName.storyWorkspace,
                                    arguments: stories[index],
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );

                default:
                  return const SizedBox(child: Text("working"));
              }
            }),
          ),
        ],
      ),
    );
  }
}
