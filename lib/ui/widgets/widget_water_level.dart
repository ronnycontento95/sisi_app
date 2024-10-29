import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularWaterLevelWidget extends StatelessWidget {
  final double level; // Nivel de agua entre 0 y 100

  CircularWaterLevelWidget({required this.level});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(150, 150), // Tamaño del círculo
      painter: WaterLevelPainter(level),
      child: Center(
        child: Text(
          '${level.toInt()}%', // Muestra el nivel en porcentaje en el centro
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}

class WaterLevelPainter extends CustomPainter {
  final double level;

  WaterLevelPainter(this.level);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint circlePaint = Paint()
      ..color = Colors.blue[100]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    final Paint fillPaint = Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.fill;

    // Dibuja el contorno del círculo
    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, circlePaint);

    // Calcula el ángulo de llenado en función del nivel
    final double sweepAngle = 2 * pi * (level / 100);

    // Dibuja el nivel de agua
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 8),
      -pi / 2, // Empieza desde la parte superior
      sweepAngle,
      true,
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
