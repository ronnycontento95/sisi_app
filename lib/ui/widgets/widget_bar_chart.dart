import 'package:flutter/material.dart';

class BatteryWidget extends StatelessWidget {
  final double level; // Nivel de batería entre 0.0 y 1.0

  BatteryWidget({required this.level});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: const Size(50, 100), // Tamaño del widget
        painter: BatteryPainter(level),
      ),
    );
  }
}

class BatteryPainter extends CustomPainter {
  final double level;

  BatteryPainter(this.level);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Dibuja el contorno de la batería en vertical
    final batteryRect = Rect.fromLTWH(0, 0, size.width, size.height * 0.9);
    canvas.drawRect(batteryRect, paint);

    // Dibuja el "terminal" de la batería en la parte superior
    final terminalRect = Rect.fromLTWH(size.width * 0.25, -size.height * 0.1, size.width * 0.5, size.height * 0.1);
    canvas.drawRect(terminalRect, paint);

    // Dibuja el nivel de carga de la batería en vertical
    final levelPaint = Paint()..color = level > 20.0 ? Colors.green : Colors.red;
    final chargeHeight = (size.height * 0.9) * (level/100);
    final chargeRect = Rect.fromLTWH(0, size.height * 0.9 - chargeHeight, size.width, chargeHeight);
    canvas.drawRect(chargeRect, levelPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
