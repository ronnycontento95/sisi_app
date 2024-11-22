import 'package:flutter/material.dart';
import 'package:sisi_iot_app/ui/common/color.dart';

class WidgetEmpty extends StatelessWidget {
  const WidgetEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline, // Ícono representativo
            color: CommonColor.colorPrimary,
            size: 50,
          ),
          SizedBox(height: 16), // Espaciado entre el ícono y el texto
          Text(
            'No hay datos disponibles',
            style: TextStyle(
              color: CommonColor.colorPrimary,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
