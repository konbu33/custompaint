import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'dart:math';

class GraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final now = DateTime.now();
    Map<DateTime, double> data = {
      now.add(Duration(days: -6)): 22,
      now.add(Duration(days: -5)): 12,
      now.add(Duration(days: -4)): 12,
      now.add(Duration(days: -3)): 34,
      now.add(Duration(days: -2)): 67,
      now.add(Duration(days: -1)): 54,
      now: 64,
    };

    print("${data.keys.toList()}");

    int dataLength = data.length - 1;
    int padding = 50;
    double graphWidth = size.width - padding * 2;

    num topScaleNumber = 0;

    num calcTopScaleNumber() {
      double maxValue = data.values.toList().reduce(max);
      int maxValueLenght = maxValue.toInt().toString().length;
      // print("maxValueLenght : ${pow(10, maxValueLenght - 2)}");
      num underNum = pow(10, maxValueLenght);

      num kami2keta = (maxValue / 100).floor() * 100;
      num shimo2keta = maxValue % 100;
      // print("underNum: ${underNum}");
      // print("kami 2keta : ${kami2keta}");
      // print("simo 2keta : ${shimo2keta}");

      String firstValueStr = shimo2keta.toString()[0];
      // print("10 ^ maxValueLenght : ${maxValueLenght}");
      num firstValueNum = (int.parse(firstValueStr) + 1) * 10;
      num returnNum = kami2keta + firstValueNum;
      // print("firstValueStr : ${firstValueStr}");
      // print("firstValueDou : ${firstValueNum}");
      // print("returnNum: ${returnNum}");

      return returnNum;
    }

    topScaleNumber = calcTopScaleNumber();

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
        // print("i : ${i}");
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

    TextPainter drawRowLabel() {
      late TextPainter textPainter;
      int graphLine = 5;
      int padding = 50;

      double graphHeight = size.height - padding * 2 - 30;
      for (int i = 0; i <= graphLine; i++) {
        textPainter = TextPainter(
          text: TextSpan(
            text: "${(topScaleNumber / graphLine * i).round()}",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          textDirection: TextDirection.rtl,
        )
          ..layout()
          ..paint(
              canvas,
              Offset(padding - 35,
                  size.height - padding - graphHeight / graphLine * i - 15));
      }
      return textPainter;
    }

    void drawDotto() {
      int dataLenght = data.length - 1;
      int padding = 50;
      double dottoSize = 5;
      double graphWidth = size.width - padding * 2;
      List<double> dataValues = data.values.toList();
      double graphHeight = size.height - padding * 2 - 30;

      for (int i = 0; i <= dataLength; i++) {
        Offset startPoint = Offset(
            graphWidth / dataLenght * i + padding,
            size.height -
                padding -
                (graphHeight * (dataValues[i] / topScaleNumber)));
        // size.height -
        //     padding -
        //     graphHeight / topScaleNumber * dataValues[i]);
        // print("${i} graphHeight : ${graphHeight}");
        // print("${i} : ${(dataValues[i] / topScaleNumber)}");
        // print("${i} : ${(dataValues[i] / topScaleNumber) * graphHeight}");
        canvas.drawCircle(startPoint, dottoSize, Paint()..color = Colors.white);
      }
    }

    void drawPath() {
      int dataLenght = data.length - 1;
      double padding = 50;
      double graphHeight = size.height - padding * 2 - 30;
      Path fillPath = Path();
      fillPath.moveTo(padding, size.height - padding);

      for (int i = 0; i <= dataLenght; i++) {
        fillPath.lineTo(
            graphWidth / dataLenght * i + padding,
            size.height -
                padding -
                (graphHeight * (data.values.toList()[i] / topScaleNumber)));
      }

      fillPath.lineTo(size.width - padding, size.height - padding);

      fillPath.close();
      canvas.drawPath(fillPath, Paint()..color = Colors.white.withOpacity(0.3));
    }

    drawColumnLine();
    drawColumnLabel();
    drawRowLine();
    drawRowLabel();
    drawDotto();
    drawPath();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
