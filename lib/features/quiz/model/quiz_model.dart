import 'package:ss_admin_dashboard/features/quiz_workspace/models/question_model.dart';

class QuizModel {
  String? id;
  String? storyId;
  String? title;
  int? timeLimit;
  int? marksPerQuestion;
  String? createdAt;
  String? updatedAt;

  List<QuestionModel>? questions;

  QuizModel({
    this.id,
    this.storyId,
    this.title,
    this.timeLimit,
    this.marksPerQuestion,
    this.createdAt,
    this.updatedAt,
    this.questions,
  });

  QuizModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storyId = json['storyId'];
    title = json['title'];
    timeLimit = json['timeLimit'];
    marksPerQuestion = json['marksPerQuestion'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];

    if (json['questions'] != null) {
      questions = (json['questions'] as List)
          .map((question) => QuestionModel.fromJson(question))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'storyId': storyId,
      'title': title,
      'timeLimit': timeLimit,
      'marksPerQuestion': marksPerQuestion,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'questions': questions?.map((question) => question.toJson()).toList(),
    };
  }
}
