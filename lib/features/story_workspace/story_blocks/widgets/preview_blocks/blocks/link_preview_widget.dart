import 'package:flutter/material.dart';
import 'package:ss_admin_dashboard/features/story_workspace/helpers/open_url.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/story_block_model.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkPreviewWidget extends StatelessWidget {
  final StoryBlockModel block;

  const LinkPreviewWidget({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    final String title = block.content?["title"] ?? "Open Link";
    final String url = block.content?["url"] ?? "";

    return InkWell(
      onTap: () => openUrl(url),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Text(title, style: const TextStyle(color: Colors.blue)),
      ),
    );
  }
}
