import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story/controller/story_controller.dart';
import 'package:ss_admin_dashboard/features/story/model/story_model.dart';
import 'package:ss_admin_dashboard/features/story_workspace/models/story_workspace_step_item.dart';

class StoryWorkspaceController extends GetxController {
  late final StoryModel story;
  @override
  void onInit() {
    super.onInit();
    story = Get.arguments as StoryModel;
  }

  final storyController = Get.find<StoryController>();
  RxInt currentStep = 0.obs;

  void previous() {
    currentStep == 0 ? null : currentStep.value -= 1;
  }

  void next() async {
    // switch (currentStep.value) {
    //   case 0: // details or information of story
    //     await storyController.updateStory();
    // }

    if (currentStep.value == storyWorkspaceStepItems.length - 1) {
      print("completed");
    } else {
      currentStep.value += 1;
    }
  }

  void goTo() {}

  List<Step> getSteps() {
    final steps = List.generate(storyWorkspaceStepItems.length, (index) {
      final item = storyWorkspaceStepItems[index];

      return Step(
        title: Text(item.title),
        content: const SizedBox.shrink(),

        isActive: currentStep.value >= index,

        state: currentStep.value > index
            ? StepState.complete
            : currentStep.value == index
            ? StepState.editing
            : StepState.indexed,
      );
    });

    return steps;
  }
}
