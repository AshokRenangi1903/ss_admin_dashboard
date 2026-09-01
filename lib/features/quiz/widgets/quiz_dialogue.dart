import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/quiz/controller/quiz_controller.dart';
import 'package:ss_admin_dashboard/features/story/controller/story_controller.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/loading_dots.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';
import 'package:ss_admin_dashboard/shared/components/chip_text.dart';

class QuizDialogue extends StatelessWidget {
  final String title, buttonText;
  final Future<void> Function() onSave;
  const new({
    super.key,
    required this.title,
    required this.buttonText,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final quizController = Get.find<QuizController>();
    final storyController = Get.find<StoryController>();

    return Obx(() {
      final isLoading = quizController.isLoading.value;
      final stories = storyController.storiesResponse.value.data;

      return Stack(
        children: [
          AbsorbPointer(
            absorbing: isLoading,
            child: AlertDialog(
              title: Text(title),

              content: SizedBox(
                width: Get.width * 0.4,
                child: SingleChildScrollView(
                  child: Form(
                    key: quizController.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Linked Story to Quiz
                        Text("Linked Story Details"),
                        SizedBox(height: 10),

                        //Linked Story Dropdown
                        DropdownButtonFormField<String>(
                          initialValue: quizController.selectedStoryId.value,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Select Linked Story';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Linked Story",
                            border: OutlineInputBorder(),
                          ),
                          items: stories!.map((story) {
                            return DropdownMenuItem<String>(
                              value: story.id,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.27,
                                    child: Text(
                                      story.title!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  ChipText(title: story.era!.title!),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: quizController.isUpdating.value
                              ? null
                              : (value) {
                                  quizController.selectedStoryId.value = value;
                                },
                        ),
                        SizedBox(height: 10),

                        // title of the Quiz
                        TextFormField(
                          controller: quizController.titleController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Title is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Title",
                            hintText: "title",
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                AppButton(
                  text: "Cancel",
                  backgroundColor: AppColors.darkText,
                  onPressed: () {
                    Get.back();
                    quizController.clearForm();
                  },
                ),
                AppButton(
                  text: isLoading ? "Saving..." : buttonText,
                  onPressed: onSave,
                ),
              ],
            ),
          ),

          if (isLoading) LoadingDots(),
        ],
      );
    });
  }
}
