import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/paragraph/paragraph_controller.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/loading_dots.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';

class ParagraphEditor extends StatelessWidget {
  const ParagraphEditor({super.key});

  @override
  Widget build(BuildContext context) {
    final paragraphController = Get.find<ParagraphController>();

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Obx(() {
        final isLoading = paragraphController.isLoading.value;
        return Stack(
          children: [
            AbsorbPointer(
              absorbing: isLoading,
              child: SingleChildScrollView(
                child: Form(
                  key: paragraphController.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Paragraph Editor",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: paragraphController.labelController,
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
                      SizedBox(height: 8),

                      // Quill tool bar
                      QuillSimpleToolbar(
                        controller: paragraphController.quillController,
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
                          controller: paragraphController.quillController,
                        ),
                      ),

                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppButton(
                            text: paragraphController.editingBlock != null
                                ? "Update"
                                : "Save",
                            backgroundColor: AppColors.primaryColor,
                            icon: Icons.save,
                            onPressed: () {
                              paragraphController.editingBlock != null
                                  ? paragraphController.updateParagraphBlock()
                                  : paragraphController.createParagraphBlock();
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
