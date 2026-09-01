import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/core/response/api_response.dart';
import 'package:ss_admin_dashboard/features/story/model/story_model.dart';
import 'package:ss_admin_dashboard/features/story/repository/story_repository.dart';

class StoryController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getAllStories();
  }

  final StoryRepository _repository = StoryRepository();
  final ScrollController storiesScrollController = ScrollController();
  final storiesResponse = ApiResponse<List<StoryModel>>.loading().obs;
  final eraStoriesResponse = ApiResponse<List<StoryModel>>.loading().obs;
  RxBool isLoading = false.obs;
  RxBool isOrderChanged = false.obs;

  // Story  Dialog Fields
  final formKey = GlobalKey<FormState>();

  final RxnString selectedEraId = RxnString();
  final Rxn<StoryModel> selectedStory = Rxn<StoryModel>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final disciplineController = TextEditingController();
  final subjectController = TextEditingController();
  final imageUrlController = TextEditingController();
  final geolocationController = TextEditingController();
  final estimatedReadTimeController = TextEditingController();
  final scientistsController = TextEditingController();

  final RxBool isPublished = false.obs;
  final RxBool isPopular = false.obs;
  final RxBool isUpdating = false.obs;

  // ---------------------
  // Search Filter Start
  // ---------------------
  final searchTextController = TextEditingController();
  final RxnString selectedEraIdFilter = RxnString();
  RxString searchText = ''.obs;
  final publishedFilter = RxnBool();
  final popularFilter = RxnBool();

  List<StoryModel> get filteredStories {
    final stories = storiesResponse.value.data ?? [];

    return stories.where((story) {
      // Search
      final search = searchText.value.trim().toLowerCase();

      final matchesScientist =
          story.scientistNames?.any(
            (scientist) => scientist.toLowerCase().contains(search),
          ) ??
          false;
      final matchesSearch =
          search.isEmpty ||
          (story.title ?? '').toLowerCase().contains(search) ||
          (story.description ?? '').toLowerCase().contains(search) ||
          matchesScientist;

      // Era
      final matchesEra =
          selectedEraIdFilter.value == null ||
          story.eraId == selectedEraIdFilter.value;

      // Published
      final matchesPublished =
          publishedFilter.value == null ||
          story.isPublished == publishedFilter.value;

      // Popular
      final matchesPopular =
          popularFilter.value == null || story.isPopular == popularFilter.value;

      return matchesEra && matchesSearch && matchesPublished && matchesPopular;
    }).toList();
  }

  void clearFilters() {
    publishedFilter.value = null;
    popularFilter.value = null;
    selectedEraIdFilter.value = null;
    searchText.value = '';
    searchTextController.clear();
  }

  // ---------------------
  // Search Filter Ends
  // ---------------------

  // Get all stories
  Future<void> getAllStories() async {
    try {
      storiesResponse.value = ApiResponse.loading();
      final stories = await _repository.getAllStories();
      storiesResponse.value = ApiResponse.completed(stories);
    } catch (e) {
      storiesResponse.value = ApiResponse.error(e.toString());
    }
  }

  // Get all stories
  Future<void> getEraStories(String eraId) async {
    try {
      eraStoriesResponse.value = ApiResponse.loading();
      final stories = await _repository.getEraStories(eraId);
      eraStoriesResponse.value = ApiResponse.completed(stories);
    } catch (e) {
      eraStoriesResponse.value = ApiResponse.error(e.toString());
    }
  }

  // Create a Story
  Future<void> createStory() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      isLoading.value = true;
      final List<String> scientistNames = scientistsController.text
          .split(',')
          .map((name) => name.trim())
          .where((name) => name.isNotEmpty)
          .toList();

      final story = StoryModel(
        eraId: selectedEraId.value,
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        imageUrl: imageUrlController.text.trim(),

        discipline: disciplineController.text.trim(),
        geolocation: geolocationController.text.trim(),
        estimatedReadTime: estimatedReadTimeController.text.trim(),
        subject: subjectController.text.trim(),

        isPublished: isPublished.value,
        isPopular: isPopular.value,
        scientistNames: scientistNames,
      );

      await _repository.createStory(story, selectedEraId.value!);

      clearForm();
      await getAllStories();
      Get.back();
    } catch (error) {
      debugPrint(error.toString());
      Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Load Story Details
  void loadStoryDetails(StoryModel story) {
    try {
      selectedEraId.value = story.eraId;
      selectedStory.value = story;
      titleController.text = story.title ?? '';
      descriptionController.text = story.description ?? '';
      imageUrlController.text = story.imageUrl ?? '';
      disciplineController.text = story.discipline ?? '';
      geolocationController.text = story.geolocation ?? '';
      estimatedReadTimeController.text = story.estimatedReadTime ?? '';
      subjectController.text = story.subject ?? '';
      scientistsController.text = (story.scientistNames ?? []).join(", ");

      isPublished.value = story.isPublished!;
      isPopular.value = story.isPopular!;
    } catch (err) {
      print("error is : " + err.toString());
    }
  }

  // Update a Story
  Future<void> updateStory() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      isLoading.value = true;
      isUpdating.value = true;
      final List<String> scientistNames = scientistsController.text
          .split(',')
          .map((name) => name.trim())
          .where((name) => name.isNotEmpty)
          .toList();

      final story = StoryModel(
        eraId: selectedEraId.value,
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        imageUrl: imageUrlController.text.trim(),
        position: selectedStory.value!.position,
        discipline: disciplineController.text.trim(),
        geolocation: geolocationController.text.trim(),
        estimatedReadTime: estimatedReadTimeController.text.trim(),
        subject: subjectController.text.trim(),

        isPublished: isPublished.value,
        isPopular: isPopular.value,
        scientistNames: scientistNames,
      );

      await _repository.updateStory(story, selectedStory.value!.id!);

      clearForm();
      await getAllStories();
      Get.back();
    } catch (error) {
      debugPrint(error.toString());
      Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
      isUpdating.value = false;
    }
  }

  // Delete Story
  Future<void> deleteStory(String id) async {
    try {
      isLoading.value = true;
      await _repository.deleteStory(id);
      await getAllStories();
      Get.back();
    } catch (error) {
      debugPrint(error.toString());
      Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // ------------------------
  // Reorder Stories started
  // ------------------------
  void reorderStories(int oldIndex, int newIndex) {
    final stories = eraStoriesResponse.value.data!;

    if (newIndex > oldIndex) {
      newIndex--;
    }

    final story = stories.removeAt(oldIndex);
    stories.insert(newIndex, story);

    eraStoriesResponse.refresh();
    isOrderChanged.value = true;
  }

  Future<void> saveStoriesOrder() async {
    final stories = eraStoriesResponse.value.data!;

    final List<String> orderedIds = stories.map((story) => story.id!).toList();
    try {
      isLoading.value = true;

      await _repository.reorderStories(orderedIds, selectedEraId.value!);

      isOrderChanged.value = false;
      Get.snackbar("Success", "Reordered the stories Successfully.");
    } catch (error) {
      Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // ------------------------
  // Reorder Stories ended
  // ------------------------

  // clear the form
  void clearForm() {
    selectedStory.value = null;
    selectedEraId.value = null;
    titleController.clear();
    descriptionController.clear();
    subjectController.clear();
    disciplineController.clear();
    imageUrlController.clear();
    geolocationController.clear();
    estimatedReadTimeController.clear();
    scientistsController.clear();
    isPublished.value = false;
    isPopular.value = false;
  }
}
