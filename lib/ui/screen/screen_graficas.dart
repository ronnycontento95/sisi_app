import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sisi_iot_app/ui/common/common_label.dart';
import 'package:sisi_iot_app/ui/screen/graficas/chart_line_std.dart';

import 'graficas/chart_line_bom.dart';
import 'graficas/chart_line_fse.dart';
import 'graficas/chart_line_psi.dart';
import 'graficas/chart_line_vol.dart';
import 'graficas/chart_line_vol1.dart';
import 'graficas/chart_line_vol2.dart';
import 'graficas/chart_line_wp.dart';
import 'graficas/chart_line_wp1.dart';
import 'graficas/chart_line_wp2.dart';
import 'graficas/foco_grafica/chart_foco_grafica_estado.dart';
import 'graficas/foco_grafica/chart_foco_grafica_std.dart';

class ScreenGraficas extends StatelessWidget {
  const ScreenGraficas({super.key});

  static const routePage = CommonLabel.routerScreenGraficas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Graficas",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 1.5),
        ),
        elevation: 2, // Añade profundidad
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black), // Color de iconos de AppBar
      ),
      body: const SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              ChartFocoGrafica(),
              SizedBox(
                height: 10,
              ),
              ChartGraficaStatus(),
              CustomChartLineWp1(),
              CustomChartLineWp2(),
              SizedBox(
                height: 10,
              ),
              CustomChartLine(),
              CustomChartVol1(),
              CustomChartVol2(),
              SizedBox(
                height: 10,
              ),
              CustomChartVol(),
              SizedBox(
                height: 10,
              ),
              CustomChartPsi(),
              SizedBox(
                height: 10,
              ),
              CustomChartStd(),
              SizedBox(
                height: 10,
              ),
              CustomChartFse(),
              SizedBox(
                height: 10,
              ),
              CustomChartBom(),
            ],
          ),
        ),
      ),
    );
  }
}
