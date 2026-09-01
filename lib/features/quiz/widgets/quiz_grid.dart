import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/core/response/status.dart';
import 'package:ss_admin_dashboard/core/routes/routes_name.dart';
import 'package:ss_admin_dashboard/features/quiz/controller/quiz_controller.dart';
import 'package:ss_admin_dashboard/features/quiz/widgets/quiz_card.dart';
import 'package:ss_admin_dashboard/features/quiz/widgets/quiz_dialogue.dart';
import 'package:ss_admin_dashboard/features/quiz/widgets/shimmer_quiz_grid.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/empty_box.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/loading_dots.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';
import 'package:ss_admin_dashboard/shared/helpers/format_date_time.dart';

class QuizGrid extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final quizController = Get.find<QuizController>();

    return Obx(() {
      final response = quizController.quizzesResponse.value;

      switch (response.status) {
        case Status.loading:
          return ShimmerQuizGrid();

        case Status.error:
          return Column(
            children: [
              EmptyBox(),
              Text(response.message ?? "Something went wrong"),
            ],
          );

        case Status.completed:
          // final quizzes = response.data!;
          final quizzes = quizController.filteredQuizzes;

          return GridView.builder(
            itemCount: quizzes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Number of columns
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              // childAspectRatio: 0.85, // Controls item height/width ratio
            ),
            itemBuilder: (context, index) {
              return QuizCard(
                quizTitle: quizzes[index].title!,
                storyTitle: quizzes[index].story!.title!,
                era: quizzes[index].story!.era!.title!,
                updatedTime: formatDateTime(quizzes[index].updatedAt!),
                totalQuestions: quizzes[index].questionCount.toString(),
                marksPerQuestion: quizzes[index].marksPerQuestion.toString(),
                onTap: () {
                  quizController.getQuiz(quizzes[index].id!);
                  Get.toNamed(
                    RoutesName.quizWorkspace,
                    arguments: quizzes[index],
                  );
                },
                onDelete: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) {
                      return Obx(() {
                        final isLoading = quizController.isLoading.value;
                        return Stack(
                          children: [
                            AlertDialog(
                              content: Text(
                                "Do you really want to delete this quiz ${quizzes[index].title}?",
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
                                  onPressed: () {
                                    quizController.deleteQuiz(
                                      quizzes[index].id!,
                                    );
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
                onEdit: () {
                  quizController.loadQuizDetails(quizzes[index]);
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return QuizDialogue(
                        title: "Update the Quiz Details",
                        buttonText: "Update",
                        onSave: quizController.updateQUiz,
                      );
                    },
                  );
                },
              );
            },
          );

        default:
          return const SizedBox();
      }
    });
  }
}
