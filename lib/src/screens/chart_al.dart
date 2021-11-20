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
  @override
  Widget build(BuildContext context) {
    final bloc = LatestNewsProvider.of(context);
    if (widget.id != 'null') {
      bloc.chartGecko(widget.id);
      bloc.candleGecko(widget.id);
    } else {
      bloc.chartGecko('bitcoin');
    }
    // chartData = getData();
    if (widget.chartType == 'Area' || widget.chartType == 'Line') {
      return StreamBuilder(
        stream: bloc.chartGeckoStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var xa = [];
            var ya = [];
            chartData = [];
            for (var i = 0; i < snapshot.data['prices'].length; i++) {
              xa.add(readTimestamp((snapshot.data['prices'][i][0]).toInt()));
              ya.add((snapshot.data['prices'][i][1]));
              chartData.add(ChartData(xa[i], ya[i]));
            }
            if (widget.chartType == 'Line') {
              return Container(
                child: SfCartesianChart(
                  // primaryYAxis: NumericAxis(plotBands: []),
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
                          enable: true, color: Colors.purple[700])),
                ),
              );
            } else if (widget.chartType == 'Area') {
              return Container(
                child: SfCartesianChart(
                  // primaryYAxis: NumericAxis(plotBands: []),
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
    return StreamBuilder(
      stream: bloc.candleGeckoStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          var xs = [];
          var opens = [];
          var highs = [];
          var lows = [];
          var closes = [];
          List<CandleData> chartData = [];
          for (var i = 0; i < snapshot.data.length; i++) {
            xs.add(readTimestamp((snapshot.data[i][0]).toInt()));
            opens.add((snapshot.data[i][1]));
            highs.add((snapshot.data[i][2]));
            lows.add((snapshot.data[i][3]));
            closes.add((snapshot.data[i][4]));
            chartData
                .add(CandleData(xs[i], opens[i], highs[i], lows[i], closes[i]));
          }
          if (widget.chartType == 'Ohlc') {
            return Container(
              child: SfCartesianChart(
                // primaryYAxis: NumericAxis(plotBands: []),
                primaryXAxis: DateTimeAxis(
                    dateFormat: DateFormat.yMMMd(),
                    intervalType: DateTimeIntervalType.days,
                    visibleMinimum: chartData[chartData.length - 29].x,
                    visibleMaximum: chartData[chartData.length - 1].x),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                  enablePinching: true,
                ),
                series: [
                  HiloOpenCloseSeries(
                    dataSource: chartData,
                    xValueMapper: (CandleData tendencias, _) => tendencias.x,
                    lowValueMapper: (CandleData tendencias, _) =>
                        tendencias.low,
                    highValueMapper: (CandleData tendencias, _) =>
                        tendencias.high,
                    openValueMapper: (CandleData tendencias, _) =>
                        tendencias.open,
                    closeValueMapper: (CandleData tendencias, _) =>
                        tendencias.close,
                  )
                ],
                trackballBehavior: TrackballBehavior(
                    enable: true,
                    lineType: TrackballLineType.horizontal,
                    tooltipSettings: InteractiveTooltip(
                        enable: true, color: Colors.purple[700])),
              ),
            );
          } else if (widget.chartType == 'Candle') {
            return Container(
              child: SfCartesianChart(
                // primaryYAxis: NumericAxis(plotBands: []),
                primaryXAxis: DateTimeAxis(
                    dateFormat: DateFormat.yMMMd(),
                    intervalType: DateTimeIntervalType.days,
                    visibleMinimum: chartData[chartData.length - 29].x,
                    visibleMaximum: chartData[chartData.length - 1].x),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                  enablePinching: true,
                ),
                series: [
                  CandleSeries(
                    enableSolidCandles: true,
                    dataSource: chartData,
                    xValueMapper: (CandleData tendencias, _) => tendencias.x,
                    lowValueMapper: (CandleData tendencias, _) =>
                        tendencias.low,
                    highValueMapper: (CandleData tendencias, _) =>
                        tendencias.high,
                    openValueMapper: (CandleData tendencias, _) =>
                        tendencias.open,
                    closeValueMapper: (CandleData tendencias, _) =>
                        tendencias.close,
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
  final DateTime x;
  final double y;
  ChartData(this.x, this.y);
}

class CandleData {
  final DateTime x;
  final double open;
  final double high;
  final double low;
  final double close;
  CandleData(this.x, this.open, this.high, this.low, this.close);
}

readTimestamp(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  // print(DateTime.now());
  // print(date);
  return date;
}
