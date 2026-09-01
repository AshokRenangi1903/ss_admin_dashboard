import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story/controller/story_controller.dart';

import 'package:ss_admin_dashboard/features/story/widgets/story_grid.dart';

class StoryPage extends StatelessWidget {
  const StoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final storyController = Get.put(StoryController());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [Expanded(child: StoryGrid())]),
    );
  }
}
