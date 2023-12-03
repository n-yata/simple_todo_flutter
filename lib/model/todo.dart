import 'package:flutter/cupertino.dart';

class Todo {
  late int id;
  late String title;
  String? detail;
  late bool done;
  late String createdAt;
  late String updatedAt;

  Todo(this.id, this.title, this.detail, this.done, this.createdAt,
      this.updatedAt);

  /// モデル to Map(Json)
  Map toJson() {
    return {
      'id': id,
      'title': title,
      'detail': detail,
      'done': done,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  /// Map(Json) to モデル
  Todo.fromJson(Map json) {
    id = json['id'];
    title = json['title'];
    detail = json['detail'];
    done = json['done'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}
