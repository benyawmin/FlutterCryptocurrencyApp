// import 'package:cryptocurrency/src/blocs/latest_news_bloc.dart';
import 'package:cryptocurrency/src/accessories/pallete.dart';
import 'package:cryptocurrency/src/blocs/latest_news_provider.dart';
import 'package:cryptocurrency/src/resources/currencies.dart';
import 'package:cryptocurrency/src/screens/chart_al_clone.dart';
import 'package:cryptocurrency/src/screens/login_screen.dart';
import 'package:cryptocurrency/src/screens/chart_al.dart';
import 'package:flutter/material.dart';
import '../resources/nobitex_id_to_gecko_id.dart';
import '../resources/cr.dart';

class Trade extends StatefulWidget {
  String srcCurrency = cr[0];
  String dstCurrency = cr[2];
  String orderType = 'buy';
  String chartType = 'Line';
  final String token;
  Trade(this.token, {Key? key}) : super(key: key);

  @override
  State<Trade> createState() => _TradeState();
}

class _TradeState extends State<Trade> {
  @override
  Widget build(BuildContext context) {
    final bloc = LatestNewsProvider.of(context);
    // bloc.buyAndSellNobitexx(widget.token);
    return Column(
      children: [
        // List<String> userCurrencies = [];
        // for (var item in snapshot.data) {
        //   userCurrencies.add(item['currency']);
        // }
        // userCurrencies = userCurrencies.toSet().toList();
        // print(userCurrencies);
        // return Column(
        //   children: [
        Row(
          children: [
            const Text('Type of order:'),
            const SizedBox(
              width: 10,
            ),
            DropdownButton<String>(
              value: widget.orderType,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 8,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurple,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  widget.orderType = newValue!;
                });
                widget.chartType = widget.orderType;
              },
              items:
                  ['buy', 'sell'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
        Row(
          children: [
            const Text('Source Currency: '),
            const SizedBox(
              width: 10,
            ),
            DropdownButton<String>(
              value: widget.srcCurrency,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 8,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurple,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  widget.srcCurrency = newValue!;
                });
                widget.chartType = widget.srcCurrency;
              },
              items: cr.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
        Row(
          children: [
            const Text('Destination Currency: '),
            const SizedBox(
              width: 10,
            ),
            DropdownButton<String>(
              value: widget.dstCurrency,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 8,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurple,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  widget.dstCurrency = newValue!;
                });
                widget.chartType = widget.dstCurrency;
              },
              items: cr.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
        Row(
          children: [
            const Text('Chart type: '),
            const SizedBox(
              width: 10,
            ),
            DropdownButton<String>(
              value: widget.chartType,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 8,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurple,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  widget.chartType = newValue!;
                });
                widget.chartType = widget.chartType;
              },
              items: <String>['Line', 'Area', 'Ohlc', 'Candle']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
        ChartAlClone('trx'),
        // ChartAl(converter(widget.dropDownValue2), widget.chartType)
      ],
      //           );
    );

    //   ],
    // );
  }
}
