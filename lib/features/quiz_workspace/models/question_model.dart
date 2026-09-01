import 'package:ss_admin_dashboard/features/quiz_workspace/models/option_model.dart';

class QuestionModel {
  String? id;
  String? quizId;
  String? questionText;
  String? explanation;
  List<String>? category;
  String? difficulty;
  int? position;
  String? createdAt;
  String? updatedAt;

  List<OptionModel>? options;

  QuestionModel({
    this.id,
    this.quizId,
    this.questionText,
    this.explanation,
    this.category,
    this.difficulty,
    this.position,
    this.createdAt,
    this.updatedAt,
    this.options,
  });

  QuestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quizId = json['quizId'];
    questionText = json['questionText'];
    explanation = json['explanation'];

    category = json['category'] != null
        ? List<String>.from(json['category'])
        : null;

    difficulty = json['difficulty'];
    position = json['position'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];

    if (json['options'] != null) {
      options = (json['options'] as List)
          .map((option) => OptionModel.fromJson(option))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quizId': quizId,
      'questionText': questionText,
      'explanation': explanation,
      'category': category,
      'difficulty': difficulty,
      'position': position,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'options': options?.map((option) => option.toJson()).toList(),
    };
  }
}
