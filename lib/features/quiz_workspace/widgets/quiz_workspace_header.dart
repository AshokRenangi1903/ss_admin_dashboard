import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/quiz_workspace/controllers/quiz_workspace_controller.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class QuizWorkspaceHeader extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final quizWorkspaceController = Get.find<QuizWorkspaceController>();
    final quiz = quizWorkspaceController.quiz;
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    quiz.story!.era!.title!,

                    style: TextStyle(color: AppColors.white),
                  ),
                ),
                Text(
                  quiz.title!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Linked Story: ${quiz.story!.title!}",
                  style: TextStyle(color: AppColors.white),
                ),
                // Row(
                //   children: [
                //     ChipText(
                //       title: "Total Questions: ${quiz.questionCount}",
                //       bgcolor: Colors.transparent,
                //       icon: Icons.question_mark,
                //       iconColor: Colors.red,
                //       color: AppColors.white,
                //     ),
                //     SizedBox(width: 12),
                //     ChipText(
                //       title: "Marks per Question: ${quiz.marksPerQuestion}",
                //       bgcolor: Colors.transparent,
                //       icon: Icons.star,
                //       iconColor: AppColors.blue,
                //       color: AppColors.white,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
