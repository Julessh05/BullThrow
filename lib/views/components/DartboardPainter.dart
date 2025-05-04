import 'dart:math' show pi;

import 'package:flutter/material.dart';

/// Painter for the Dartboard painted in the Game screens
final class DartboardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;
    final Paint paint = Paint();
    const int sectorCount = 20;
    const double anglePerSector = 2 * pi / sectorCount;
    final Rect rect = Rect.fromCircle(center: center, radius: radius);
    for (int sector = 0; sector < sectorCount; sector++) {
      // Start angle with rotation to position "20" tile in the upper middle
      final startAngle = anglePerSector * sector; // + (-pi / 2)
      Path path = Path();
      path.moveTo(center.dx, center.dy);
      path.arcTo(rect, startAngle, anglePerSector, false);
      path.close();
      // Fill
      paint.style = PaintingStyle.fill;
      paint.color = sector.isEven ? Colors.black : Colors.yellow.shade100;
      canvas.drawPath(path, paint);

      // Drawing triples
      paint.color = sector.isEven ? Colors.red : Colors.green;
      path = Path();
      path.arcTo(
        Rect.fromCircle(center: center, radius: radius * 0.582),
        startAngle,
        anglePerSector,
        false,
      );
      path.arcTo(
        Rect.fromCircle(center: center, radius: radius * 0.629),
        startAngle + anglePerSector,
        -anglePerSector,
        false,
      );
      path.close();
      canvas.drawPath(path, paint);

      // Drawing doubles
      path = Path();
      path.arcTo(
        Rect.fromCircle(center: center, radius: radius * 0.953),
        startAngle,
        anglePerSector,
        false,
      );
      path.arcTo(
        Rect.fromCircle(center: center, radius: radius * 1.000),
        startAngle + anglePerSector,
        -anglePerSector,
        false,
      );
      path.close();
      canvas.drawPath(path, paint);
    }

    // Draw circles
    paint.color = Colors.black;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;

    paint.style = PaintingStyle.fill;
    //Drawing double and single bullseye
    paint.color = Colors.green;
    canvas.drawCircle(center, radius * 0.094, paint);
    paint.color = Colors.red;
    canvas.drawCircle(center, radius * 0.037, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
