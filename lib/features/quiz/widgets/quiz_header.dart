import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/quiz/controller/quiz_controller.dart';
import 'package:ss_admin_dashboard/features/quiz/widgets/quiz_dialogue.dart';
import 'package:ss_admin_dashboard/features/quiz/widgets/quiz_filter_bar.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';

class QuizHeader extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final quizController = Get.find<QuizController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: QuizFilterBar()),
        SizedBox(width: 12),
        AppButton(
          text: "Add Quiz",
          icon: Icons.question_mark_rounded,
          onPressed: () {
            quizController.clearForm();
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return QuizDialogue(
                  title: "Create New Quiz",
                  buttonText: "Create",
                  onSave: () async {
                    quizController.createQuiz();
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
