import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/helpers/generate_rich_text.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/story_block_model.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class HighlightPreviewWidget extends StatelessWidget {
  final StoryBlockModel block;
  const new({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    final String title = block.content?["title"] ?? "No title";
    final highlightColors = [
      AppColors.darkText,
      AppColors.goldBorderColor,
      AppColors.teal,
      AppColors.secondaryColor,
      AppColors.fillColor,
      Colors.red,
    ];
    int position = block.position!;
    final Color baseColor =
        highlightColors[(position - 1) % highlightColors.length];
    final bgColor = Color.lerp(baseColor, Colors.white, 0.85);

    return Container(
      width: Get.width,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(left: BorderSide(width: 3, color: baseColor)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: baseColor,
            ),
          ),
          SizedBox(height: 8),
          GenerateRichText(
            data: block.content?["descriptionOps"],
            thinText: true,
          ),
        ],
      ),
    );
  }
}
