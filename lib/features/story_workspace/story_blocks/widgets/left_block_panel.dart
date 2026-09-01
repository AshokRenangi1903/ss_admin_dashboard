import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/core/response/status.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/controllers/story_blocks_controller.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/empty_box.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/loading_dots.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/rocket_loading.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';

class LeftBlockPanel extends StatelessWidget {
  const LeftBlockPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final storyBlocksController = Get.find<StoryBlocksController>();
    return Obx(() {
      final response = storyBlocksController.storyBlocksResponse.value;

      switch (response.status) {
        case Status.loading:
          return RocketLoading();
        case Status.error:
          return Column(
            children: [
              EmptyBox(),
              Text(response.message ?? "Something went wrong"),
            ],
          );
        case Status.completed:
          final storyBlocks = response.data!;
          if (storyBlocks.isEmpty) {
            return Center(child: EmptyBox());
          }

          return Column(
            children: [
              storyBlocksController.isOrderChanged.value
                  ? AppButton(
                      text: storyBlocksController.isLoading.value
                          ? "Reordering.."
                          : "Reorder",
                      onPressed: () {
                        storyBlocksController.saveBlockOrder();
                      },
                    )
                  : SizedBox.shrink(),
              Expanded(
                child: ReorderableListView.builder(
                  scrollController:
                      storyBlocksController.leftPanelScrollController,
                  onReorderItem: (oldIndex, newIndex) {
                    storyBlocksController.reorderBlocks(oldIndex, newIndex);
                  },
                  itemCount: storyBlocks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return KeyedSubtree(
                      key: ValueKey(storyBlocks[index].id),
                      child: Obx(() {
                        final block = storyBlocks[index];
                        final bool selectedBlock =
                            storyBlocksController.selectedBlockId.value ==
                            block.id;
                        final animated =
                            storyBlocksController.animatedBlockId.value ==
                            block.id;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,

                          decoration: BoxDecoration(
                            color: animated
                                ? Colors.orange.shade100
                                : selectedBlock
                                ? AppColors.primaryColor
                                : Colors.white,
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: ListTile(
                              onTap: () {
                                storyBlocksController.loadBlock(block);
                              },
                              tileColor: Colors.transparent,

                              title: Text(block.label ?? "No label"),
                              trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (_) {
                                      return Obx(() {
                                        final isLoading = storyBlocksController
                                            .isLoading
                                            .value;
                                        return Stack(
                                          children: [
                                            AlertDialog(
                                              content: Text(
                                                "Do you really want to delete this ${block.label}?",
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
                                                  onPressed: () async {
                                                    await storyBlocksController
                                                        .deleteStoryBlock(
                                                          block,
                                                        );
                                                    Get.back();
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
                                icon: Icon(Icons.delete),
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
            ],
          );

        default:
          return const SizedBox(child: Text("working"));
      }
    });
  }
}
