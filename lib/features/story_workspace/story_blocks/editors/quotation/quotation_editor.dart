import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/editors/quotation/quotation_controller.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/loading_dots.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';

class QuotationEditor extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final quotationController = Get.find<QuotationController>();
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Obx(() {
        final isLoading = quotationController.isLoading.value;
        return Stack(
          children: [
            AbsorbPointer(
              absorbing: isLoading,
              child: SingleChildScrollView(
                child: Form(
                  key: quotationController.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Heading -- Quotation Editor
                      Text(
                        "Quotation Editor",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),

                      // Label
                      TextFormField(
                        controller: quotationController.labelController,
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

                      // Quotation
                      TextFormField(
                        maxLines: 3,
                        controller: quotationController.quoteTextController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Quote can\'t be null';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Quote",
                          labelText: "Quote",
                        ),
                      ),
                      SizedBox(height: 12),

                      // Author
                      TextFormField(
                        controller: quotationController.authorController,

                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Author",
                          labelText: "Author",
                        ),
                      ),
                      SizedBox(height: 12),

                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppButton(
                            text: quotationController.editingBlock != null
                                ? "Update"
                                : "Save",
                            backgroundColor: AppColors.primaryColor,
                            icon: Icons.save,
                            onPressed: () {
                              quotationController.editingBlock != null
                                  ? quotationController.updateQuotationBlock()
                                  : quotationController.createQuotationBlock();
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
