import 'package:flutter/material.dart';
import 'dart:math';

class CircularWaterVolumeWidget extends StatelessWidget {
  final double currentVolume; // Volumen actual de agua
  final double maxVolume; // Volumen máximo del tanque

  CircularWaterVolumeWidget({required this.currentVolume, required this.maxVolume});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(150, 150), // Tamaño del círculo
      painter: WaterVolumePainter(currentVolume, maxVolume),
      child: Center(
        child: Text(
          '${currentVolume.toInt()} ', // Muestra el volumen actual en el centro
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}

class WaterVolumePainter extends CustomPainter {
  final double currentVolume;
  final double maxVolume;

  WaterVolumePainter(this.currentVolume, this.maxVolume);

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

    // Calcula el ángulo de llenado en función del volumen
    final double sweepAngle = 2 * pi * (currentVolume / maxVolume);

    // Dibuja el volumen de agua
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
