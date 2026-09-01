import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/widgets/show_blocks.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';

class AddStoryBlock extends StatelessWidget {
  const AddStoryBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppButton(
        text: "Add Story Block",
        onPressed: () {
          Get.bottomSheet(ShowBlocks());
        },
        icon: Icons.add,
      ),
    );
  }
}
