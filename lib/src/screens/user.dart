// import 'package:cryptocurrency/src/blocs/latest_news_bloc.dart';
import 'package:cryptocurrency/src/accessories/pallete.dart';
import 'package:cryptocurrency/src/blocs/latest_news_provider.dart';
import 'package:cryptocurrency/src/screens/login_screen.dart';
import 'package:cryptocurrency/src/screens/chart_al.dart';
import 'package:flutter/material.dart';
import '../resources/nobitex_id_to_gecko_id.dart';

class User extends StatefulWidget {
  String dropDownValue1 = 'Line';
  String dropDownValue2 = 'eth';
  String chartType = 'Line';
  final String token;
  User(this.token, {Key? key}) : super(key: key);

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    final bloc = LatestNewsProvider.of(context);
    bloc.buyAndSellNobitexx(widget.token);
    return Column(
      children: [
        StreamBuilder(
          stream: bloc.buyAndSellNobitexStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<String> userCurrencies = [];
              for (var item in snapshot.data) {
                userCurrencies.add(item['currency']);
              }
              userCurrencies = userCurrencies.toSet().toList();
              print(userCurrencies);
              return Column(
                children: [
                          DropdownButton<String>(
          value: widget.dropDownValue1,
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
              widget.dropDownValue1 = newValue!;
            });
            widget.chartType = widget.dropDownValue1;
          },
          items: <String>['Line', 'Area', 'Ohlc', 'Candle']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
                  DropdownButton<String>(
                    value: widget.dropDownValue2,
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
                        widget.dropDownValue2 = newValue!;
                      });
                      widget.chartType = widget.dropDownValue2;
                    },
                    items: userCurrencies
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  ChartAl(converter(widget.dropDownValue2), widget.chartType)
                ],
              );
            }
            return CircularProgressIndicator(
              color: Pallete.dark_primary_color,
            );
          },
        ),
      ],
    );
  }
}
