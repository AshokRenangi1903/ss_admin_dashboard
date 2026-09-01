import 'package:ss_admin_dashboard/features/quiz/model/story_info.dart';

class QuizListModel {
  String? id;
  String? storyId;
  String? title;
  int? marksPerQuestion;
  int? timeLimit;

  StoryInfo? story;

  String? createdAt;
  String? updatedAt;

  int? questionCount;

  QuizListModel({
    this.id,
    this.storyId,
    this.title,
    this.marksPerQuestion,
    this.timeLimit,
    this.story,
    this.createdAt,
    this.updatedAt,
    this.questionCount,
  });

  QuizListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storyId = json['storyId'];
    title = json['title'];
    marksPerQuestion = json['marksPerQuestion'];
    timeLimit = json['timeLimit'];

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];

    story = json['story'] != null ? StoryInfo.fromJson(json['story']) : null;

    questionCount = json['_count']?['questions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['storyId'] = storyId;
    data['title'] = title;
    data['marksPerQuestion'] = marksPerQuestion;
    data['timeLimit'] = timeLimit;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['questionCount'] = questionCount;

    if (story != null) {
      data['story'] = story!.toJson();
    }

    return data;
  }
}
