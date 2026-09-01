import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ss_admin_dashboard/features/story_workspace/helpers/generate_rich_text.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/story_block_model.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class ScientistCardPreviewWidget extends StatelessWidget {
  final StoryBlockModel block;
  const new({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    final scientistName = block.content?["scientistName"];
    final title = block.content?["title"];
    final birth = block.content?["birth"];
    final death = block.content?["death"];
    final imageUrl = block.content?["imageUrl"];
    final description = block.content?["descriptionOps"];

    // final imageUrl =
    return Column(
      children: [
        // Image Part
        Image.network(
          imageUrl ?? "",
          height: 350,
          width: double.infinity,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }

            return SizedBox(
              height: 350,
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            debugPrint("IMAGE ERROR: $error");
            debugPrint("IMAGE URL: ${block.content?["imageUrl"]}");

            return Container(
              height: 350,
              color: Colors.grey.withValues(alpha: 0.4),
              child: const Center(
                child: Icon(Icons.error_outline, color: Colors.red),
              ),
            );
          },
        ),

        // Header Part
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.blue,
            border: Border(
              top: BorderSide(color: AppColors.primaryColor, width: 3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                scientistName,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),

              Text(
                "$birth - $death",

                style: TextStyle(
                  color: AppColors.white.withAlpha(150),
                  fontSize: 14,
                  fontWeight: FontWeight.w100,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),

        // Quill - Description
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
          ),
          child: GenerateRichText(data: description),
        ),
      ],
    );
  }
}
