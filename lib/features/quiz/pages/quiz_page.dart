import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/quiz/controller/quiz_controller.dart';
import 'package:ss_admin_dashboard/features/quiz/widgets/quiz_grid.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    final quizController = Get.put(QuizController());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 12),
          Expanded(child: QuizGrid()),
        ],
      ),
    );
  }
}
