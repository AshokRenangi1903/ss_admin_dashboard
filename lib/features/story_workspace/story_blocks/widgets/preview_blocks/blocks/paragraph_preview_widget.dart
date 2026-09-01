import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:ss_admin_dashboard/features/story_workspace/helpers/generate_rich_text.dart';
import 'package:ss_admin_dashboard/features/story_workspace/helpers/parse_string_to_color.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/story_block_model.dart';

class ParagraphPreviewWidget extends StatelessWidget {
  final StoryBlockModel block;
  const new({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    return GenerateRichText(data: block.content?["ops"]);
  }
}
