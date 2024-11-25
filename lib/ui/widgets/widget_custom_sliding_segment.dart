import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/main.dart';
import 'package:sisi_iot_app/ui/common/color.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/screen/graficas/chart_status.dart';

class Example6 extends StatefulWidget {
  const Example6({super.key});

  @override
  State<Example6> createState() => _Example6State();
}

class _Example6State extends State<Example6> {
  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();
    return CustomSlidingSegmentedControl<int>(
      initialValue: pvPrincipal.selectPosition,
      children: const {
        1: Text(
          'Tarjetas',
          textAlign: TextAlign.center,
        ),
        2: Text(
          'Estado',
          textAlign: TextAlign.center,
        ),
        3: Text(
          'Gráficas',
          textAlign: TextAlign.center,
        ),
      },
      thumbDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: CommonColor.colorPrimary
      ),
      onValueChanged: (int value) {
        pvPrincipal.updatePosition(value);
      },
    );
  }
}