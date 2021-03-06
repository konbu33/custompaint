import 'package:flutter/material.dart';
import 'graph_painter.dart';

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
        title: Text("Graph"),
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: CustomPaint(
          size: Size(double.infinity, double.infinity),
          painter: GraphPainter(),
        ),
      ),
    );
  }
}
