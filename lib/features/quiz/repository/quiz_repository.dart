import 'package:ss_admin_dashboard/core/constants/app_urls.dart';
import 'package:ss_admin_dashboard/core/network/base_api_services.dart';
import 'package:ss_admin_dashboard/core/network/network_api_services.dart';
import 'package:ss_admin_dashboard/features/quiz/model/quiz_list_model.dart';
import 'package:ss_admin_dashboard/features/quiz/model/quiz_model.dart';

class QuizRepository {
  final BaseApiServices _api = NetworkApiServices();

  // Get  All the Quizzes
  Future<List<QuizListModel>> getQuizzes() async {
    final response = await _api.getApi(AppUrls.getQuizzes);
    final List<dynamic> data = response['data'];

    final List<QuizListModel> quizzesList = data
        .map((item) => QuizListModel.fromJson(item))
        .toList();

    return quizzesList;
  }

  // Get Quiz of a Story -( initially 1 per story)
  Future<QuizModel> getQuiz(String quizId) async {
    final response = await _api.getApi(AppUrls.getQuiz(quizId));
    final QuizModel data = QuizModel.fromJson(response['data']);

    return data;
  }

  // Create a Quiz
  Future<QuizModel> createQuiz(QuizModel quiz, String storyId) async {
    final response = await _api.postApi(
    
      AppUrls.createQuiz(storyId),
      data: quiz.toJson(),
    );

    return QuizModel.fromJson(response['data']);
  }

  // Update Quiz
  Future<QuizModel> updateQuiz(QuizModel quiz, String quizId) async {
    final response = await _api.putApi(
      quiz.toJson(),

      AppUrls.updateQuiz(quizId),
    );

    return QuizModel.fromJson(response['data']);
  }

  // Delete Quiz
  Future<void> deleteQuiz(String id) async {
    await _api.deleteApi(AppUrls.deleteQuiz(id));
  }
}
