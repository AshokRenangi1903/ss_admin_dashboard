import 'package:flutter/material.dart';
import 'package:ss_admin_dashboard/features/story_workspace/helpers/generate_rich_text.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/related_content/related_content_section.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/story_block_model.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class RelatedContentPreviewWidget extends StatelessWidget {
  final StoryBlockModel block;
  const new({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    final relatedContentColors = [
      AppColors.blue,
      AppColors.primaryColor,
      AppColors.green,
    ];

    Color? bgColor(Color baseColor) =>
        Color.lerp(baseColor, Colors.white, 0.85);
    late final Color baseColor;
    switch (block.content?["section"]) {
      case "past":
        baseColor = AppColors.blue;
        break;
      case "present":
        baseColor = AppColors.primaryColor;
        break;
      case "future":
        baseColor = AppColors.green;
        break;
      default:
        baseColor = Colors.red;
    }

    final sectionValue = block.content?["section"];

    final section = RelatedContentSection.values.firstWhere(
      (e) => e.name == sectionValue,
    );

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor(baseColor),
        border: Border(top: BorderSide(color: baseColor, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 12),
            child: Text(
              section.label,
              style: TextStyle(color: baseColor, fontWeight: FontWeight.bold),
            ),
          ),
          GenerateRichText(data: block.content?["ops"] ?? "No data"),
        ],
      ),
    );
  }
}
