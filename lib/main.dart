import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/const/constants.dart';
import 'package:todo_app/page/todo_list_page.dart';
import 'package:todo_app/shared/todo_list_item.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: TodoTexts.title,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        textTheme: GoogleFonts.notoSansJpTextTheme(Theme.of(context).textTheme),
      ),
      home: const InitLoad(),
    );
  }
}

/// 初期ロード画面
/// TODOリストのロードが完了したらTODO一覧ページに遷移する
class InitLoad extends StatefulWidget {
  const InitLoad({super.key});

  @override
  State<InitLoad> createState() => _InitLoadState();
}

class _InitLoadState extends State<InitLoad> {
  final TodoItems _items = TodoItems();

  Future future() async {
    await _items.loadItems();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const CircularProgressIndicator(color: Colors.green);
          case ConnectionState.done:
            return const TodoListPage();
        }
      },
    );
  }
}
