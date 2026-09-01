import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/quiz_workspace/controllers/quiz_workspace_controller.dart';
import 'package:ss_admin_dashboard/features/quiz_workspace/widgets/option_creation_card.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';

Widget QuestionCreationCard(QuizWorkspaceController controller) {
  final quizWorkspaceController = Get.find<QuizWorkspaceController>();

  return Card(
    margin: const EdgeInsets.all(16),
    elevation: 8,
    clipBehavior: Clip.antiAlias,
    child: Form(
      key: controller.questionFormKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -------------------------
            // Header
            // -------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  final bool isEditing =
                      quizWorkspaceController.isEditingQuestion.value;
                  return Text(
                    isEditing ? "Update Question Details" : "Add New Question",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  );
                }),

                IconButton(
                  onPressed: controller.cancelCreatingQuestion,
                  icon: const Icon(Icons.close),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // -------------------------
            // Question
            // -------------------------
            TextFormField(
              controller: controller.questionTextController,
              maxLines: 3,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Question is required";
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: "Question",
                hintText: "Enter the question",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // -------------------------
            // Difficulty
            // -------------------------
            Obx(
              () => DropdownButtonFormField<String>(
                initialValue: controller.selectedDifficulty.value,
                decoration: const InputDecoration(
                  labelText: "Difficulty",
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: "EASY", child: Text("Easy")),
                  DropdownMenuItem(value: "MODERATE", child: Text("Moderate")),
                  DropdownMenuItem(value: "ADVANCED", child: Text("Advanced")),
                ],
                onChanged: (value) {
                  if (value != null) {
                    controller.selectedDifficulty.value = value;
                  }
                },
              ),
            ),

            const SizedBox(height: 20),

            // -------------------------
            // Categories
            // -------------------------
            TextFormField(
              controller: controller.categoryController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Category is required";
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: "Categories",
                hintText: "Science, Biology, Animals",
                border: OutlineInputBorder(),
                helperText: "Separate multiple categories with commas",
              ),
            ),
            const SizedBox(height: 16),
            // -------------------------
            // Options title
            // -------------------------
            const Text(
              "Options",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // Option 1
            OptionCreationCard(
              controller: controller.option1Controller,
              optionNumber: 1,
              workspaceController: controller,
            ),

            // Option 2
            OptionCreationCard(
              controller: controller.option2Controller,
              optionNumber: 2,
              workspaceController: controller,
            ),

            // Option 3
            OptionCreationCard(
              controller: controller.option3Controller,
              optionNumber: 3,
              workspaceController: controller,
            ),

            // Option 4
            OptionCreationCard(
              controller: controller.option4Controller,
              optionNumber: 4,
              workspaceController: controller,
            ),

            const SizedBox(height: 20),

            // -------------------------
            // Explanation
            // -------------------------
            TextFormField(
              controller: controller.explanationController,
              maxLines: 4,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Explanation is required";
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: "Explanation",
                hintText: "Explain why the correct answer is correct",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // -------------------------
            // Buttons
            // -------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButton(
                  text: "Cancel",
                  backgroundColor: AppColors.darkText,
                  onPressed: controller.cancelCreatingQuestion,
                ),

                const SizedBox(width: 10),

                Obx(() {
                  bool isLoading = quizWorkspaceController.isLoading.value;
                  bool isCreating =
                      quizWorkspaceController.isCreatingQuestion.value;
                  return AppButton(
                    text: isLoading
                        ? "Saving..."
                        : isCreating
                        ? "Create Question"
                        : "Update Question",
                    onPressed: () async {
                      if (!controller.questionFormKey.currentState!
                          .validate()) {
                        return;
                      }

                      // API call will come here
                      await controller.saveQuestion();
                    },
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
