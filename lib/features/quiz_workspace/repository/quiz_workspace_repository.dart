import 'package:ss_admin_dashboard/core/constants/app_urls.dart';
import 'package:ss_admin_dashboard/core/network/base_api_services.dart';
import 'package:ss_admin_dashboard/core/network/network_api_services.dart';
import 'package:ss_admin_dashboard/features/quiz_workspace/models/question_model.dart';

class QuizWorkspaceRepository {
  final BaseApiServices _api = NetworkApiServices();

  // Create Question + Options
  Future<QuestionModel> createQuestion(
    QuestionModel question,
    String quizId,
  ) async {
    final response = await _api.postApi(
     
      AppUrls.createQuestion(quizId),
      data: question.toJson(),
    );

    return QuestionModel.fromJson(response['data']);
  }

  // Update the question
  Future<QuestionModel> updateQuestion(
    QuestionModel question,
    String questionId,
  ) async {
    final response = await _api.putApi(
      question.toJson(),
     
      AppUrls.updateQuestion(questionId),
    );

    return QuestionModel.fromJson(response['data']);
  }

  // Delete the Question
  Future<void> deleteQuestion(String questionId) async {
    await _api.deleteApi(AppUrls.deleteQuestion(questionId));
  }
}
