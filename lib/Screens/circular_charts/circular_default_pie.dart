import 'package:flutter/cupertino.dart';
import 'package:sven_hr/models/chart_sample_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CircularDefaultPie extends StatelessWidget {

  final List<ChartSampleData> pieData;
  final String title;


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
          dataLabelSettings: DataLabelSettings(isVisible: true)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return  SfCircularChart(
      // title: ChartTitle(text:title ,textStyle: TextStyle(fontSize: 14)),
      legend: Legend(isVisible:true,
        textStyle: TextStyle(fontSize: 8)
      ),
      series: _getDefaultPieSeries(),
    );
  }
}
