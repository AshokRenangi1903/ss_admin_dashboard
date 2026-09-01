import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/era/controller/era_controller.dart';
import 'package:ss_admin_dashboard/features/story/controller/story_controller.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/loading_dots.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';
import 'package:ss_admin_dashboard/shared/components/toggle_box.dart';

class StoryDialogue extends StatelessWidget {
  final String title;
  final String buttonText;
  final Future<void> Function() onSave;
  const StoryDialogue({
    super.key,
    required this.title,
    required this.buttonText,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final storyController = Get.find<StoryController>();
    final eraController = Get.find<EraController>();
    return Obx(() {
      final isLoading = storyController.isLoading.value;
      final eras = eraController.erasResponse.value.data;
      return Stack(
        children: [
          AbsorbPointer(
            absorbing: isLoading,
            child: AlertDialog(
              title: Text(title),

              content: SizedBox(
                width: Get.width * 0.4,
                child: SingleChildScrollView(
                  child: Form(
                    key: storyController.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Bascic Details of Story
                        Text("Basic Story Details"),
                        SizedBox(height: 10),

                        // Era dropdown to select
                        DropdownButtonFormField<String>(
                          initialValue: storyController.selectedEraId.value,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Select Era';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Era",
                            border: OutlineInputBorder(),
                          ),
                          items: eras!.map((era) {
                            return DropdownMenuItem<String>(
                              value: era.id,
                              child: Text(era.title!),
                            );
                          }).toList(),
                          onChanged: storyController.isUpdating.value
                              ? null
                              : (value) {
                                  storyController.selectedEraId.value = value;
                                },
                        ),
                        SizedBox(height: 10),

                        // title of the story
                        TextFormField(
                          controller: storyController.titleController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Title is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Title",
                            hintText: "title",
                          ),
                        ),
                        SizedBox(height: 10),

                        // description of story
                        TextFormField(
                          maxLines: 4,
                          controller: storyController.descriptionController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Description is required';
                            }
                            return null;
                          },
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
                                controller: storyController.subjectController,

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
                                controller:
                                    storyController.disciplineController,

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
                                controller:
                                    storyController.estimatedReadTimeController,

                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Time",
                                  hintText: "Time",
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                controller:
                                    storyController.geolocationController,

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
                          controller: storyController.scientistsController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Scientists names required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Scientists",
                            hintText: "Einstein,Newton,...",
                          ),
                        ),
                        SizedBox(height: 10),

                        // Image Url
                        TextFormField(
                          controller: storyController.imageUrlController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Image Url is required';
                            }
                            return null;
                          },
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
                              isEnabled: storyController.isPopular.value,
                              onTap: () {
                                storyController.isPopular.value
                                    ? storyController.isPopular.value = false
                                    : storyController.isPopular.value = true;
                              },
                            ),
                            SizedBox(width: 12),
                            ToggleBox(
                              title: "Publish",
                              isEnabled: storyController.isPublished.value,
                              onTap: () {
                                storyController.isPublished.value
                                    ? storyController.isPublished.value = false
                                    : storyController.isPublished.value = true;
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                AppButton(
                  text: "Cancel",
                  backgroundColor: AppColors.darkText,
                  onPressed: () {
                    storyController.clearForm();
                    storyController.isUpdating.value = false;
                    Get.back();
                  },
                ),
                AppButton(
                  text: isLoading ? "Saving..." : buttonText,

                  onPressed: () async {
                    await onSave();
                  },
                ),
              ],
            ),
          ),

          if (isLoading) LoadingDots(),
        ],
      );
    });
  }
}
