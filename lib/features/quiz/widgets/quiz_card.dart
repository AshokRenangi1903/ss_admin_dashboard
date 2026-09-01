import 'package:flutter/material.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';
import 'package:ss_admin_dashboard/shared/components/chip_text.dart';

class QuizCard extends StatelessWidget {
  final String quizTitle,
      storyTitle,
      era,
      updatedTime,
      totalQuestions,
      marksPerQuestion;
  final VoidCallback onTap, onEdit, onDelete;
  const new({
    super.key,
    required this.quizTitle,
    required this.storyTitle,
    required this.era,
    required this.totalQuestions,
    required this.marksPerQuestion,
    required this.updatedTime,
    required this.onDelete,
    required this.onEdit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: AppColors.primaryColor.withAlpha(50),
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Part
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      // Quiz Title
                      Text(
                        quizTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      // Story Title
                      Text(
                        storyTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),

                      // Total Questions , Marks Per Question
                      ChipText(
                        icon: Icons.question_mark,
                        title: "$totalQuestions Questions",
                        bgcolor: AppColors.darkText,
                        color: AppColors.white,
                        iconColor: Colors.red,
                      ),
                      ChipText(
                        icon: Icons.star,
                        title: "$marksPerQuestion Marks / Question",
                        bgcolor: AppColors.fillColor,
                        color: AppColors.blue,
                        iconColor: AppColors.blue,
                      ),
                    ],
                  ),
                ),

                // Bottom Part
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withAlpha(100),
                  ),
                  constraints: BoxConstraints(minHeight: 50),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Updated At", style: TextStyle(fontSize: 10)),
                            Text(
                              updatedTime,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ), // Icon Buttons
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: IconButton(
                                onPressed: onEdit,
                                icon: Icon(
                                  Icons.edit,
                                  size: 18,
                                  color: AppColors.teal,
                                ),
                              ),
                            ),
                            SizedBox(width: 4),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: IconButton(
                                onPressed: onDelete,
                                icon: Icon(
                                  Icons.delete,
                                  size: 18,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Era Title
            Positioned(
              right: 4,
              top: 4,
              child: ChipText(
                title: era,
                bgcolor: AppColors.blue,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
