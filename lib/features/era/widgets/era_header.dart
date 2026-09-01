import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/era/controller/era_controller.dart';
import 'package:ss_admin_dashboard/features/era/widgets/era_dialogue.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';

class EraHeader extends StatelessWidget {
  const EraHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final eraController = Get.find<EraController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "All Eras",
                  style: TextStyle(
                    color: AppColors.darkText,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Text(
                  "Organize Science history into explorable time periods",
                  style: TextStyle(
                    color: AppColors.softText,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          AppButton(
            text: "Add Era",
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return EraDialogue(
                    title: "Era Details",
                    buttonText: "Create",
                    onSave: eraController.createEra,
                  );
                },
              );
            },
            icon: Icons.add,
          ),
        ],
      ),
    );
  }
}
