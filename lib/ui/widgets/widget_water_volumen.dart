import 'package:flutter/material.dart';
import 'dart:math';

class GaugePainter extends CustomPainter {
  final double value;
  final double minValue;
  final double maxValue;

  GaugePainter({required this.value, required this.minValue, required this.maxValue});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - 15;

    // Determinar el color del gauge según el valor
    Color gaugeColor;
    if (value <= minValue) {
      gaugeColor = Colors.red; // Bajo
    } else if (value >= maxValue) {
      gaugeColor = Colors.green; // Alto
    } else {
      gaugeColor = Colors.blue; // Normal
    }

    // Fondo del arco
    final paintBackground = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      pi,
      false,
      paintBackground,
    );

    // Arco del valor actual
    final paintValue = Paint()
      ..color = gaugeColor
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke;

    double sweepAngle = pi * ((value - minValue) / (maxValue - minValue));
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      sweepAngle,
      false,
      paintValue,
    );

    // Texto de valor actual
    final textPainter = TextPainter(
      text: TextSpan(
        text: value.toStringAsFixed(1),
        style: TextStyle(
          color: gaugeColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2),
    );

    // Texto de valor mínimo y máximo
    final minTextPainter = TextPainter(
      text: TextSpan(
        text: "Min: ${minValue.toStringAsFixed(1)}",
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 12,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    minTextPainter.layout();
    minTextPainter.paint(canvas, Offset(center.dx - radius, center.dy + 30));

    final maxTextPainter = TextPainter(
      text: TextSpan(
        text: "Max: ${maxValue.toStringAsFixed(1)}",
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 12,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    maxTextPainter.layout();
    maxTextPainter.paint(canvas, Offset(center.dx + radius - maxTextPainter.width, center.dy + 30));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
