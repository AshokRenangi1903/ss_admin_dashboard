import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/controllers/story_blocks_controller.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/card/card_editor.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/highlight/highlight_editor.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/image/image_editor.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/link/link_editor.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/paragraph/paragraph_editor.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/quotation/quotation_editor.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/related_content/related_content_editor.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/scientist_card/scientist_card_editor.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/content_type.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/widgets/add_story_block.dart';

class RightBlockPanel extends StatelessWidget {
  const RightBlockPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final storyBlocksController = Get.find<StoryBlocksController>();

    return Obx(() {
      final selectedContentType =
          storyBlocksController.selectedContentType.value;
      switch (selectedContentType) {
        case ContentType.paragraph:
          return ParagraphEditor();
        case ContentType.image:
          return ImageEditor();
        case ContentType.link:
          return LinkEditor();
        case ContentType.highlight:
          return HighlightEditor();
        case ContentType.quotation:
          return QuotationEditor();
        case ContentType.card:
          return CardEditor();
        case ContentType.related_content:
          return RelatedContentEditor();
        case ContentType.scientist_card:
          return ScientistCardEditor();
        default:
          return AddStoryBlock();
      }
    });
  }
}
