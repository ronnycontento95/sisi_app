// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ScreenChartApp extends StatefulWidget {
  const ScreenChartApp({super.key, this.valueDevice});
  final double? valueDevice;
  @override
  State<ScreenChartApp> createState() => _ScreenChartAppState();
}

class _ScreenChartAppState extends State<ScreenChartApp> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          height: 50,
        ),
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 10,
                sections: showingSections(widget.valueDevice),
              ),
            ),
          ),
        ),
        // const Column(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: <Widget>[
        //     Indicator(
        //       color: Colors.blue,
        //       text: 'First',
        //       isSquare: true,
        //     ),
        //     SizedBox(
        //       height: 4,
        //     ),
        //     Indicator(
        //       color: Colors.blue,
        //       text: 'Second',
        //       isSquare: true,
        //     ),
        //     SizedBox(
        //       height: 4,
        //     ),
        //     Indicator(
        //       color: Colors.purple,
        //       text: 'Third',
        //       isSquare: true,
        //     ),
        //     SizedBox(
        //       height: 4,
        //     ),
        //     Indicator(
        //       color: Colors.green,
        //       text: 'Fourth',
        //       isSquare: true,
        //     ),
        //     SizedBox(
        //       height: 18,
        //     ),
        //   ],
        // ),
      ],
    );
  }

  List<PieChartSectionData> showingSections(double? valueDevice) {
    return List.generate(1, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      var valueRest = valueDevice!-100.00;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: valueDevice??100.00,
            title: '$valueDevice',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: shadows,
            ),
          );
        // case 1:
        //   return PieChartSectionData(
        //     color: Colors.amber,
        //     value: 100,
        //     title: '30%',
        //     radius: radius,
        //     titleStyle: TextStyle(
        //       fontSize: fontSize,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.black,
        //       shadows: shadows,
        //     ),
        //   );
        // case 2:
        //   return PieChartSectionData(
        //     color: Colors.purple,
        //     value: 15,
        //     title: '15%',
        //     radius: radius,
        //     titleStyle: TextStyle(
        //       fontSize: fontSize,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.black,
        //       shadows: shadows,
        //     ),
        //   );
        // case 3:
        //   return PieChartSectionData(
        //     color: Colors.green,
        //     value: 15,
        //     title: '15%',
        //     radius: radius,
        //     titleStyle: TextStyle(
        //       fontSize: fontSize,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.black,
        //       shadows: shadows,
        //     ),
        //   );
        default:
          throw Error();
      }
    });
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });

  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}
