import 'package:flutter/material.dart';
import 'package:todo_app/const/constants.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/page/todo_edit_page.dart';
import 'package:todo_app/shared/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TodoItems _items = TodoItems();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: _buildListView(),
          ),
          _buildForm(),
        ],
      ),
    );
  }

  /// Todoリストビュー
  ListView _buildListView() {
    return ListView.builder(
      itemCount: _items.count(),
      itemBuilder: (context, index) {
        var item = _items.findByIndex(index);
        return Dismissible(
          direction: DismissDirection.startToEnd,
          key: Key(UniqueKey().toString()),
          onDismissed: (DismissDirection direction) {
            _items.delete(item);
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: const Text(
              TodoTexts.delete,
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white),
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
                border: Border(
              bottom: BorderSide(color: Colors.grey),
            )),
            child: ListTile(
              title: Text(item.title),
              trailing: Checkbox(
                value: item.done,
                onChanged: (bool? value) {
                  setState(() => _items.update(item, value!));
                },
              ),
              onTap: () => _pushTodoDetailPage(item),
            ),
          ),
        );
      },
    );
  }

  /// 入力フォーム
  Container _buildForm() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: _controller,
        onSubmitted: (value) => _decisionInput(),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: TodoTexts.taskInput,
        ),
      ),
    );
  }

  void _decisionInput() {
    if (_controller.text.isEmpty) {
      return;
    }

    return setState(() {
      _items.add(false, _controller.text, null);
      _controller.clear();
    });
  }

  /// TODO編集ページに遷移する
  void _pushTodoDetailPage(Todo todo) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return TodoDetailPage(
            todo: todo,
            loadItems: _loadItems,
          );
        },
      ),
    );
  }

  /// TODOリストの更新を反映する
  void _loadItems() {
    Future(() async {
      setState(() => _items.loadItems());
    });
  }
}
