import 'package:ss_admin_dashboard/features/story_workspace/story_blocks/models/content_type.dart';

class StoryBlockModel {
  String? id;
  String? storyId;
  ContentType? type;
  String? label;

  Map<String, dynamic>? content;

  int? position;

  DateTime? createdAt;
  DateTime? updatedAt;

  StoryBlockModel({
    this.id,
    this.storyId,
    this.type,
    this.label,
    this.content,
    this.position,
    this.createdAt,
    this.updatedAt,
  });

  factory StoryBlockModel.fromJson(Map<String, dynamic> json) {
    return StoryBlockModel(
      id: json["id"],
      storyId: json["storyId"],
      type: ContentType.values.firstWhere(
        (e) => e.name == json["type"].toString().toLowerCase(),
      ),
      label: json["label"],
      content: json["content"] != null
          ? Map<String, dynamic>.from(json["content"])
          : null,
      position: json["position"],
      createdAt: json["createdAt"] != null
          ? DateTime.parse(json["createdAt"])
          : null,
      updatedAt: json["updatedAt"] != null
          ? DateTime.parse(json["updatedAt"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "storyId": storyId,
      "type": type?.name.toUpperCase(),
      "label": label,
      "content": content,
      "position": position,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
    };
  }
}
