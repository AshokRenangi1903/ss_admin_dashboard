import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ss_admin_dashboard/features/era/controller/era_controller.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';
import 'package:ss_admin_dashboard/shared/components/image_preview_page.dart';

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

                        // Era Image Upload
                        Obx(() {
                          final isUploading =
                              eraController.isImageUploading.value;
                          final imageUrl = eraController.uploadedImageUrl.value
                              .trim();

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  onPressed: isUploading
                                      ? null
                                      : eraController.pickAndUploadEraImage,
                                  icon: isUploading
                                      ? const SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Icon(Icons.upload_file),
                                  label: Text(
                                    isUploading
                                        ? 'Uploading image...'
                                        : 'Choose and Upload Image',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),

                              if (imageUrl.isEmpty)
                                const Text('No image uploaded yet')
                              else ...[
                                SelectableText(
                                  'Image URL: $imageUrl',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(height: 8),

                                TextButton.icon(
                                  onPressed: () => Get.to(
                                    () => ImagePreviewPage(imageUrl: imageUrl),
                                  ),
                                  icon: const Icon(Icons.open_in_new),
                                  label: const Text('Open image preview'),
                                ),
                                const SizedBox(height: 8),

                                Image.network(
                                  imageUrl,
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    debugPrint(
                                      'Era image preview error: $error',
                                    );
                                    return Text('Preview failed: $error');
                                  },
                                ),
                              ],
                            ],
                          );
                        }),

                        const SizedBox(height: 10),
                        
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

