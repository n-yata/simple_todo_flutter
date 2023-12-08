import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/model/todo.dart';

/// TODOリストを管理するシングルトンクラス
class TodoItems {
  final String _saveKey = "Todo";
  List<Todo> _list = [];
  static final TodoItems _instance = TodoItems._internal();

  TodoItems._internal();

  factory TodoItems() {
    return _instance;
  }

  /// TODOリストアイテムの件数を取得する
  int count() {
    return _list.length;
  }

  /// TODOリストデータをロードする
  void loadItems() {
    _load();
  }

  /// 指定したインデックスのTODOを取得する
  Todo findByIndex(int index) {
    return _list[index];
  }

  /// TODOを追加する
  void add(bool done, String title, String? detail) {
    var id = count() == 0 ? 1 : _list.last.id + 1;
    var dateTime = _getDateTime();
    var todo = Todo(id, title, detail, done, dateTime, dateTime);
    _list.add(todo);
    _save();
  }

  /// TODOを更新する
  void update(Todo todo, bool done, [String? title, String? detail]) {
    todo.done = done;
    if (title != null) {
      todo.title = title;
    }
    if (detail != null) {
      todo.detail = detail;
    }
    todo.updatedAt = _getDateTime();
    _save();
  }

  /// TODOを削除する
  void delete(Todo todo) {
    _list.remove(todo);
    _save();
  }

  /// 現在日時を取得する
  String _getDateTime() {
    var format = DateFormat("yyyy/MM/dd HH:mm");
    var dateTime = format.format(DateTime.now());
    return dateTime;
  }

  /// TODOを保存する
  void _save() async {
    var prefs = await SharedPreferences.getInstance();
    var saveTargetList = _list.map((a) => json.encode(a.toJson())).toList();
    prefs.setStringList(_saveKey, saveTargetList);
  }

  /// TODOリストを読み込む
  void _load() async {
    var prefs = await SharedPreferences.getInstance();
    var loadTargetList = prefs.getStringList(_saveKey) ?? [];
    _list = loadTargetList.map((a) => Todo.fromJson(json.decode(a))).toList();
  }
}
