import 'package:custompaint/graph_screen1.dart';
import 'package:flutter/material.dart';
import 'package:custompaint/graph_screen1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GraphScreen(),
    );
  }
}
