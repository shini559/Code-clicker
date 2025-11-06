import 'package:flutter/material.dart';
import 'package:idle_clicker/screen/clicker_page.dart';

void main() {
  runApp(const CodeClicker());
}

class CodeClicker extends StatelessWidget {
  const CodeClicker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code Clicker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ClickerPage(),
    );
  }
}
