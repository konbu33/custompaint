import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'dart:math';

class GraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Map<DateTime, int> initData = {
    //   DateTime.now().add(Duration(days: -1)): 23,
    //   DateTime.now().add(Duration(days: -2)): 38,
    //   DateTime.now().add(Duration(days: -4)): 11,
    //   DateTime.now().add(Duration(days: -3)): 56,
    //   DateTime.now().add(Duration(days: -5)): 73,
    //   DateTime.now().add(Duration(days: -6)): 89,
    //   DateTime.now().add(Duration(days: -7)): 48,
    // };
    Map<DateTime, int> initData = {};
    for (int i = 0; i < 10; i++) {
      initData[DateTime.now().add(Duration(days: -1 * Random().nextInt(10)))] =
          Random().nextInt(100);
    }
    // for (int i = 0; i < 7; i++) {
    //   data[DateTime.now().add(Duration(days: i * -1))] = i * 10 + 106;
    // }
    print("init data : ${initData}");

    Map<DateTime, int> data = {};
    data = SplayTreeMap.from(initData, (a, b) => b.compareTo(a));
    print("sort data: ${data}");

    int graphScaleNum = 0;
    int calcGraphScaleNum() {
      print("dataValueMax: ${data.values.toList().reduce(max)})}");
      int dataValueMax = data.values.toList().reduce(max);
      int kami2keta = dataValueMax ~/ 100 * 100;
      int shimo2keta = (dataValueMax % 100 * 0.1).ceil() * 10;
      dataValueMax = kami2keta + shimo2keta;
      print(
          "kami2keta : ${kami2keta}, shimo2keta: ${shimo2keta}, dataValueMax: ${dataValueMax})}");
      return dataValueMax;
    }

    graphScaleNum = calcGraphScaleNum();

    print("h : ${size.height} , w : ${size.width}");
    double padding = 50;
    double graphWidth = size.width - (padding * 2);
    double graphHeight = size.height - (padding * 2) - 30;
    print("gh : ${graphHeight} , gw : ${graphWidth}");

    int dataLength = data.length - 1;
    double graphVirticalLineInterval = graphWidth / dataLength;
    int graphHorizontalLineNum = 5;
    double graphHorizontalLineInterval = graphHeight / graphHorizontalLineNum;
    print("gataLength : ${dataLength}");
    Path path = Path();
    path.moveTo(padding, size.height - padding);

    void drawVirticalLine() {
      for (int i = 0; i <= dataLength; i++) {
        Offset start = Offset(padding + graphVirticalLineInterval * i, padding);
        Offset end = Offset(
            padding + graphWidth / dataLength * i, size.height - padding);

        canvas.drawLine(
            start,
            end,
            Paint()
              ..color = Colors.white
              ..strokeWidth = 1);

        TextPainter(
          text: TextSpan(
            text: DateFormat('M/d').format(data.keys.toList()[i]),
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          textDirection: TextDirection.ltr,
        )
          ..layout()
          ..paint(
            canvas,
            Offset(padding + graphWidth / dataLength * i - 10,
                size.height - padding),
          );

        double yValue = size.height -
            padding -
            graphHeight * (data.values.toList()[i] / graphScaleNum);
        Offset dotto = Offset(padding + graphVirticalLineInterval * i, yValue);

        canvas.drawCircle(dotto, 3, Paint()..color = Colors.white);

        path.lineTo(
            padding + graphVirticalLineInterval * i,
            size.height -
                padding -
                graphHeight * (data.values.toList()[i] / graphScaleNum));
      }
      path.lineTo(size.width - padding, size.height - padding);
      path.close();
      canvas.drawPath(path, Paint()..color = Colors.white.withOpacity(0.5));
    }

    void drawHorizontalLine() {
      for (int i = 0; i <= graphHorizontalLineNum; i++) {
        Offset start = Offset(padding - 10,
            size.height - padding - graphHorizontalLineInterval * i);
        Offset end = Offset(size.width - padding + 10,
            size.height - padding - graphHorizontalLineInterval * i);
        canvas.drawLine(
          start,
          end,
          Paint()
            ..color = Colors.white
            ..strokeWidth = 1,
        );

        TextPainter(
          text: TextSpan(
            text: "${(graphScaleNum / graphHorizontalLineNum * i).round()}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          textDirection: TextDirection.ltr,
        )
          ..layout()
          ..paint(
            canvas,
            Offset(padding - 30,
                size.height - padding - 20 - graphHorizontalLineInterval * i),
          );
      }
    }

    drawVirticalLine();
    drawHorizontalLine();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
