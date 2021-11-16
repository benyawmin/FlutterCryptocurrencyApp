import 'package:cryptocurrency/src/blocs/latest_news_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartAl extends StatefulWidget {
  String id = 'null';
  String chartType;
  ChartAl(this.id, this.chartType);
  @override
  _ChartPageState createState() => _ChartPageState();
}

late List<ChartData> chartData;

class _ChartPageState extends State<ChartAl> {
  // late SelectionBehavior _selectionBehavior;

  // @override
  // void initState() {
  //   _selectionBehavior = SelectionBehavior(
  //       // Enables the selection
  //       enable: true);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final bloc = LatestNewsProvider.of(context);
    if (widget.id != 'null')
      bloc.chartGecko(widget.id);
    else
      bloc.chartGecko('bitcoin');
    // chartData = getData();
    return StreamBuilder(
      stream: bloc.chartGeckoStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          var xa = [];
          var ya = [];
          chartData = [];
          for (var i = 0; i < snapshot.data['prices'].length; i++) {
            xa.add(readTimestamp((snapshot.data['prices'][i][0]).toInt()));
            ya.add((snapshot.data['prices'][i][1]).toInt());
            chartData.add(ChartData(xa[i], ya[i].toInt()));
          }
          // for (var i = 0; i < snapshot.data['prices'].length; i++) {}
          // for (var i = 0; i < snapshot.data['prices'].length; i++) {}
          // print(snapshot.data['prices'].length);
          // print((snapshot.data['prices'][0][0]));
          // print(readTimestamp(snapshot.data['prices'][0][0]));
          if (widget.chartType == 'Line') {
            return Container(
              child: SfCartesianChart(
                // legend: Legend(
                //   isVisible: true,
                // ),
                primaryYAxis: NumericAxis(plotBands: [
                  // if (widget.id == 'bitcoin')
                  //   PlotBand(
                  //       start:
                  //           30000, // y-point for with the horizontal line needs to be drawn.
                  //       end: 30000,
                  //       borderColor: Colors.blue,
                  //       borderWidth:
                  //           2, // set the border width for the horizontal line.
                  //       associatedAxisStart: DateTime(
                  //           2002) // set the required value for assicoated x-axis start  property
                  //       )
                ]),
                primaryXAxis: DateTimeAxis(
                    dateFormat: DateFormat.yMMMd(),
                    intervalType: DateTimeIntervalType.days,
                    visibleMinimum: chartData[chartData.length - 29].x,
                    visibleMaximum: chartData[chartData.length - 1].x),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                  enablePinching: true,
                  // maximumZoomLevel: 0.5,
                ),
                series: <CartesianSeries<ChartData, DateTime>>[
                  LineSeries(
                    // initialSelectedDataIndexes: <int>[2],
                    // selectionBehavior: SelectionBehavior(
                    //   enable: true,
                    // ),
                    // markerSettings: MarkerSettings(
                    //   isVisible: true,
                    //   shape: DataMarkerType.horizontalLine
                    // ),
                    // dataLabelSettings: DataLabelSettings(
                    //     // Renders the data label
                    //     isVisible: true),
                    dataSource: chartData,
                    xValueMapper: (ChartData tendencias, _) => tendencias.x,
                    yValueMapper: (ChartData tendencias, _) => tendencias.y,
                  )
                ],
                // annotations: <CartesianChartAnnotation>[
                //   CartesianChartAnnotation(
                //     widget: Container(
                //       height: 1.0,
                //       width: double.infinity,
                //       color: Colors.black,
                //     ),
                //     coordinateUnit: CoordinateUnit.point,
                //     x: DateTime(2018, 1, 0),
                //     y: 50,
                //     horizontalAlignment: ChartAlignment.near,
                //   )
                // ],
                trackballBehavior: TrackballBehavior(
                    enable: true,
                    lineType: TrackballLineType.horizontal,
                    tooltipSettings: InteractiveTooltip(
                        enable: true, color: Colors.purple[700])),
              ),
            );
          } else if (widget.chartType == 'Area') {
            return Container(
              child: SfCartesianChart(
                primaryYAxis: NumericAxis(plotBands: [
                ]),
                primaryXAxis: DateTimeAxis(
                    dateFormat: DateFormat.yMMMd(),
                    intervalType: DateTimeIntervalType.days,
                    visibleMinimum: chartData[chartData.length - 29].x,
                    visibleMaximum: chartData[chartData.length - 1].x),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                  enablePinching: true,
                  // maximumZoomLevel: 0.5,
                ),
                series: <CartesianSeries<ChartData, DateTime>>[
                  AreaSeries(
                    dataSource: chartData,
                    xValueMapper: (ChartData tendencias, _) => tendencias.x,
                    yValueMapper: (ChartData tendencias, _) => tendencias.y,
                  )
                ],
                trackballBehavior: TrackballBehavior(
                    enable: true,
                    lineType: TrackballLineType.horizontal,
                    tooltipSettings: InteractiveTooltip(
                        enable: true, color: Colors.purple[700])),
              ),
            );
          }
        }
        return Center(
            child: CircularProgressIndicator(
          color: Colors.purple[700],
        ));
      },
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final DateTime x;
  final int y;
}

// class CandleData {
//   CandleData(this.x,);
//   final DateTime x;
// }

readTimestamp(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  // print(DateTime.now());
  // print(date);
  return date;
}
