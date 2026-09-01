import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/era/controller/era_controller.dart';
import 'package:ss_admin_dashboard/features/era/widgets/era_dialogue.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class AddEraCard extends StatelessWidget {
  const AddEraCard({super.key});

  @override
  Widget build(BuildContext context) {
    final eraController = Get.find<EraController>();
    return SizedBox(
      height: 200,
      width: 300,
      child: Card(
        color: AppColors.goldBorderColor,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: () {
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
          splashColor: AppColors.primaryColor,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, fontWeight: FontWeight.bold, size: 34),
              Text("Add Era"),
            ],
          ),
        ),
      ),
    );
  }
}
