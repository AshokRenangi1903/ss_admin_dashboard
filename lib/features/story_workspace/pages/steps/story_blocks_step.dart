import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/controllers/story_blocks_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/widgets/left_block_panel.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/widgets/right_block_panel.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class StoryBlocksStep extends StatelessWidget {
  const StoryBlocksStep({super.key});

  @override
  Widget build(BuildContext context) {
    final storyBlocksController = Get.find<StoryBlocksController>();
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: Card(
            // color: Colors.red,
            child: LeftBlockPanel(),
          ),
        ),

        Container(height: Get.height, color: AppColors.primaryColor, width: 3),

        Expanded(
          child: SizedBox(
            child: Stack(
              children: [
                RightBlockPanel(),
                Obx(() {
                  return Positioned(
                    top: 8,
                    right: 8,

                    child:
                        storyBlocksController.selectedContentType.value == null
                        ? const SizedBox.shrink()
                        : InkWell(
                            onTap: () {
                              storyBlocksController.closeEditor();
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              color: Colors.grey,
                              child: Center(child: Icon(Icons.close)),
                            ),
                          ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
