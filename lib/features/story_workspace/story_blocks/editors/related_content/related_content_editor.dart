import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/related_content/related_content_section.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/related_content/related_content_controller.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/loading_dots.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';

class RelatedContentEditor extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final relatedContentController = Get.find<RelatedContentController>();
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Obx(() {
        final isLoading = relatedContentController.isLoading.value;
        return Stack(
          children: [
            AbsorbPointer(
              absorbing: isLoading,
              child: SingleChildScrollView(
                child: Form(
                  key: relatedContentController.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Heading -- Related Content Editor
                      Text(
                        "Related Content Editor",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),

                      // Label
                      TextFormField(
                        controller: relatedContentController.labelController,
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

                      // Dropdown to select section of related Content
                      DropdownButtonFormField<RelatedContentSection>(
                        initialValue:
                            relatedContentController.selectedSection.value,
                        items: RelatedContentSection.values.map((section) {
                          return DropdownMenuItem(
                            value: section,
                            child: Text(section.label),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          relatedContentController.selectedSection.value =
                              value!;
                        },
                      ),
                     
                      // Quill tool bar
                      QuillSimpleToolbar(
                        controller: relatedContentController.quillController,
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
                          controller: relatedContentController.quillController,
                        ),
                      ),

                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppButton(
                            text: relatedContentController.editingBlock != null
                                ? "Update"
                                : "Save",
                            backgroundColor: AppColors.primaryColor,
                            icon: Icons.save,
                            onPressed: () {
                              relatedContentController.editingBlock != null
                                  ? relatedContentController
                                        .updateRelatedContentBlock()
                                  : relatedContentController
                                        .createRelatedContentBlock();
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
