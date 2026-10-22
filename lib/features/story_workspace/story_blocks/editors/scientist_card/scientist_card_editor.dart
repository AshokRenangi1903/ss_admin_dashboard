import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/scientist_card/scientist_card_controller.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/loading_dots.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';

class ScientistCardEditor extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final scientistCardController = Get.find<ScientistCardController>();
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Obx(() {
        final isLoading = scientistCardController.isLoading.value;
        return Stack(
          children: [
            AbsorbPointer(
              absorbing: isLoading,
              child: SingleChildScrollView(
                child: Form(
                  key: scientistCardController.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Heading -- Scientist Card Editor
                      Text(
                        "Scientist Card Editor",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),

                      // Label
                      TextFormField(
                        controller: scientistCardController.labelController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Create Label';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Label",
                          labelText: "Label",
                        ),
                      ),
                      SizedBox(height: 12),

                      // Title
                      TextFormField(
                        controller: scientistCardController.titleController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Title can\'t be null';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Title",
                          labelText: "Title",
                        ),
                      ),
                      SizedBox(height: 12),

                      // Scientist Name
                      TextFormField(
                        controller:
                            scientistCardController.scientistNameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Scientist Name can\'t be null';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Einstein",
                          labelText: "Scientist Name",
                        ),
                      ),
                      SizedBox(height: 12),

                      // Scientist ImageUrl
                      Obx(() {
                        final imageUrl =
                            scientistCardController.uploadedImageUrl.value;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OutlinedButton.icon(
                              onPressed:
                                  scientistCardController.isImageUploading.value
                                  ? null
                                  : scientistCardController
                                        .pickAndUploadScientistImage,
                              icon:
                                  scientistCardController.isImageUploading.value
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Icon(Icons.cloud_upload_outlined),
                              label: Text(
                                scientistCardController.isImageUploading.value
                                    ? 'Uploading...'
                                    : 'Upload Scientist Image',
                              ),
                            ),

                            if (imageUrl != null && imageUrl.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  imageUrl,
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Text(
                                      'Unable to load scientist image preview.',
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 8),
                              SelectableText(
                                imageUrl,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ],
                        );
                      }),
                      SizedBox(height: 12),

                      // Birth and Death
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller:
                                  scientistCardController.birthController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Birth can\'t be null';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "b. Shrewsbury, England, 1809",
                                labelText: "Birth",
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller:
                                  scientistCardController.deathController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Death can\'t be null';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "d. Down House, Kent, 1882",
                                labelText: "Death",
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),

                      // Description
                      Text(
                        "Description",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      // Quill tool bar
                      QuillSimpleToolbar(
                        controller: scientistCardController.quillController,
                        config: QuillSimpleToolbarConfig(),
                      ),

                      //  Quill Editor
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: QuillEditor.basic(
                          controller: scientistCardController.quillController,
                        ),
                      ),

                      SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppButton(
                            text: scientistCardController.editingBlock != null
                                ? "Update"
                                : "Save",
                            backgroundColor: AppColors.primaryColor,
                            icon: Icons.save,
                            onPressed: () {
                              scientistCardController.editingBlock != null
                                  ? scientistCardController
                                        .updateScientistCardBlock()
                                  : scientistCardController
                                        .createScientistCardBlock();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (isLoading) LoadingDots(),
          ],
        );
      }),
    );
  }
}
