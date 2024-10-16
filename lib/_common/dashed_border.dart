import 'package:flutter/material.dart';

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  DashedBorderPainter({required this.color, this.strokeWidth = 2.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const dashWidth = 4.0;
    const dashSpace = 8.0;
    double totalLength = 2 * 3.14 * (size.width / 2);
    double startX = 0;

    while (startX < totalLength) {
      canvas.drawArc(
        Rect.fromLTWH(0, 0, size.width, size.height),
        startX / (size.width / 2),
        dashWidth / (size.width / 2),
        false,
        paint,
      );
      startX += dashWidth + dashSpace; 
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
