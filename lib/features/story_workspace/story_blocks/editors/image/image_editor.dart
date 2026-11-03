import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/image/image_controller.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';
import 'package:ss_admin_dashboard/shared/components/image_preview_page.dart';

class ImageEditor extends StatelessWidget {
  const ImageEditor({super.key});

  @override
  Widget build(BuildContext context) {
    final imageController = Get.put(ImageController());
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Obx(() {
        final isLoading = imageController.isLoading.value;
        return Stack(
          children: [
            AbsorbPointer(
              absorbing: isLoading,
              child: SingleChildScrollView(
                child: Form(
                  key: imageController.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Heading -- Image Editor
                      Text(
                        "Image Editor",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),

                      // Label
                      TextFormField(
                        controller: imageController.labelController,
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
                        controller: imageController.titleController,
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

                      //  Image Url
                      Obx(() {
                        final imageUrl = imageController.uploadedImageUrl.value;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OutlinedButton.icon(
                              onPressed: imageController.isImageUploading.value
                                  ? null
                                  : imageController.pickAndUploadImage,
                              icon: imageController.isImageUploading.value
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Icon(Icons.cloud_upload_outlined),
                              label: Text(
                                imageController.isImageUploading.value
                                    ? 'Uploading...'
                                    : 'Upload Image',
                              ),
                            ),

                            if (imageUrl != null && imageUrl.isNotEmpty) ...[
                              const SizedBox(height: 8),

                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  imageUrl,
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Text(
                                      'Unable to load image preview.',
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(height: 8),

                              SelectableText(
                                imageUrl,
                                style: const TextStyle(fontSize: 12),
                              ),

                              const SizedBox(height: 8),

                              OutlinedButton.icon(
                                onPressed: () {
                                  Get.to(
                                    () => ImagePreviewPage(imageUrl: imageUrl),
                                  );
                                },
                                icon: const Icon(Icons.open_in_new),
                                label: const Text('Preview Image'),
                              ),
                            ],
                          ],
                        );
                      }),
                      SizedBox(height: 12),

                      // Caption
                      Text(
                        "Caption",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      // Quill tool bar
                      QuillSimpleToolbar(
                        controller: imageController.quillController,
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
                          controller: imageController.quillController,
                        ),
                      ),

                      SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppButton(
                            text: imageController.editingBlock != null
                                ? "Update"
                                : "Save",
                            backgroundColor: AppColors.primaryColor,
                            icon: Icons.save,
                            onPressed: () {
                              imageController.editingBlock != null
                                  ? imageController.updateImageBlock()
                                  : imageController.createImageBlock();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
      }),
    );
  }
}
