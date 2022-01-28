import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class GraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final now = DateTime.now();
    Map<DateTime, double> data = {
      now.add(Duration(days: -6)): 2,
      now.add(Duration(days: -5)): 2,
      now.add(Duration(days: -4)): 2,
      now.add(Duration(days: -3)): 2,
      now.add(Duration(days: -2)): 2,
      now.add(Duration(days: -1)): 2,
      now: 3,
    };

    print("$data");
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        50,
        Paint()
          ..color = Colors.amber
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
