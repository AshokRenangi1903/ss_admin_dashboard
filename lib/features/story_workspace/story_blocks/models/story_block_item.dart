import 'package:flutter/material.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/content_type.dart';

class StoryBlockItem {
  final ContentType type;
  final String title;
  final IconData icon;

  const StoryBlockItem({
    required this.type,
    required this.title,
    required this.icon,
  });
}

const List<StoryBlockItem> storyBlockItems = [
  StoryBlockItem(
    type: ContentType.paragraph,
    title: "Paragraph",
    icon: Icons.notes,
  ),
  StoryBlockItem(type: ContentType.image, title: "Image", icon: Icons.image),
  StoryBlockItem(type: ContentType.link, title: "Link", icon: Icons.link),
  StoryBlockItem(
    type: ContentType.highlight,
    title: "Highlight",
    icon: Icons.highlight,
  ),
  StoryBlockItem(
    type: ContentType.quotation,
    title: "Quotation",
    icon: Icons.format_quote,
  ),
  StoryBlockItem(
    type: ContentType.card,
    title: "Card",
    icon: Icons.view_agenda,
  ),
  StoryBlockItem(
    type: ContentType.related_content,
    title: "Related Content",
    icon: Icons.menu_book,
  ),
  StoryBlockItem(
    type: ContentType.scientist_card,
    title: "Scientist Card",
    icon: Icons.person,
  ),
];
