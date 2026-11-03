import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/core/response/status.dart';
import 'package:ss_admin_dashboard/core/routes/routes_name.dart';
import 'package:ss_admin_dashboard/features/era/controller/era_controller.dart';
import 'package:ss_admin_dashboard/features/era/widgets/era_stories_header.dart';
import 'package:ss_admin_dashboard/features/story/controller/story_controller.dart';
import 'package:ss_admin_dashboard/features/story/widgets/shimmer_story_list.dart';
import 'package:ss_admin_dashboard/features/story/widgets/story_card.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/empty_box.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';

class EraStoriesPage extends StatefulWidget {
  const EraStoriesPage({super.key});

  @override
  State<EraStoriesPage> createState() => _EraStoriesPageState();
}

class _EraStoriesPageState extends State<EraStoriesPage> {
  late final String eraId;
  late final EraController eraController;
  late final StoryController storyController;

  @override
  void initState() {
    super.initState();

    eraId = Get.parameters['eraId']!;
    eraController = Get.find<EraController>();
    storyController = Get.find<StoryController>();

    storyController.selectedEraId.value = eraId;
    storyController.isOrderChanged.value = false;

    storyController.getEraStories(eraId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Obx(() {
            final era = eraController.getEraById(eraId);

            if (era == null) {
              return const SizedBox(
                height: 80,
                child: Center(child: CircularProgressIndicator()),
              );
            }

            return EraStoriesHeader(
              eraTitle: era.title ?? 'Untitled Era',
              eraDescription: era.description ?? '',
              storiesCount: era.storiesCount ?? 0,
            );
          }),
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
                      Text(response.message ?? 'Something went wrong'),
                    ],
                  );

                case Status.completed:
                  final stories = response.data ?? [];

                  if (stories.isEmpty) {
                    return EmptyBox();
                  }

                  return Column(
                    children: [
                      storyController.isOrderChanged.value
                          ? AppButton(
                              text: storyController.isLoading.value
                                  ? 'Reordering...'
                                  : 'Reorder',
                              onPressed: () async {
                                await storyController.saveStoriesOrder();
                              },
                            )
                          : const SizedBox.shrink(),
                      Expanded(
                        child: ReorderableListView.builder(
                          scrollController:
                              storyController.storiesScrollController,
                          itemCount: stories.length,
                          onReorderItem: (oldIndex, newIndex) {
                            storyController.reorderStories(oldIndex, newIndex);
                          },
                          itemBuilder: (context, index) {
                            final story = stories[index];

                            return KeyedSubtree(
                              key: ValueKey(story.id),
                              child: StoryCard(
                                description: story.description ?? '',
                                title: story.title ?? 'Untitled Story',
                                imageUrl: story.imageUrl ?? '',
                                eraTitle: story.era?.title ?? '',
                                updatedAt: story.updatedAt!,
                                onTap: () {
                                  Get.toNamed(
                                    RoutesName.storyWorkspace.replaceFirst(
                                      ':storyId',
                                      story.id!,
                                    ),
                                    arguments: {
                                      'returnTo': RoutesName.eraStories
                                          .replaceFirst(':eraId', eraId),
                                    },
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
                  return const Center(child: Text('Working...'));
              }
            }),
          ),
        ],
      ),
    );
  }
}
