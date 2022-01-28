import 'package:custompaint/graph_painter.dart';
import 'package:flutter/material.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("graph"),
      ),
      body: CustomPaint(
        size: Size(double.infinity, double.infinity),
        painter: GraphPainter(),
      ),
    );
  }
}
