import 'package:flutter/material.dart';
import 'package:hangman/presentation/pages/game_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hangman Game',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: GameView(),
    );
  }
}
