import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/quiz/controller/quiz_controller.dart';
import 'package:ss_admin_dashboard/features/quiz/model/quiz_list_model.dart';
import 'package:ss_admin_dashboard/features/quiz_workspace/models/option_model.dart';
import 'package:ss_admin_dashboard/features/quiz_workspace/models/question_model.dart';
import 'package:ss_admin_dashboard/features/quiz_workspace/repository/quiz_workspace_repository.dart';

class QuizWorkspaceController extends GetxController {
  late final QuizListModel quiz;
  @override
  void onInit() {
    super.onInit();
    quiz = Get.arguments as QuizListModel;
  }

  final ScrollController scrollController = ScrollController();
  final quizController = Get.find<QuizController>();
  final _repository = QuizWorkspaceRepository();

  final RxBool isCreatingQuestion = false.obs;
  final RxBool isEditingQuestion = false.obs;

  QuestionModel? editingQuestion;
  final RxBool isLoading = false.obs;

  final questionFormKey = GlobalKey<FormState>();
  final questionFormKeyWidget = GlobalKey();

  final questionTextController = TextEditingController();
  final explanationController = TextEditingController();
  final categoryController = TextEditingController();
  final option1Controller = TextEditingController();
  final option2Controller = TextEditingController();
  final option3Controller = TextEditingController();
  final option4Controller = TextEditingController();

  final RxInt correctOption = 1.obs;

  final RxString selectedDifficulty = "EASY".obs;
  void startCreatingQuestion() {
    clearQuestionForm();
    isCreatingQuestion.value = true;
    scrollToQuestionForm();
  }

  void cancelCreatingQuestion() {
    clearQuestionForm();
    isCreatingQuestion.value = false;
    isEditingQuestion.value = false;
  }

  void clearQuestionForm() {
    questionTextController.clear();
    explanationController.clear();
    categoryController.clear();

    option1Controller.clear();
    option2Controller.clear();
    option3Controller.clear();
    option4Controller.clear();

    correctOption.value = 1;
    selectedDifficulty.value = "EASY";
  }

  void startEditingQuestion(QuestionModel question) {
    editingQuestion = question;

    questionTextController.text = question.questionText ?? '';
    explanationController.text = question.explanation ?? '';

    categoryController.text = question.category?.join(', ') ?? '';

    selectedDifficulty.value = question.difficulty ?? 'EASY';

    option1Controller.text = question.options?[0].optionText ?? '';

    option2Controller.text = question.options?[1].optionText ?? '';

    option3Controller.text = question.options?[2].optionText ?? '';

    option4Controller.text = question.options?[3].optionText ?? '';

    final correctIndex =
        question.options?.indexWhere((option) => option.isCorrect == true) ?? 0;

    correctOption.value = correctIndex >= 0 ? correctIndex + 1 : 1;

    isEditingQuestion.value = true;
    scrollToQuestionForm();
  }

  void cancelEditingQuestion() {
    clearQuestionForm();
    editingQuestion = null;
    isEditingQuestion.value = false;
  }

