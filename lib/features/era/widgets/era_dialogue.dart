import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ss_admin_dashboard/features/era/controller/era_controller.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';

class EraDialogue extends StatelessWidget {
  final String title;
  final String buttonText;
  final Future<void> Function() onSave;
  const EraDialogue({
    super.key,
    required this.title,
    required this.buttonText,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final eraController = Get.find<EraController>();

    return Obx(() {
      final isLoading = eraController.isLoading.value;
      bool isPublished = eraController.isPublished.value;
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
                    key: eraController.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // title
                        TextFormField(
                          controller: eraController.titleController,
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

                        // description
                        TextFormField(
                          maxLines: 4,
                          controller: eraController.descriptionController,
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

                        // Years
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: eraController.startYearController,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Start Year is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Start",
                                  hintText: "startYear",
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                controller: eraController.endYearController,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'End Year is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "End",
                                  hintText: "endYear",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),

                        // Image Url
                        TextFormField(
                          controller: eraController.imageUrlController,
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
                            Text("Publish"),
                            SizedBox(width: 30),
                            Switch(
                              activeThumbColor: AppColors.primaryColor,
                              value: isPublished,
                              onChanged: (value) {
                                eraController.isPublished.value = value;
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
                    eraController.clearForm();
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

          if (isLoading)
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Center(
                  child: Lottie.asset(
                    'assets/animations/Loading dots.json',
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
