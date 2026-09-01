import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/core/response/api_response.dart';
import 'package:ss_admin_dashboard/features/quiz/model/quiz_list_model.dart';
import 'package:ss_admin_dashboard/features/quiz/model/quiz_model.dart';
import 'package:ss_admin_dashboard/features/quiz/repository/quiz_repository.dart';

class QuizController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getQuizzes();
  }

  final _repository = QuizRepository();

  final RxnString selectedStoryId = RxnString();
  final RxnString selectedQuizId = RxnString();
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final quizzesResponse = ApiResponse<List<QuizListModel>>.loading().obs;
  final quizResponse = ApiResponse<QuizModel>.loading().obs;

  RxBool isLoading = false.obs;
  RxBool isUpdating = false.obs;

  // ---------------------
  // Search Filter Start
  // ---------------------
  final RxnString selectedEraIdFilter = RxnString();
  final searchTextController = TextEditingController();
  RxString searchText = ''.obs;

  List<QuizListModel> get filteredQuizzes {
    final quizzes = quizzesResponse.value.data ?? [];

    return quizzes.where((quiz) {
      // Search
      final search = searchText.value.trim().toLowerCase();

      final matchesSearch =
          search.isEmpty ||
          (quiz.title ?? '').toLowerCase().contains(search) ||
          (quiz.story!.title ?? '').toLowerCase().contains(search);

      // Era
      final matchesEra =
          selectedEraIdFilter.value == null ||
          quiz.story!.era!.id == selectedEraIdFilter.value;

      return matchesEra && matchesSearch;
    }).toList();
  }

  void clearFilters() {
    selectedEraIdFilter.value = null;
    searchText.value = '';
    searchTextController.clear();
  }

  // ---------------------
  // Search Filter Ends
  // ---------------------

  // Get quizzes
  Future<void> getQuizzes() async {
    try {
      quizzesResponse.value = ApiResponse.loading();
      final quizzes = await _repository.getQuizzes();
      quizzesResponse.value = ApiResponse.completed(quizzes);
    } catch (e) {
      quizzesResponse.value = ApiResponse.error(e.toString());
    }
  }

  // Get the quiz of a Story
  Future<void> getQuiz(String quizId) async {
    try {
      quizResponse.value = ApiResponse.loading();
      final quizData = await _repository.getQuiz(quizId);
      quizResponse.value = ApiResponse.completed(quizData);
    } catch (e) {
      quizResponse.value = ApiResponse.error(e.toString());
    }
  }

  // Create a Quiz
  Future<void> createQuiz() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      isLoading.value = true;

      final quizData = QuizModel(
        storyId: selectedStoryId.value,
        title: titleController.text.trim(),
      );

      await _repository.createQuiz(quizData, selectedStoryId.value!);

      await getQuizzes();
      Get.back();
    } catch (error) {
      debugPrint(error.toString());
      Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Update the Quiz
  Future<void> updateQUiz() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      isLoading.value = true;
      isUpdating.value = true;

      final quiz = QuizModel(title: titleController.text);
      await _repository.updateQuiz(quiz, selectedQuizId.value!);

      await getQuizzes();
      Get.back();
    } catch (error) {
      debugPrint(error.toString());
      Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
      isUpdating.value = false;
    }
  }

  // Delete The Quiz
  Future<void> deleteQuiz(String quizId) async {
    try {
      isLoading.value = true;
      await _repository.deleteQuiz(quizId);
      await getQuizzes();
      Get.back();
    } catch (error) {
      debugPrint(error.toString());
      Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Load the Quiz Details
  dynamic loadQuizDetails(QuizListModel quiz) {
    isUpdating.value = true;
    selectedQuizId.value = quiz.id;
    selectedStoryId.value = quiz.storyId;
    titleController.text = quiz.title!;
  }

  dynamic clearForm() {
    selectedStoryId.value = null;
    titleController.clear();
    isUpdating.value = false;
  }
}
