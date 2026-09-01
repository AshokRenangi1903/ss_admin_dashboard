import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/era/controller/era_controller.dart';
import 'package:ss_admin_dashboard/features/story/controller/story_controller.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';

class StoryFilterBar extends StatelessWidget {
  const StoryFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final storyController = Get.find<StoryController>();
    final eraController = Get.find<EraController>();
    return Container(
      color: Colors.white,

      child: Padding(
        padding: EdgeInsetsGeometry.all(12),
        child: Column(
          children: [
            // -----------------
            // Search Bar
            // -----------------
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.darkText),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: TextFormField(
                      controller: storyController.searchTextController,
                      // initialValue: storyController.searchText.value,
                      onChanged: (value) {
                        storyController.searchText.value = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Search title / description / scientist",
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
                        "${storyController.filteredStories.length}",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text("stories", style: TextStyle(color: AppColors.midText)),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // -----------------
                // Era DropDown
                // -----------------
                Expanded(
                  child: Obx(() {
                    final eras = eraController.erasResponse.value.data;
                    return DropdownButtonFormField<String>(
                      initialValue: storyController.selectedEraIdFilter.value,
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
                        storyController.selectedEraIdFilter.value = value;
                      },
                    );
                  }),
                ),
                SizedBox(width: 4),
                // --------------
                // Published
                // --------------
                Expanded(
                  child: Obx(
                    () => DropdownButtonFormField<bool?>(
                      initialValue: storyController.publishedFilter.value,
                      decoration: const InputDecoration(
                        labelText: "Published",
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem<bool?>(
                          value: null,
                          child: Text("All"),
                        ),
                        DropdownMenuItem<bool?>(
                          value: true,
                          child: Text("Published"),
                        ),
                        DropdownMenuItem<bool?>(
                          value: false,
                          child: Text("Unpublished"),
                        ),
                      ],
                      onChanged: (value) {
                        storyController.publishedFilter.value = value;
                      },
                    ),
                  ),
                ),
                SizedBox(width: 4),
                // -----------------
                // Popular
                // -----------------
                Expanded(
                  child: Obx(
                    () => DropdownButtonFormField<bool?>(
                      initialValue: storyController.popularFilter.value,
                      decoration: const InputDecoration(
                        labelText: "Popular",
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem<bool?>(
                          value: null,
                          child: Text("All"),
                        ),
                        DropdownMenuItem<bool?>(
                          value: true,
                          child: Text("Popular"),
                        ),
                        DropdownMenuItem<bool?>(
                          value: false,
                          child: Text("Not Popular"),
                        ),
                      ],
                      onChanged: (vaue) {
                        storyController.popularFilter.value = vaue;
                      },
                    ),
                  ),
                ),
                SizedBox(width: 4),
                // -----------------
                // Clear Button
                // -----------------
                AppButton(
                  icon: Icons.clear,
                  text: "Clear Filter",
                  backgroundColor: Colors.red,
                  onPressed: storyController.clearFilters,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
