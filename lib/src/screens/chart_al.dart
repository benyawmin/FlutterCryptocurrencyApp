import 'package:cryptocurrency/src/accessories/pallete.dart';
import 'package:cryptocurrency/src/blocs/latest_news_provider.dart';
import 'package:cryptocurrency/src/screens/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../resources/gecko_id_to_nobitex_id.dart';

class ChartAl extends StatefulWidget {
  String id;
  String chartType;
  // var user;
  ChartAl(this.id, this.chartType, 
  // this.user, 
  {Key? key}) : super(key: key);
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartAl> {
  @override
  Widget build(BuildContext context) {
    print(widget.id);
    final bloc = LatestNewsProvider.of(context);
    if (widget.id != 'null') {
      bloc.chartGecko(widget.id);
      bloc.candleGecko(widget.id);
    }
    // else {
    //   bloc.chartGecko('bitcoin');
    // }
    // chartData = getData();
    if (widget.id == 'null') {
      return CircularProgressIndicator(
        color: Pallete.dark_primary_color,
      );
    }
    if (widget.chartType == 'Area' || widget.chartType == 'Line') {
      return StreamBuilder(
        stream: bloc.chartGeckoStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            // print(widget.user);

            // widget.user = widget.user
            //     .where((i) => i['currency'] == converter(widget.id))
            //     .toList();
            // print(widget.user);
            // List userBuyAndSells = [];
            // for (var item in widget.user) {
            //   userBuyAndSells.add(item['created_at']);
            // }
            // print(userBuyAndSells);
            // List dateOfTrades = [];

            // for (var item in userBuyAndSells) {
            //   dateOfTrades.add(DateFormat.yMMMd().format(DateTime.parse(item)));
            // }
            // print(dateOfTrades);

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
              // for (var item in dateOfTrades) {
              //   if (DateFormat.yMMMd().format(DateTime.parse(
              //           readTimestamp((snapshot.data[i][0]).toInt())
              //               .toString())) ==
              //       item.toString()) {
              //     pricesOfTrades.add(snapshot.data[i][1]);
              //   }
              // }
            }
            print(pricesOfTrades);


            List<PlotBand> bands = [];

            for (var item in pricesOfTrades) {
              // if (double.parse(item) > 0) {
                bands.add(PlotBand(
                    isVisible: true,
                    borderWidth: 2,
                    start: item,
                    end: item,
                    borderColor: Colors.green));
              // } 
              // else {
                // PlotBand(
                //     isVisible: true,
                //     borderWidth: 2,
                //     start: double.parse(item),
                //     end: double.parse(item),
                //     borderColor: Colors.red);
              // }
            }

            if (widget.chartType == 'Line') {
              return SfCartesianChart(
                // primaryYAxis: NumericAxis(
                //   plotBands: widget.user != 'not' ? bands : null,
                // ),
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
            } else if (widget.chartType == 'Area') {
              return SfCartesianChart(
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
                        enable: true, color: Pallete.dark_primary_color)),
              );
            }
          }
          return Center(
              child: CircularProgressIndicator(
            color: Pallete.dark_primary_color,
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
          late List<CandleData> chartData = [];

          print(snapshot.data.length);
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
            return SfCartesianChart(
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
                  lowValueMapper: (CandleData tendencias, _) => tendencias.low,
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
                      enable: true, color: Pallete.dark_primary_color)),
            );
          } else if (widget.chartType == 'Candle') {
            return SfCartesianChart(
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
                  lowValueMapper: (CandleData tendencias, _) => tendencias.low,
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
                      enable: true, color: Pallete.dark_primary_color)),
            );
          }
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
