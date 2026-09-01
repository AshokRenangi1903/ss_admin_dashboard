import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/link/link_controller.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/loading_dots.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';

class LinkEditor extends StatelessWidget {
  const LinkEditor({super.key});

  @override
  Widget build(BuildContext context) {
    final linkController = Get.find<LinkController>();
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Obx(() {
        final isLoading = linkController.isLoading.value;
        return Stack(
          children: [
            AbsorbPointer(
              absorbing: isLoading,
              child: SingleChildScrollView(
                child: Form(
                  key: linkController.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Heading -- Link Editor
                      Text(
                        "Link Editor",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),

                      // Label
                      TextFormField(
                        controller: linkController.labelController,
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
                        maxLines: 3,
                        controller: linkController.titleController,
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

                      // Url
                      TextFormField(
                        controller: linkController.urlController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Url can\'t be null';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Url",
                          labelText: "Url",
                        ),
                      ),
                      SizedBox(height: 12),

                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppButton(
                            text: linkController.editingBlock != null
                                ? "Update"
                                : "Save",
                            backgroundColor: AppColors.primaryColor,
                            icon: Icons.save,
                            onPressed: () {
                              linkController.editingBlock != null
                                  ? linkController.updateLinkBlock()
                                  : linkController.createLinkBlock();
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
