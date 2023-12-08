import 'package:flutter/material.dart';
import 'package:todo_app/const/constants.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/shared/todo_list_item.dart';

/// TODO詳細表示ページ
class TodoDetailPage extends StatefulWidget {
  final Todo todo;
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
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.todo.updatedAt,
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                Checkbox(
                  value: widget.todo.done,
                  onChanged: (bool? value) {
                    setState(() => widget.todo.done = value!);
                  },
                ),
              ],
            ),
            buildTitleField(),
            const SizedBox(height: 20),
            Expanded(
              child: buildDetailField(),
            ),
            const SizedBox(height: 20),
            buildActionButton(context),
          ],
        ),
      ),
    );
  }

  TextField buildTitleField() {
    return TextField(
      controller: _titleController,
    );
  }

  Container buildDetailField() {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _detailController,
        maxLines: null,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: TodoTexts.detailInput,
        ),
      ),
    );
  }

  Row buildActionButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            onPressed: () {
              _items.update(widget.todo, widget.todo.done,
                  _titleController.text, _detailController.text);
              widget.loadItems();
              Navigator.of(context).pop();
            },
            child: const Text(
              TodoTexts.update,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              _items.delete(widget.todo);
              widget.loadItems();
              Navigator.of(context).pop();
            },
            child: const Text(
              TodoTexts.delete,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              TodoTexts.cancel,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
