import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/story_block_model.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class CardPreviewWidget extends StatelessWidget {
  final StoryBlockModel block;

  const new({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    final String title = block.content?["title"];
    final String description = block.content?["description"];
    final cardColors = [
      AppColors.primaryColor,
      AppColors.black,
      AppColors.teal,
      AppColors.sidebarColor,
      AppColors.goldBorderColor,
    ];
    int position = block.position!;
    final color = cardColors[(position - 1) % cardColors.length];
    return Container(
      width: Get.width,
      constraints: const BoxConstraints(minHeight: 200),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,

            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
