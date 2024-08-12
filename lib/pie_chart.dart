import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/widgets.dart';

class PieChart extends StatefulWidget {
  const PieChart({super.key});

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 450,
          width: 450,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: GestureDetector(
            onTapUp: (details){
              print(details.localPosition);
            },
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.green)),
              child: CustomPaint(
                size:  Size(300,300),
                painter: MyPainter(),
                // To visualize the clipped area
                ),
            ),
          )
          ),
        ),
      
    );
  }
}

class MyPainter extends CustomPainter {
  final List<double> data = [50, 20, 10, 20];
  final List<Color> colors = [Colors.purple, Colors.green, Colors.yellow, Colors.red];

  @override
  void paint(Canvas canvas, Size size) {
    var startAngle = degreesToRadians(-90);
    for (int i = 0; i < data.length; i++) {
      Paint paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke // Set painting style to stroke
        ..strokeWidth = 50.0;

      double sweepAngle = (data[i] / 100) * 2 * pi;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(size.height / 2, size.width / 2), radius: 150),
        startAngle,
        sweepAngle - degreesToRadians(4),
        false,
        paint,
      );

      // Calculate center point of the arc
      Offset center = calculateArcCenter(size, startAngle, sweepAngle, 150);
      Paint circlePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0;

      canvas.drawCircle(center, 5,circlePaint );

      // Draw line resembling hypotenuse from center point
    Offset offset =  drawHypotenuseLine(canvas, center, 50.0, startAngle + (sweepAngle / 2));
      TextSpan span = TextSpan(
    text: "200",
    style: TextStyle(color: Colors.black, ),
  );
  TextPainter tp = TextPainter(
    text: span,
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );
  tp.layout();
  if(radiansToDegrees(startAngle+ (sweepAngle/2))<90){
  
    Offset offsets =Offset(offset.dx+20, offset.dy);
tp.paint(canvas, offsets.translate((-tp.width  / 2) , (-tp.height / 2)));

  }
  else{
     Offset offsets =Offset(offset.dx-15, offset.dy);
    tp.paint(canvas, offsets.translate((-tp.width / 2) , (-tp.height / 2)));
  }
  

      startAngle += sweepAngle;
    }
  }

Offset drawHypotenuseLine(Canvas canvas, Offset center, double length, double angle) {
    Paint linePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0;



    // Calculate endpoint of the line
    double x = center.dx + length * cos(angle);
    double y = center.dy + length * sin(angle);
    Offset endPoint = Offset(x, y);
  

    canvas.drawLine(center, endPoint, linePaint);
    return  endPoint;

  }

  Offset calculateArcCenter(Size size, double startAngle, double sweepAngle, double radius) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;

    // Calculate midpoint angle of the arc
    double midpointAngle = startAngle + (sweepAngle / 2);

    // Calculate center point of the arc
    double x = centerX + radius * cos(midpointAngle);
    double y = centerY + radius * sin(midpointAngle);

    return Offset(x, y);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

double radiansToDegrees(double radians) {
  return radians * (180 / pi);
}

  double degreesToRadians(double degrees) {
    return degrees * pi / 180.0;
  }
}