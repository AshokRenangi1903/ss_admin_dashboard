import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/helpers/generate_rich_text.dart';
import 'package:ss_admin_dashboard/features/story_workspace/helpers/parse_string_to_color.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/story_block_model.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class ImagePreviewWidget extends StatelessWidget {
  final StoryBlockModel block;
  const ImagePreviewWidget({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Get.width,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(color: AppColors.blue),
          child: Text(
            block.content?["title"] ?? "No title",
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        //  Image Part
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.symmetric(
              vertical: BorderSide(width: 0.5, color: Colors.grey),
            ),
          ),
          child: Image.network(
            block.content?["imageUrl"] ?? "",
            height: 350,
            width: double.infinity,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }

              return SizedBox(
                height: 350,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
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
        ),
        // Rich Text
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.softInk.withAlpha(100),
            border: Border(
              top: BorderSide(color: AppColors.primaryColor, width: 3),
            ),
          ),
          child: GenerateRichText(data: block.content?["captionOps"]),
        ),
      ],
    );
  }
}
