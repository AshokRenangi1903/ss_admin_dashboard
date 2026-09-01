import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story/controller/story_controller.dart';
import 'package:ss_admin_dashboard/features/story/widgets/story_dialogue.dart';
import 'package:ss_admin_dashboard/features/story/widgets/story_filter_bar.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';

class StoryPageHeader extends StatelessWidget {
  const StoryPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final storyController = Get.find<StoryController>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: StoryFilterBar()),

        AppButton(
          text: "Add New Story",
          onPressed: () {
            storyController.isUpdating.value = false;
            storyController.clearForm();
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return StoryDialogue(
                  title: "Story Details",
                  buttonText: "Create",
                  onSave: storyController.createStory,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
