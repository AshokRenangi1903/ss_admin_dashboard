import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/controllers/story_workspace_controller.dart';
import 'package:ss_admin_dashboard/shared/components/toggle_box.dart';

class StoryDetailsStep extends StatelessWidget {
  const StoryDetailsStep({super.key});

  @override
  Widget build(BuildContext context) {
    final storyWorkspaceController = Get.find<StoryWorkspaceController>();

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bascic Details of Story
          Text("Basic Story Details"),
          SizedBox(height: 10),

          // Era
          TextFormField(
            readOnly: true,
            initialValue: storyWorkspaceController.story.era!.title,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Era",
              hintText: "Era",
            ),
          ),

          SizedBox(height: 10),

          // title of the story
          TextFormField(
            readOnly: true,
            initialValue: storyWorkspaceController.story.title,

            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Title",
              hintText: "title",
            ),
          ),
          SizedBox(height: 10),

          // description of story
          TextFormField(
            readOnly: true,
            maxLines: 4,
            initialValue: storyWorkspaceController.story.description,

            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Description",
              hintText: "Description",
            ),
          ),
          SizedBox(height: 10),

          // Other Details
          Text("Other Details"),
          SizedBox(height: 10),
          // Subject & discipline
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  initialValue: storyWorkspaceController.story.subject,

                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Subject",
                    hintText: "Subject",
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  initialValue: storyWorkspaceController.story.discipline,

                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Discipline",
                    hintText: "Discipline",
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  initialValue:
                      storyWorkspaceController.story.estimatedReadTime,

                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Estimated Read Time",
                    hintText: "Read Time",
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  initialValue: storyWorkspaceController.story.geolocation,

                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Geolocation",
                    hintText: "GeoLocation",
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),

          // scientists names
          TextFormField(
            readOnly: true,
            initialValue: storyWorkspaceController.story.scientistNames!.join(
              ", ",
            ),

            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Scientists",
              hintText: "Einstein,Newton,...",
            ),
          ),
          SizedBox(height: 10),

          // Image Url
          TextFormField(
            readOnly: true,
            initialValue: storyWorkspaceController.story.imageUrl,

            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Image Url",
              hintText: "Image Url",
            ),
          ),
          SizedBox(height: 10),

          // isPublished
          Row(
            children: [
              ToggleBox(
                title: "Popular",
                isEnabled: storyWorkspaceController.story.isPopular!,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
