import 'dart:convert';

class RecordingModel {
  static const String status_empty = "EMPTY";
  static const String status_verified = "VERIFIED";
  static const String status_processing = "PROCESSING";
  static const String status_failed = "FAILED";
  static const String status_ready = "READY";

  static const String video_type = "VIDEO";
  static const String audio_type = "AUDIO";
  static const String image_type = "IMAGE";

  String? type;
  String? token;
  String? key;
  String? state;
  String? title;
  String? description;
  List<String>? tags;
  int? created = 0;

  RecordingModel(
      {this.type,
      this.token,
      this.key,
      this.state,
      this.title,
      this.description,
      this.tags,
      this.created = 0});

  factory RecordingModel.fromJson(Map<String, dynamic> json, String type) {
    return RecordingModel(
      type: type,
      token: json['token'],
      key: json['key'],
      state: json['state_string'],
      title: json['title'],
      description: json['description'],
      tags: (json['tags'] != null && json['tags'] is List)
          ? json['tags']?.cast<String>()
          : null,
      created: json['created'],
    );
  }

  String toJson() {
    Map<String, dynamic> map = Map();
    map['token'] = token;
    map['key'] = key;
    map['state_string'] = state;
    map['title'] = title;
    map['description'] = description;
    map['tags'] = tags;
    map['created'] = created;
    return jsonEncode(map);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map['token'] = token;
    map['key'] = key;
    map['state_string'] = state;
    map['title'] = title;
    map['description'] = description;
    map['tags'] = (tags != null &&
            tags?.cast<String>() != null &&
            tags!.cast<String>().isNotEmpty)
        ? tags!.cast<String>()
        : '';
    map['created'] = (created != null) ? created!.toString() : '';
    return map;
  }
}
