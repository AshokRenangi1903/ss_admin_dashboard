import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/controllers/story_workspace_controller.dart';
import 'package:ss_admin_dashboard/shared/components/toggle_box.dart';

class StoryDetailsStep extends StatelessWidget {
  const StoryDetailsStep({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StoryWorkspaceController>();

    return Obx(() {
      final story = controller.story.value;

      if (story == null) {
        return const Center(child: Text('Story details unavailable.'));
      }

      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Basic Story Details'),
            const SizedBox(height: 10),

            TextFormField(
              readOnly: true,
              initialValue: story.era?.title ?? '',
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Era',
              ),
            ),
            const SizedBox(height: 10),

            TextFormField(
              readOnly: true,
              initialValue: story.title ?? '',
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 10),

            TextFormField(
              readOnly: true,
              maxLines: 4,
              initialValue: story.description ?? '',
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 10),

            const Text('Other Details'),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    initialValue: story.subject ?? '',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Subject',
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    initialValue: story.discipline ?? '',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Discipline',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    initialValue: story.estimatedReadTime ?? '',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Estimated Read Time',
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    initialValue: story.geolocation ?? '',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Geolocation',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            TextFormField(
              readOnly: true,
              initialValue: story.scientistNames?.join(', ') ?? '',
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Scientists',
              ),
            ),
            const SizedBox(height: 10),

            TextFormField(
              readOnly: true,
              initialValue: story.imageUrl ?? '',
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Image URL',
              ),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                ToggleBox(
                  title: 'Popular',
                  isEnabled: story.isPopular ?? false,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
