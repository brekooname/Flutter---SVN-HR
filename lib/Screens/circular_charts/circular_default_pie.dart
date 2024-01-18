import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sven_hr/main.dart';
import 'package:sven_hr/models/chart_sample_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../app_settings/server_connection_screen.dart';

class CircularDefaultPie extends StatelessWidget {
  final List<ChartSampleData>? pieData;
  final String? title;

  CircularDefaultPie({this.pieData, this.title});

  List<PieSeries<ChartSampleData, String>> _getDefaultPieSeries() {
    return <PieSeries<ChartSampleData, String>>[
      PieSeries<ChartSampleData, String>(
        explode: true,
        explodeIndex: 0,
        explodeOffset: '10%',
        dataSource: pieData,
        xValueMapper: (ChartSampleData data, _) => data.x,
        yValueMapper: (ChartSampleData data, _) => data.y,
        dataLabelMapper: (ChartSampleData data, _) => data.y.toString(),
        startAngle: 90,
        endAngle: 90,
        animationDuration: 1500,
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          labelPosition: ChartDataLabelPosition.outside,

          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 12, // Increased font size
            backgroundColor: Colors.black.withOpacity(0.5),shadows: <Shadow>[
            Shadow(
              offset: Offset(1.5, 1.5),
              blurRadius: 3,
              color: Colors.black.withOpacity(0.5),
            ),
          ],
          ),
        ),
       ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: MyApp.isEN ? TextDirection.ltr : TextDirection.ltr,
      child: SfCircularChart(
        title: ChartTitle(text: title!,
            textStyle: TextStyle(  color: Colors.white,fontSize: 16, fontWeight: FontWeight.bold)
),
        legend: Legend(
          isVisible: true,
          textStyle: TextStyle(  color: Colors.white,fontSize: 12, fontWeight: FontWeight.bold),
          alignment: ChartAlignment.center,
          orientation: LegendItemOrientation.horizontal,
          overflowMode: LegendItemOverflowMode.wrap,
          position: LegendPosition.bottom,
        ),
        series: _getDefaultPieSeries(),
      ),
    );
  }
}
