import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../collect_stats_data.dart';

class _GraphData {
  _GraphData(
      this.date, this.happy, this.sad, this.anger, this.fear, this.surprise);
  final DateTime date;
  final double happy;
  final double sad;
  final double fear;
  final double anger;
  final double surprise;
}

class EmotionOverTimeDisplay extends StatefulWidget {
  //const EmotionOverTimeDisplay(Key key) : super(key: key);

  @override
  _EmotionOverTimeDisplay createState() => _EmotionOverTimeDisplay();
}

class _EmotionOverTimeDisplay extends State<EmotionOverTimeDisplay> {
  _EmotionOverTimeDisplay();

  //Method for generating the series data used in the Cartesian chart
  List<LineSeries<_GraphData, DateTime>> _getLineSeries(data) {
    //_GraphData(date, emotion1, emotion2, emotion3, emotion4)
    List<_GraphData> graphData = [];
    //<_GraphData>[
    //  _GraphData(DateTime(2020, 1, 1), 2, 3, 4, 5, 6),
    //  _GraphData(DateTime(2020, 1, 2), 3, 4, 5, 6, 7),
    //  _GraphData(DateTime(2020, 1, 3), 4, 5, 6, 7, 8)
    //];
    print("data");
    data.forEach((k, v) => {
          graphData.add(_GraphData(
              DateFormat('MM-dd-yyyy').parse(k), v[0], v[1], v[2], v[3], v[4]))
        });

    return <LineSeries<_GraphData, DateTime>>[
      LineSeries<_GraphData, DateTime>(
          animationDuration: 1500,
          dataSource: graphData,
          width: 3,
          name: 'Happiness',
          markerSettings: MarkerSettings(isVisible: true),
          xValueMapper: (_GraphData emotions, _) => emotions.date,
          yValueMapper: (_GraphData emotions, _) => emotions.happy),
      LineSeries<_GraphData, DateTime>(
          animationDuration: 1500,
          dataSource: graphData,
          width: 3,
          name: 'Sadness',
          markerSettings: MarkerSettings(isVisible: true),
          xValueMapper: (_GraphData emotions, _) => emotions.date,
          yValueMapper: (_GraphData emotions, _) => emotions.sad),
      LineSeries<_GraphData, DateTime>(
          animationDuration: 1500,
          dataSource: graphData,
          width: 3,
          name: 'Surprise',
          markerSettings: MarkerSettings(isVisible: true),
          xValueMapper: (_GraphData emotions, _) => emotions.date,
          yValueMapper: (_GraphData emotions, _) => emotions.surprise),
      LineSeries<_GraphData, DateTime>(
          animationDuration: 1500,
          dataSource: graphData,
          width: 3,
          name: 'Fear',
          markerSettings: MarkerSettings(isVisible: true),
          xValueMapper: (_GraphData emotions, _) => emotions.date,
          yValueMapper: (_GraphData emotions, _) => emotions.fear),
      LineSeries<_GraphData, DateTime>(
          animationDuration: 1500,
          dataSource: graphData,
          width: 3,
          name: 'Anger',
          markerSettings: MarkerSettings(isVisible: true),
          xValueMapper: (_GraphData emotions, _) => emotions.date,
          yValueMapper: (_GraphData emotions, _) => emotions.anger)
    ];
  }

  //Method for generating the chart area. Called _getLineSeries to generate
  // the data that is populated.
  SfCartesianChart _buildChart(data) {
    return SfCartesianChart(
      title: ChartTitle(text: "Emotion Ratings Over Time"),
      plotAreaBorderWidth: 1,
      series: _getLineSeries(data),
      legend:
          Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis: DateTimeAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          name: "Date",
          majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(color: Colors.transparent)),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  Future<Map<String, List>> _collectData() {
    return Stats().getAllEmotions();
  }

  Widget build(BuildContext context) {
    return Align(
        child: Container(
            child: Row(children: <Widget>[
      Flexible(
          child: FutureBuilder(
              future: _collectData(),
              builder: (context, snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  children = <Widget>[_buildChart(snapshot.data)];
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    Icon(Icons.error_outline, color: Colors.red, size: 50),
                    Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text('Error: ${snapshot.error}'))
                  ];
                } else {
                  children = <Widget>[
                    SizedBox(
                        child: CircularProgressIndicator(),
                        width: 70,
                        height: 70),
                    Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text('Loading...'))
                  ];
                }
                return Center(
                    child: Column(
                  children: children,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ));
              }))
    ])));
  }
}
