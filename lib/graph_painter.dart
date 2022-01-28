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

    int dataLength = data.length - 1;
    int padding = 50;

    double graphWidth = size.width - padding * 2;

    for (int i = 0; i <= dataLength; i++) {
      Offset startPoint = Offset(graphWidth / dataLength * i + padding, 50);
      Offset endPoint =
          Offset(graphWidth / dataLength * i + padding, size.height - 50);

      Paint paint = Paint()
        ..strokeWidth = 1
        ..color = Colors.white;
      canvas.drawLine(startPoint, endPoint, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
