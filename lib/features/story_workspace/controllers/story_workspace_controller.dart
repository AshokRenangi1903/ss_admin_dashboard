import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story/controller/story_controller.dart';
import 'package:ss_admin_dashboard/features/story/model/story_model.dart';
import 'package:ss_admin_dashboard/features/story_workspace/models/story_workspace_step_item.dart';
import 'package:ss_admin_dashboard/features/story/repository/story_repository.dart';

class StoryWorkspaceController extends GetxController {
  late Future<bool> storyLoadFuture;
  @override
  void onInit() {
    super.onInit();
    storyLoadFuture = loadStory();
  }

  final StoryRepository _storyRepository = StoryRepository();

  final Rxn<StoryModel> story = Rxn<StoryModel>();
  final RxBool isLoading = true.obs;
  final RxnString errorMessage = RxnString();

  Future<bool> loadStory() async {
    final storyId = Get.parameters['storyId'];

    if (storyId == null || storyId.isEmpty) {
      errorMessage.value = 'Invalid story ID.';
      isLoading.value = false;
      return false;
    }

    try {
      isLoading.value = true;
      errorMessage.value = null;

      story.value = await _storyRepository.getStoryById(storyId);
      return true;
    } catch (e) {
      errorMessage.value = 'Failed to load story details.';
      return false;
    } finally {
      isLoading.value = false;
    }
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
