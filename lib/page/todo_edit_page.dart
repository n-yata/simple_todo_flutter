import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/shared/todo_list_item.dart';

class TodoDetailPage extends StatefulWidget {
  final Todo todo;

  /// TODOリストページのリスト更新Function
  final Function loadItems;

  const TodoDetailPage(
      {required this.todo, required this.loadItems, super.key});

  @override
  State<TodoDetailPage> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage> {
  final TodoItems _items = TodoItems();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.todo.title;
    widget.todo.detail ??= '';
    _detailController.text = widget.todo.detail!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _titleController,
            ),
            TextField(
              controller: _detailController,
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _items.update(widget.todo, widget.todo.done,
                      _titleController.text, _detailController.text);
                  widget.loadItems();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  '更新',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'キャンセル',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
