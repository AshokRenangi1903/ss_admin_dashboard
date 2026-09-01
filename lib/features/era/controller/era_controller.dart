import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/core/response/api_response.dart';
import 'package:ss_admin_dashboard/features/era/model/era_model.dart';
import 'package:ss_admin_dashboard/features/era/repository/era_repository.dart';
import 'package:ss_admin_dashboard/features/story/controller/story_controller.dart';

class EraController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getAllEras();
  }

  final EraRepository _repository = EraRepository();
  final storyController = Get.find<StoryController>();

  final erasResponse = ApiResponse<List<EraModel>>.loading().obs;

  // Get Eras
  Future<void> getAllEras() async {
    try {
      erasResponse.value = ApiResponse.loading();
      final eras = await _repository.getAllEras();
      erasResponse.value = ApiResponse.completed(eras);
    } catch (e) {
      erasResponse.value = ApiResponse.error(e.toString());
    }
  }

  // Era Dialog Fields
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final startYearController = TextEditingController();
  final endYearController = TextEditingController();
  final imageUrlController = TextEditingController();
  final RxBool isPublished = false.obs;

  final Rxn<EraModel> selectedEra = Rxn<EraModel>();

  // Create Era
  Future<void> createEra() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;

      final era = EraModel(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        startYear: startYearController.text.trim(),
        endYear: endYearController.text.trim(),
        imageUrl: imageUrlController.text.trim(),
        isPublished: isPublished.value,
      );
      await _repository.createEra(era);

      clearForm();
      await getAllEras();
      Get.back();
    } catch (error) {
      debugPrint(error.toString());
      Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Update Era

  void loadEra(EraModel era) {
    selectedEra.value = era;
    titleController.text = era.title!;
    descriptionController.text = era.description!;
    startYearController.text = era.startYear!;
    endYearController.text = era.endYear!;
    imageUrlController.text = era.imageUrl!;
    isPublished.value = era.isPublished!;
  }

  Future<void> updateEra() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      isLoading.value = true;
      final era = EraModel(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        startYear: startYearController.text.trim(),
        endYear: endYearController.text.trim(),
        imageUrl: imageUrlController.text.trim(),
        isPublished: isPublished.value,
      );
      await _repository.updateEra(selectedEra.value!.id!, era);

      clearForm();
      await getAllEras();
      await storyController.getAllStories();

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
      Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Delete Era
  Future<void> deleteEra(String id) async {
    try {
      isLoading.value = true;
      await _repository.deleteEra(id);
      await getAllEras();
      await storyController.getAllStories();
      Get.back();
    } catch (error) {
      debugPrint(error.toString());
      Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // clear Form
  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    startYearController.clear();
    endYearController.clear();
    imageUrlController.clear();
    isPublished.value = false; // or false, depending on your default
  }

  // Disposing
  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    startYearController.dispose();
    endYearController.dispose();
    imageUrlController.dispose();
    super.onClose();
  }
}