  // ---------------------------------------
  // Create New Question
  // ---------------------------------------
  Future<void> createQuestion() async {
    // Validate form
    if (!questionFormKey.currentState!.validate()) {
      return;
    }
    try {
      isLoading.value = true;
      // Convert categories from comma-separated text to List<String>
      final categories = categoryController.text
          .split(',')
          .map((category) => category.trim())
          .where((category) => category.isNotEmpty)
          .toList();

      // Collect options
      final options = [
        {
          "optionText": option1Controller.text.trim(),
          "isCorrect": correctOption.value == 1,
          "position": 1,
        },
        {
          "optionText": option2Controller.text.trim(),
          "isCorrect": correctOption.value == 2,
          "position": 2,
        },
        {
          "optionText": option3Controller.text.trim(),
          "isCorrect": correctOption.value == 3,
          "position": 3,
        },
        {
          "optionText": option4Controller.text.trim(),
          "isCorrect": correctOption.value == 4,
          "position": 4,
        },
      ];

      final data = {
        "questionText": questionTextController.text.trim(),
        "explanation": explanationController.text.trim(),
        "category": categories,
        "difficulty": selectedDifficulty.value,
        "options": options,
      };

      await _repository.createQuestion(QuestionModel.fromJson(data), quiz.id!);

      Get.snackbar(
        "New Question Added",
        "Successfully Added a new question '${questionTextController.text}'",
      );
      cancelCreatingQuestion();
      await quizController.getQuiz(quiz.id!);
      scrollToBottom();
      await quizController.getQuizzes();

      debugPrint(data.toString());
    } catch (error) {
      debugPrint(error.toString());
      Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // -----------------------------
  // Updating the question
  // -----------------------------
  Future<void> updateQuestion() async {
    try {
      isLoading.value = true;

      final categories = categoryController.text
          .split(',')
          .map((category) => category.trim())
          .where((category) => category.isNotEmpty)
          .toList();

      final options = [
        OptionModel(
          id: editingQuestion!.options![0].id,
          questionId: editingQuestion!.id,
          optionText: option1Controller.text.trim(),
          position: 1,
          isCorrect: correctOption.value == 1,
        ),
        OptionModel(
          id: editingQuestion!.options![1].id,
          questionId: editingQuestion!.id,
          optionText: option2Controller.text.trim(),
          position: 2,
          isCorrect: correctOption.value == 2,
        ),
        OptionModel(
          id: editingQuestion!.options![2].id,
          questionId: editingQuestion!.id,
          optionText: option3Controller.text.trim(),
          position: 3,
          isCorrect: correctOption.value == 3,
        ),
        OptionModel(
          id: editingQuestion!.options![3].id,
          questionId: editingQuestion!.id,
          optionText: option4Controller.text.trim(),
          position: 4,
          isCorrect: correctOption.value == 4,
        ),
      ];

      final question = QuestionModel(
        id: editingQuestion!.id,
        quizId: quiz.id,
        questionText: questionTextController.text.trim(),
        explanation: explanationController.text.trim(),
        category: categories,
        difficulty: selectedDifficulty.value,
        position: editingQuestion!.position,
        options: options,
      );

      await _repository.updateQuestion(question, editingQuestion!.id!);

      await quizController.getQuiz(quiz.id!);

      cancelEditingQuestion();

      Get.snackbar("Success", "Question updated successfully");
    } catch (error) {
      Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
      cancelEditingQuestion();
    }
  }

  // -------------------------------------------
  // Saving the question - create or update
  // -------------------------------------------
  Future<void> saveQuestion() async {
    if (!questionFormKey.currentState!.validate()) {
      return;
    }

    if (isEditingQuestion.value) {
      await updateQuestion();
    } else {
      await createQuestion();
    }
  }

  // ------------------------
  // Delete a Question
  // -----------------------
  Future<void> deleteQuestion(QuestionModel question) async {
    try {
      isLoading.value = true;

      await _repository.deleteQuestion(question.id!);
      cancelCreatingQuestion();
      Get.back();
      Get.snackbar("Deleted!!", "Question is deleted successfully!");

      await quizController.getQuiz(quiz.id!);

      await quizController.getQuizzes();
    } catch (error) {
      Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // ------------------
  // Scroll Controllers
  // -------------------
  void scrollToQuestionForm() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = questionFormKeyWidget.currentContext;

      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          alignment: 0.0,
        );
      }
    });
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  //------------------
  // OnClose Method
  // -----------------

  @override
  void onClose() {
    scrollController.dispose();
    questionTextController.dispose();
    explanationController.dispose();
    categoryController.dispose();

    option1Controller.dispose();
    option2Controller.dispose();
    option3Controller.dispose();
    option4Controller.dispose();

    super.onClose();
  }
}
