import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/core/response/status.dart';
import 'package:ss_admin_dashboard/features/quiz/controller/quiz_controller.dart';
import 'package:ss_admin_dashboard/features/quiz_workspace/controllers/quiz_workspace_controller.dart';
import 'package:ss_admin_dashboard/features/quiz_workspace/widgets/question_card.dart';
import 'package:ss_admin_dashboard/features/quiz_workspace/widgets/question_creation_card.dart';
import 'package:ss_admin_dashboard/features/quiz_workspace/widgets/shimmer_questions_list.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/empty_box.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/loading_dots.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';

class QuestionsListView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final quizController = Get.find<QuizController>();
    final quizWorkspaceController = Get.find<QuizWorkspaceController>();

    return Obx(() {
      final response = quizController.quizResponse.value;

      switch (response.status) {
        case Status.loading:
          return ShimmerQuestionsList();

        case Status.error:
          return Column(
            children: [
              EmptyBox(),
              Text(response.message ?? "Something went wrong"),
            ],
          );

        case Status.completed:
          final quiz = response.data!;
          final questions = quiz.questions;
          return ListView.builder(
            controller: quizWorkspaceController.scrollController,
            itemCount: questions!.length + 1,
            itemBuilder: ((BuildContext context, int index) {
              // Main container for the question and options
              if (index < questions.length) {
                return QuestionCard(
                  questionNumber: index + 1,
                  question: questions[index],
                );
              }

              return Obx(() {
                bool isLoading = quizWorkspaceController.isLoading.value;
                return quizWorkspaceController.isCreatingQuestion.value ||
                        quizWorkspaceController.isEditingQuestion.value
                    ? AbsorbPointer(
                        absorbing: isLoading,
                        child: Stack(
                          key: quizWorkspaceController.questionFormKeyWidget,
                          children: [
                            QuestionCreationCard(quizWorkspaceController),
                            if (quizWorkspaceController.isLoading.value)
                              Positioned(
                                bottom: 150,
                                left: Get.width * 0.4,
                                child: LoadingDots(),
                              ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: AppButton(
                            text: "Add New Question",
                            onPressed: () {
                              quizWorkspaceController.startCreatingQuestion();
                            },
                          ),
                        ),
                      );
              });
            }),
          );
        default:
          return const SizedBox();
      }
    });
  }
}
