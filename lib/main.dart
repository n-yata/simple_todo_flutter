import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/const/constants.dart';
import 'package:todo_app/page/todo_list_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: TodoTexts.title,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        textTheme: GoogleFonts.notoSansJpTextTheme(Theme.of(context).textTheme),
      ),
      home: const TodoListPage(),
    );
  }

  /// 白テーマ
  final MaterialColor materialWhite = const MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFFFFFF),
      200: Color(0xFFFFFFFF),
      300: Color(0xFFFFFFFF),
      400: Color(0xFFFFFFFF),
      500: Color(0xFFFFFFFF),
      600: Color(0xFFFFFFFF),
      700: Color(0xFFFFFFFF),
      800: Color(0xFFFFFFFF),
      900: Color(0xFFFFFFFF),
    },
  );
}
