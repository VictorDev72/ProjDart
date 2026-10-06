import 'package:flutter/material.dart';
import 'package:flutter_application_3/home_screen.dart';
import 'minhatela.dart';
import 'package:flutter_application_3/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Exemplos de Widgets",
      home: const HomeScreen()


    );
  }
}




