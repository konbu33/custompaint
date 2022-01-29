import 'dart:io';

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

    Paint drawColumnLine() {
      late Paint paint;

      for (int i = 0; i <= dataLength; i++) {
        Offset startPoint = Offset(graphWidth / dataLength * i + padding, 50);
        Offset endPoint =
            Offset(graphWidth / dataLength * i + padding, size.height - 50);

        paint = Paint()
          ..strokeWidth = 1
          ..color = Colors.white;
        canvas.drawLine(startPoint, endPoint, paint);
      }
      return paint;
    }

    TextPainter drawColumnLabel() {
      late TextPainter textPainter;

      for (int i = 0; i <= dataLength; i++) {
        Offset labelEndPoint = Offset(
            graphWidth / dataLength * i + padding - 10, size.height - 50 + 10);

        textPainter = TextPainter(
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
      return textPainter;
    }

    Paint drawRowLine() {
      int horizontalLine = 5;
      int padding = 50;
      double graphHeight = size.height - padding * 2 - 30;
      late Paint paint;
      for (int i = 0; i <= horizontalLine; i++) {
        print("i : ${i}");
        Offset startPoint = Offset(
            50 - 10, size.height - padding - graphHeight / horizontalLine * i);
        Offset endPoint = Offset(size.width - 50 + 10,
            size.height - padding - graphHeight / horizontalLine * i);

        paint = Paint()
          ..strokeWidth = 1
          ..color = Colors.white;

        canvas.drawLine(startPoint, endPoint, paint);
      }
      return paint;
    }

    drawColumnLine();
    drawColumnLabel();
    drawRowLine();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
