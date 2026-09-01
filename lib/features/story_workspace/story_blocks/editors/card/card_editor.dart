import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/card/card_controller.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';

class CardEditor extends StatelessWidget {
  const CardEditor({super.key});

  @override
  Widget build(BuildContext context) {
    final cardController = Get.find<CardController>();
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Obx(() {
        final isLoading = cardController.isLoading.value;
        return Stack(
          children: [
            AbsorbPointer(
              absorbing: isLoading,
              child: SingleChildScrollView(
                child: Form(
                  key: cardController.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Heading -- Card Editor
                      Text(
                        "Card Editor",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),

                      // Label
                      TextFormField(
                        controller: cardController.labelController,
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
                        controller: cardController.titleController,
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

                      // Caption
                      TextFormField(
                        maxLines: 4,
                        controller: cardController.descriptionController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Caption is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Caption",
                          labelText: "Caption",
                        ),
                      ),
                      SizedBox(height: 12),

                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppButton(
                            text: cardController.editingBlock != null
                                ? "Update"
                                : "Save",
                            backgroundColor: AppColors.primaryColor,
                            icon: Icons.save,
                            onPressed: () {
                              cardController.editingBlock != null
                                  ? cardController.updateCardBlock()
                                  : cardController.createCardBlock();
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
