import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/highlight/highlight_controller.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/loading_dots.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';

class HighlightEditor extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final highlightController = Get.find<HighlightController>();
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Obx(() {
        final isLoading = highlightController.isLoading.value;
        return Stack(
          children: [
            AbsorbPointer(
              absorbing: isLoading,
              child: SingleChildScrollView(
                child: Form(
                  key: highlightController.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Heading -- Highlight Editor
                      Text(
                        "Highlight Editor",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),

                      // Label
                      TextFormField(
                        controller: highlightController.labelController,
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
                        controller: highlightController.titleController,
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
                        controller: highlightController.quillController,
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
                          controller: highlightController.quillController,
                        ),
                      ),

                      SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppButton(
                            text: highlightController.editingBlock != null
                                ? "Update"
                                : "Save",
                            backgroundColor: AppColors.primaryColor,
                            icon: Icons.save,
                            onPressed: () {
                              highlightController.editingBlock != null
                                  ? highlightController.updateHighlightBlock()
                                  : highlightController.createHighlightBlock();
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
