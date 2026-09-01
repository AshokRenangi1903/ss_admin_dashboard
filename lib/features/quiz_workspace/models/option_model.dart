class OptionModel {
  String? id;
  String? questionId;
  String? optionText;
  int? position;
  bool? isCorrect;
  String? createdAt;
  String? updatedAt;

  OptionModel({
    this.id,
    this.questionId,
    this.optionText,
    this.position,
    this.isCorrect,
    this.createdAt,
    this.updatedAt,
  });

  OptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionId = json['questionId'];
    optionText = json['optionText'];
    position = json['position'];
    isCorrect = json['isCorrect'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionId': questionId,
      'optionText': optionText,
      'position': position,
      'isCorrect': isCorrect,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}