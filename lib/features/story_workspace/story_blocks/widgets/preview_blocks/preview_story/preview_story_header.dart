import 'package:flutter/material.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class PreviewStoryHeader extends StatelessWidget {
  final String storyDescription,
      storyTitle,
      discipline,
      subject,
      geolocation,
      time;
  final List<String> scientists;
  const PreviewStoryHeader({
    super.key,
    required this.storyDescription,
    required this.storyTitle,
    required this.discipline,
    required this.subject,
    required this.geolocation,
    required this.scientists,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    String scientistNames = scientists[0];
    if (scientists.length > 1) {
      for (var i = 1; i < scientists.length; i++) {
        scientistNames = scientistNames + " . " + scientists[i];
      }
    }
    return Column(
      children: [
        // story data -discpline - subject
        Text(
          "$discipline . $subject . $geolocation . $time",
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.primaryColor, fontSize: 16),
        ),
        // story title
        Text(
          storyTitle,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        Text(
          storyDescription,
          style: TextStyle(fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ),
        Text(
          scientistNames,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        Divider(height: 16, color: AppColors.primaryColor, thickness: 2),
      ],
    );
  }
}
