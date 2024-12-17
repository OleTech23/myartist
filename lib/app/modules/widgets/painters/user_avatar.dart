import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NoUserPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey.shade300 // Background color of the circle
      ..style = PaintingStyle.fill;

    final Paint outlinePaint = Paint()
      ..color = Colors.grey.shade700 // Color of the outline for the person icon
      ..style = PaintingStyle.fill
      ..strokeWidth = 3.0;

    final Paint bodyPaint = Paint()
      ..color = Colors.grey.shade700 // Color of the outline for the person icon
      ..style = PaintingStyle.fill
      ..strokeWidth = 3.0;

    // Draw the circle
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;
    canvas.drawCircle(center, radius, paint);

    // Clip any overflowing content
    canvas.clipPath(
        Path()..addOval(Rect.fromCircle(center: center, radius: radius)));

    // Draw the person's head
    final double headRadius = radius * 0.25;
    final Offset headCenter = Offset(center.dx, center.dy - radius * 0.3);
    canvas.drawCircle(headCenter, headRadius, outlinePaint);

    // Draw the person's body
    canvas.drawCircle(
      Offset(center.dx, center.dy + radius * 0.9),
      radius * 0.9,
      bodyPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
