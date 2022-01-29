import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

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

    print("${data.keys.toList()}");

    int dataLength = data.length - 1;
    int padding = 50;

    double graphWidth = size.width - padding * 2;

    for (int i = 0; i <= dataLength; i++) {
      Offset startPoint = Offset(graphWidth / dataLength * i + padding, 50);
      Offset endPoint =
          Offset(graphWidth / dataLength * i + padding, size.height - 50);

      Paint drawRowLine() {
        Paint paint = Paint()
          ..strokeWidth = 1
          ..color = Colors.white;
        canvas.drawLine(startPoint, endPoint, paint);

        return paint;
      }

      drawRowLine();

      Offset labelEndPoint = Offset(
          graphWidth / dataLength * i + padding - 10, size.height - 50 + 10);

      TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: DateFormat('M/d').format(data.keys.toList()[i]),
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      )
        ..layout()
        ..paint(canvas, labelEndPoint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
