import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/content_type.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/story_block_model.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/widgets/preview_blocks/blocks/card_preview_widget.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/widgets/preview_blocks/blocks/highlight_preview_widget.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/widgets/preview_blocks/blocks/image_preview_widget.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/widgets/preview_blocks/blocks/link_preview_widget.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/widgets/preview_blocks/blocks/paragraph_preview_widget.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/widgets/preview_blocks/blocks/quotation_preview_widget.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/widgets/preview_blocks/blocks/related_content_preview_widget.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/widgets/preview_blocks/blocks/scientist_card_preview_widget.dart';

class PreviewStoryBlockRender extends StatelessWidget {
  final StoryBlockModel block;
  const new({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    switch (block.type) {
      case ContentType.paragraph:
        return Theme(
          data: ThemeData(textTheme: GoogleFonts.sourceSerif4TextTheme  ()),
          child: ParagraphPreviewWidget(block: block),
        );
      case ContentType.card:
        return CardPreviewWidget(block: block); 
      case ContentType.link:
        return LinkPreviewWidget(block: block);
      case ContentType.highlight:
        return HighlightPreviewWidget(block: block);
      case ContentType.scientist_card:
        return ScientistCardPreviewWidget(block: block);
      case ContentType.image:
        return ImagePreviewWidget(block: block);
      case ContentType.quotation:
        return QuotationPreviewWidget(block: block);
      case ContentType.related_content:
        return RelatedContentPreviewWidget(block: block);
      default:
        return SizedBox.shrink();
    }
  }
}
