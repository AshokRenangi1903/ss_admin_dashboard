import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/core/response/status.dart';
import 'package:ss_admin_dashboard/core/routes/routes_name.dart';
import 'package:ss_admin_dashboard/features/era/controller/era_controller.dart';
import 'package:ss_admin_dashboard/features/era/widgets/add_era_card.dart';
import 'package:ss_admin_dashboard/features/era/widgets/era_card.dart';
import 'package:ss_admin_dashboard/features/era/widgets/era_dialogue.dart';
import 'package:ss_admin_dashboard/features/era/widgets/shimmmer_era_list.dart';
import 'package:ss_admin_dashboard/features/story/controller/story_controller.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/empty_box.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/loading_dots.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';

class EraGrid extends StatelessWidget {
  const EraGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final eraController = Get.find<EraController>();
    final storyController = Get.find<StoryController>();

    return Obx(() {
      final response = eraController.erasResponse.value;

      switch (response.status) {
        case Status.loading:
          return ShimmerEraList();

        case Status.error:
          return Column(
            children: [
              EmptyBox(),
              Text(response.message ?? "Something went wrong"),
            ],
          );

        case Status.completed:
          final eras = response.data!;

          return GridView.builder(
            itemCount: eras.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Number of columns
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              // childAspectRatio: 0.85, // Controls item height/width ratio
            ),
            itemBuilder: (context, index) {
              final isLastEra = eras.length == index;
              return isLastEra
                  ? AddEraCard()
                  : EraCard(
                      title: eras[index].title!,
                      startYear: eras[index].startYear!,
                      endYear: eras[index].endYear!,
                      imageUrl: eras[index].imageUrl!,
                      storiesCount: eras[index].storiesCount!,
                      onTap: () async {
                        final era = eras[index];
                        final eraId = era.id!;

                        storyController.selectedEraId.value = eraId;
                        storyController.isOrderChanged.value = false;

                        await Get.toNamed(
                          RoutesName.eraStories.replaceFirst(':eraId', eraId),
                        );
                      },
                      onDelete: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) {
                            return Obx(() {
                              final isLoading = eraController.isLoading.value;
                              return Stack(
                                children: [
                                  AlertDialog(
                                    content: Text(
                                      "Do you really wnat to delete this era?",
                                    ),
                                    actions: [
                                      AppButton(
                                        text: "Cancel",
                                        onPressed: () {
                                          Get.back();
                                        },
                                      ),
                                      AppButton(
                                        text: "Delete",
                                        backgroundColor: Colors.red,
                                        onPressed: () {
                                          eraController.deleteEra(
                                            eras[index].id!,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  if (isLoading) LoadingDots(),
                                ],
                              );
                            });
                          },
                        );
                      },
                      onUpdate: () {
                        eraController.loadEra(eras[index]);

                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) {
                            return EraDialogue(
                              title: "Update Era",
                              buttonText: "Update",
                              onSave: eraController.updateEra,
                            );
                          },
                        );
                      },
                    );
            },
          );

        default:
          return SliverToBoxAdapter(child: const SizedBox());
      }
    });
  }
}
