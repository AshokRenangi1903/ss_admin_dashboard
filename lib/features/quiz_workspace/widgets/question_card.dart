import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/quiz_workspace/controllers/quiz_workspace_controller.dart';
import 'package:ss_admin_dashboard/features/quiz_workspace/helpers/question_difficulty_color.dart';
import 'package:ss_admin_dashboard/features/quiz_workspace/models/question_model.dart';
import 'package:ss_admin_dashboard/features/quiz_workspace/widgets/option_card.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/loading_dots.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';
import 'package:ss_admin_dashboard/shared/components/chip_text.dart';

class QuestionCard extends StatelessWidget {
  final int questionNumber;
  final QuestionModel question;

  const QuestionCard({
    super.key,
    required this.questionNumber,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    final quizWorkspaceController = Get.find<QuizWorkspaceController>();

    return Column(
      children: [
        Card(
          margin: EdgeInsets.all(16),
          clipBehavior: Clip.antiAlias,
          elevation: 20,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---------------------------
                // Question Container
                // ---------------------------
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColors.goldBorderColor.withAlpha(180),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // -------
                      // Question
                      // --------
                      Expanded(
                        child: SizedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ChipText(title: "$questionNumber"),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Center(
                                        child: ChipText(
                                          title: question.difficulty!,
                                          textCenter: true,
                                          color: AppColors.white,
                                          bgcolor: getDifficultyColor(
                                            question.difficulty!,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(question.questionText!),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // --------------------------------
                      //  Editing and Delete Buttons
                      // --------------------------------
                      SizedBox(
                        child: Row(
                          children: [
                            // Editing Button
                            IconButton(
                              color: AppColors.teal,
                              onPressed: () {
                                quizWorkspaceController.startEditingQuestion(
                                  question,
                                );
                              },
                              icon: Icon(Icons.edit),
                            ),

                            // Deletion Button
                            IconButton(
                              color: Colors.red,
                              onPressed: () {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (_) {
                                    return Obx(() {
                                      final isLoading = quizWorkspaceController
                                          .isLoading
                                          .value;
                                      return Stack(
                                        children: [
                                          AlertDialog(
                                            content: Text(
                                              "Do you really want to delete this question?",
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
                                                  await quizWorkspaceController
                                                      .deleteQuestion(question);
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //---------------------
                // Options
                //---------------------
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: OptionCard(
                        optionText: question.options![0].optionText!,
                        isCorrect: question.options![0].isCorrect!,
                      ),
                    ),
                    Expanded(
                      child: OptionCard(
                        optionText: question.options![1].optionText!,
                        isCorrect: question.options![1].isCorrect!,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: OptionCard(
                        optionText: question.options![2].optionText!,
                        isCorrect: question.options![2].isCorrect!,
                      ),
                    ),
                    Expanded(
                      child: OptionCard(
                        optionText: question.options![3].optionText!,
                        isCorrect: question.options![3].isCorrect!,
                      ),
                    ),
                  ],
                ),
                //---------------------
                // Explaination
                //---------------------
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.fromLTRB(12, 0, 12, 12),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          border: Border(
                            left: BorderSide(
                              width: 3,
                              color: AppColors.tealShadow,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "EXPLANATION",
                              style: TextStyle(
                                color: AppColors.tealShadow,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(question.explanation!),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                //---------------------
                //  Categories
                //---------------------
                Padding(
                  padding: EdgeInsets.all(8),

                  child: Row(
                    children: [
                      Text(
                        "Categories: ",
                        style: TextStyle(color: AppColors.blue),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 30,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: question.category!.length,
                            itemBuilder: (context, index) {
                              return ChipText(
                                title: question.category![index],
                                bgcolor: AppColors.blue,
                                color: AppColors.white,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
