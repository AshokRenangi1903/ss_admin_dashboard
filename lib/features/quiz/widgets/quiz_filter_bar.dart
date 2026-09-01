import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/era/controller/era_controller.dart';
import 'package:ss_admin_dashboard/features/quiz/controller/quiz_controller.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';

class QuizFilterBar extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final eraController = Get.find<EraController>();
    final quizController = Get.find<QuizController>();
    return Container(
      color: Colors.white,

      child: Center(
        child: Column(
          children: [
            // -----------------
            // Search Bar
            // -----------------
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.darkText),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: TextFormField(
                      controller: quizController.searchTextController,
                      // initialValue: quizController.searchText.value,
                      onChanged: (value) {
                        quizController.searchText.value = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Search Quiz / Story ",
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Obx(
                      () => Text(
                        "${quizController.filteredQuizzes.length}",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text("quizzes", style: TextStyle(color: AppColors.midText)),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 18),
                // -----------------
                // Era DropDown
                // -----------------
                Expanded(
                  child: Obx(() {
                    final eras = eraController.erasResponse.value.data;
                    return DropdownButtonFormField<String>(
                      initialValue: quizController.selectedEraIdFilter.value,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Select Era';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Era",
                        border: OutlineInputBorder(),
                        hintText: "Select Era",
                      ),
                      items: [
                        DropdownMenuItem<String>(
                          value: null,
                          child: Text("All"),
                        ),
                        ...eras!.map((era) {
                          return DropdownMenuItem<String>(
                            value: era.id,
                            child: Text(era.title!),
                          );
                        }),
                      ],
                      onChanged: (value) {
                        quizController.selectedEraIdFilter.value = value;
                      },
                    );
                  }),
                ),
                SizedBox(width: 18),
                // -----------------
                // Clear Button
                // -----------------
                AppButton(
                  icon: Icons.clear,
                  text: "Clear Filter",
                  backgroundColor: Colors.red,
                  onPressed: quizController.clearFilters,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
