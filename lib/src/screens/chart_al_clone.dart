import 'package:cryptocurrency/src/accessories/pallete.dart';
import 'package:cryptocurrency/src/blocs/latest_news_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartAlClone extends StatefulWidget {
  String id;

  ChartAlClone(this.id, 
  // this.chartType, 
  {Key? key}) : super(key: key);
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartAlClone> {
  @override
  Widget build(BuildContext context) {
    print(widget.id);
    final bloc = LatestNewsProvider.of(context);
    if (widget.id != 'null') {
      bloc.chartGecko(widget.id);
    }
    if (widget.id == 'null') {
      return CircularProgressIndicator(
        color: Pallete.dark_primary_color,
      );
    }
    return StreamBuilder(
      stream: bloc.chartGeckoStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List pricesOfTrades = [];
          var xa = [];
          var ya = [];
          late List<ChartData> chartData;

          print(snapshot.data);

          chartData = [];
          for (var i = 0; i < snapshot.data.length; i++) {
            xa.add(readTimestamp((snapshot.data[i][0]).toInt()));
            ya.add((snapshot.data[i][1]));
            chartData.add(ChartData(xa[i], ya[i]));
          }
          // print(pricesOfTrades);

          // List<PlotBand> bands = [];

          // for (var item in pricesOfTrades) {
          //   bands.add(PlotBand(
          //       isVisible: true,
          //       borderWidth: 2,
          //       start: item,
          //       end: item,
          //       borderColor: Colors.green));
          // }
          print(snapshot.data);
          return SfCartesianChart(
            primaryXAxis: DateTimeAxis(
                dateFormat: DateFormat.yMMMd(),
                intervalType: DateTimeIntervalType.days,
                visibleMinimum: chartData[chartData.length - 29].x,
                visibleMaximum: chartData[chartData.length - 1].x),
            zoomPanBehavior: ZoomPanBehavior(
              enablePanning: true,
              enablePinching: true,
            ),
            series: <CartesianSeries<ChartData, DateTime>>[
              LineSeries(
                dataSource: chartData,
                xValueMapper: (ChartData tendencias, _) => tendencias.x,
                yValueMapper: (ChartData tendencias, _) => tendencias.y,
              )
            ],
            trackballBehavior: TrackballBehavior(
                enable: true,
                lineType: TrackballLineType.horizontal,
                tooltipSettings: InteractiveTooltip(
                    enable: true, color: Pallete.dark_primary_color)),
          );
        }
        return Center(
            child: CircularProgressIndicator(
          color: Pallete.dark_primary_color,
        ));
      },
    );
  }
}

class ChartData {
  final DateTime x;
  final double y;
  ChartData(this.x, this.y);
}

readTimestamp(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  // print(DateTime.now());
  // print(date);
  return date;
}
