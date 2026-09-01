import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/quiz_workspace/controllers/quiz_workspace_controller.dart';

Widget OptionCreationCard({
  required TextEditingController controller,
  required int optionNumber,
  required QuizWorkspaceController workspaceController,
}) {
  return Obx(
    () => Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Radio<int>(
            value: optionNumber,
            groupValue: workspaceController.correctOption.value,
            onChanged: (value) {
              if (value != null) {
                workspaceController.correctOption.value = value;
              }
            },
          ),

          Expanded(
            child: TextFormField(
              controller: controller,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Option $optionNumber is required";
                }

                return null;
              },
              decoration: InputDecoration(
                labelText: "Option $optionNumber",
                hintText: "Enter option $optionNumber",
                border: const OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
