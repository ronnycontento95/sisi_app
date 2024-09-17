import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class TankPage extends StatefulWidget {
  @override
  _TankPageState createState() => _TankPageState();
}

class _TankPageState extends State<TankPage> {
  double _tankValue = 0.5; // Valor inicial 50%

  // Esta función puede reducir el valor del tanque
  void _decreaseTankValue() {
    setState(() {
      if (_tankValue > 0) {
        _tankValue -= 0.1; // Reducimos el valor en 10%
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Tank Level: ${(_tankValue * 100).toInt()}%", // Mostrar el porcentaje
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 20),

        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _decreaseTankValue,
          child: Text("Reduce Tank Value"),
        ),
      ],
    );
  }
}

// CustomPainter para dibujar el tanque
class TankPainter extends CustomPainter {
  final double tankValue;

  TankPainter(this.tankValue);

  @override
  void paint(Canvas canvas, Size size) {
    Paint tankPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // Dibuja el contorno del tanque
    Rect tankRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(tankRect, tankPaint);

    // Cambia el color según el nivel del tanque
    Paint fillPaint = Paint()
      ..color = tankValue >= 0.5 ? Colors.blue : Colors.red
      ..style = PaintingStyle.fill;

    // Calcula el área llenada por el tanque
    double filledHeight = size.height * tankValue;
    Rect filledRect = Rect.fromLTWH(0, size.height - filledHeight, size.width, filledHeight);

    // Dibuja la parte llena del tanque
    canvas.drawRect(filledRect, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Redibuja cuando cambia el valor del tanque
  }
}
