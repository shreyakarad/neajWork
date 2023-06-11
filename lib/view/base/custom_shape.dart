import 'package:flutter/cupertino.dart';

class CustomShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();
    paint.color = const Color(0xffD9D9D9);
    path = Path();
    path.lineTo(size.width * 0.09, 0);
    path.cubicTo(size.width * 0.04, 0, 0, size.height * 0.04, 0, size.height * 0.08);
    path.cubicTo(0, size.height * 0.08, 0, size.height * 0.92, 0, size.height * 0.92);
    path.cubicTo(0, size.height * 0.96, size.width * 0.04, size.height, size.width * 0.09, size.height);
    path.cubicTo(size.width * 0.09, size.height, size.width / 4, size.height, size.width / 4, size.height);
    path.cubicTo(size.width * 0.3, size.height, size.width * 0.34, size.height * 0.96, size.width * 0.37, size.height * 0.93);
    path.cubicTo(size.width * 0.4, size.height * 0.89, size.width * 0.45, size.height * 0.87, size.width / 2, size.height * 0.87);
    path.cubicTo(size.width * 0.55, size.height * 0.87, size.width * 0.6, size.height * 0.89, size.width * 0.63, size.height * 0.93);
    path.cubicTo(size.width * 0.66, size.height * 0.96, size.width * 0.7, size.height, size.width * 0.75, size.height);
    path.cubicTo(size.width * 0.75, size.height, size.width * 0.91, size.height, size.width * 0.91, size.height);
    path.cubicTo(size.width * 0.96, size.height, size.width, size.height * 0.96, size.width, size.height * 0.92);
    path.cubicTo(size.width, size.height * 0.92, size.width, size.height * 0.08, size.width, size.height * 0.08);
    path.cubicTo(size.width, size.height * 0.04, size.width * 0.96, 0, size.width * 0.91, 0);
    path.cubicTo(size.width * 0.91, 0, size.width * 0.09, 0, size.width * 0.09, 0);
    path.cubicTo(size.width * 0.09, 0, size.width * 0.09, 0, size.width * 0.09, 0);
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class OnSaleShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF473DA4),
          Color(0xFF5A51C3),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(
        Rect.fromLTRB(0, 0, size.width, size.height),
      )
      ..strokeWidth = 15;


    Path path = Path();
    paint.color = Color(0xFF473DA4);
    path = Path();
    path.lineTo(0, size.height * 0.01);
    path.cubicTo(0, 0, size.width * 0.01, 0, size.width * 0.01, 0);
    path.cubicTo(size.width * 0.01, 0, size.width, 0, size.width, 0);
    path.cubicTo(size.width, 0, size.width, 0, size.width, size.height * 0.01);
    path.cubicTo(size.width, size.height * 0.08, size.width, size.height * 0.45, size.width * 0.73, size.height * 0.45);
    path.cubicTo(size.width / 4, size.height * 0.42, size.width * 0.06, size.height * 0.61, 0, size.height);
    path.cubicTo(0, size.height * 0.65, 0, size.height * 0.1, 0, size.height * 0.01);
    path.cubicTo(0, size.height * 0.01, 0, size.height * 0.01, 0, size.height * 0.01);
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}