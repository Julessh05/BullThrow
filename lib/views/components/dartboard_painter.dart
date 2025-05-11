import 'dart:math' show cos, sin, pi;

import 'package:flutter/material.dart';

/// Painter for the Dartboard painted in the Game screens
final class DartboardPainter extends CustomPainter {
  ThemeMode themeMode;

  DartboardPainter(this.themeMode);

  /// The numbers of the Dartboard in order
  static const dartboardNumbers = [
    20,
    1,
    18,
    4,
    13,
    6,
    10,
    15,
    2,
    17,
    3,
    19,
    7,
    16,
    8,
    11,
    14,
    9,
    12,
    5,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;
    final double labelRadius = radius * 1.08;

    final Paint paint = Paint();
    final TextPainter textPainter = TextPainter();

    const int sectorCount = 20;
    const double anglePerSector = 2 * pi / sectorCount;
    final Rect outerRect = Rect.fromCircle(center: center, radius: radius);

    for (int sector = 0; sector < sectorCount; sector++) {
      // Start angle with rotation to position "20" tile in the upper middle
      final startAngle = anglePerSector * sector + (-pi / 2 - pi / 20);
      // Paint options
      paint.style = PaintingStyle.fill;
      paint.color = sector.isEven ? Colors.black : Colors.amber.shade50;
      Path path = Path();

      // Draw sectors
      path.moveTo(center.dx, center.dy);
      path.arcTo(outerRect, startAngle, anglePerSector, false);
      path.close();
      canvas.drawPath(path, paint);

      // Drawing triples
      paint.color = sector.isEven ? Colors.red : Colors.green;
      path = Path();
      path.arcTo(
        Rect.fromCircle(center: center, radius: radius * .582),
        startAngle,
        anglePerSector,
        false,
      );
      path.arcTo(
        Rect.fromCircle(center: center, radius: radius * .629),
        startAngle + anglePerSector,
        -anglePerSector,
        false,
      );
      path.close();
      canvas.drawPath(path, paint);

      // Drawing doubles
      path = Path();
      path.arcTo(
        Rect.fromCircle(center: center, radius: radius * .953),
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

      // Drawing Score numbers
      // TODO: update position to draw score numbers respectively correct
      final labelAngle = startAngle + anglePerSector / 2;
      final double label_dx = center.dx + labelRadius * cos(labelAngle);
      final double label_dy = center.dy + labelRadius * sin(labelAngle);
      final Offset offset = Offset(label_dx, label_dy);
      final TextSpan textSpan = TextSpan(
        text: dartboardNumbers[sector].toString(),
        style: TextStyle(
          color: themeMode == ThemeMode.dark ? Colors.white : Colors.black,
        ),
      );
      textPainter.text = textSpan;
      textPainter.textAlign = TextAlign.center;
      textPainter.textDirection = TextDirection.ltr;
      textPainter.layout();
      textPainter.paint(canvas, offset);
    }

    // Draw circles
    paint.color = Colors.black;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;

    paint.style = PaintingStyle.fill;
    //Drawing inner and outer bull
    paint.color = Colors.green;
    canvas.drawCircle(center, radius * .094, paint);
    paint.color = Colors.red;
    canvas.drawCircle(center, radius * .037, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: repaint when ThemeMode changed
    return false;
  }
}
