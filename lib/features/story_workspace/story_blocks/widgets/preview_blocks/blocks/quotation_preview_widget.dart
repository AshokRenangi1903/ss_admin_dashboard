import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/story_block_model.dart';

class QuotationPreviewWidget extends StatelessWidget {
  final StoryBlockModel block;
  const new({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    final quote = block.content?["quote"] ?? "No Quotation";
    final author = block.content?['author'] == ""
        ? "Unknown"
        : block.content?['author'];
    return Column(
      children: [
        Text(
          quote,
          textAlign: TextAlign.center,
          style: GoogleFonts.dancingScript(),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("~ $author", style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
      ],
    );
  }
}
