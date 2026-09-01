import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/controllers/story_blocks_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/story_block_item.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class ShowBlocks extends StatelessWidget {
  const ShowBlocks({super.key});

  @override
  Widget build(BuildContext context) {
    final storyBlocksController = Get.find<StoryBlocksController>();
    return Center(
      child: Container(
        height: Get.height * 0.8,
        width: Get.width * 0.6,
        decoration: BoxDecoration(
          color: AppColors.fillColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Number of columns
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              // childAspectRatio: 0.85, // Controls item height/width ratio
            ),
            itemCount: storyBlockItems.length,
            itemBuilder: ((context, index) {
              return InkWell(
                onTap: () {
                  Get.back();
                  storyBlocksController.openEditor(storyBlockItems[index].type);
                },
                child: Card(
                  color: AppColors.primaryColor,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          storyBlockItems[index].icon,
                          color: AppColors.white,
                          size: 30,
                        ),
                        Text(
                          storyBlockItems[index].title,
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
