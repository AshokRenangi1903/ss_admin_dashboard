import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/controllers/story_workspace_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/models/story_workspace_step_item.dart';
import 'package:ss_admin_dashboard/features/story_workspace/trash/step_connector.dart';
import 'package:ss_admin_dashboard/features/story_workspace/trash/step_item_widget.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';

class StoryWorkspaceStepper extends StatelessWidget {
  const StoryWorkspaceStepper({super.key});

  @override
  Widget build(BuildContext context) {
    final storyWorkspaceController = Get.find<StoryWorkspaceController>();

    return SizedBox(
      height: 150,
      width: Get.width * 0.7,
      // color: Colors.blue,
      child: Obx(() {
        int currentStep = storyWorkspaceController.currentStep.value;
        bool isLastStep = currentStep == storyWorkspaceStepItems.length - 1;
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppColors.primaryColor),
          ),
          child: Stepper(
            elevation: 0,
            type: StepperType.horizontal,
            currentStep: currentStep,
            onStepContinue: () {
              storyWorkspaceController.next();
            },
            onStepCancel: () {
              storyWorkspaceController.previous();
            },
            steps: storyWorkspaceController.getSteps(),

            controlsBuilder: (context, details) {
              return Row(
                children: [
                  currentStep == 0
                      ? SizedBox.shrink()
                      : Expanded(
                          child: AppButton(
                            text: "Back",

                            onPressed: details.onStepCancel,
                          ),
                        ),
                  SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      text: isLastStep ? "Publish Story" : "Save & Next",
                      onPressed: details.onStepContinue,
                      backgroundColor: AppColors.primaryColor,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}
