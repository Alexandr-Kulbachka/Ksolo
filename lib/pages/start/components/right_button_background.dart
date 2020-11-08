import 'package:Ksolo/enums/app_elements.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../style/app_color_scheme.dart';

class RightButtonBackground extends CustomPainter {
  var _path = Path();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = RadialGradient(colors: [
        AppElements.appbar.color(),
        AppElements.simpleCard.color(),
      ]).createShader(Rect.fromCircle(
        center: Offset(size.width * 0.75, size.height * 0.75),
        radius: size.height,
      ));
    _path.moveTo(size.width, size.height);
    _path.lineTo(size.width * 0.25, size.height);
    _path.lineTo(size.width * 0.75, 0);
    _path.lineTo(size.width, 0);
    _path.close();
    canvas.drawPath(_path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  @override
  bool hitTest(Offset position) {
    bool hit = _path.contains(position);
    return hit;
  }
}
