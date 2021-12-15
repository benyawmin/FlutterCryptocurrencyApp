import 'package:cryptocurrency/src/accessories/pallete.dart';
import 'package:cryptocurrency/src/blocs/latest_news_provider.dart';
import 'package:cryptocurrency/src/resources/currencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../resources/nobitex_id_to_gecko_id.dart';
import 'chart_al_clone.dart';

class Trading extends StatefulWidget {
  late String srcCurrency;
  late String dstCurrency;
  String orderType = 'buy';
  String chartType = 'Line';
  final String token;
  Trading(this.token, {Key? key}) : super(key: key);

  @override
  State<Trading> createState() => _TradingState();
}

class _TradingState extends State<Trading> {
  TextEditingController amountController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = LatestNewsProvider.of(context);
    bloc.walletsNobitex(widget.token);
    return ListView(
      children: [
        Card(
          margin: const EdgeInsets.all(10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          shadowColor: Pallete.dark_primary_color,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              children: [
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
                      },
                      items: <String>['buy', 'sell']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                StreamBuilder(
                    stream: bloc.walletsNobitexStream,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        // print(snapshot.data);
                        if (widget.orderType == 'buy') {
                          widget.srcCurrency = 'rls';
                          widget.dstCurrency = currencies[0];
                        } else {
                          widget.srcCurrency = snapshot.data[0];
                          widget.dstCurrency = 'rls';
                        }
                        return Column(
                          children: [
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
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurple,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      widget.srcCurrency = newValue!;
                                    });
                                  },
                                  items: widget.orderType == 'sell'
                                      ? snapshot.data
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList()
                                      : <String>['rls']
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
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
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurple,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      widget.dstCurrency = newValue!;
                                    });
                                  },
                                  items: widget.orderType == 'sell'
                                      ? ['rls'].map<DropdownMenuItem<String>>(
                                          (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList()
                                      : currencies
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                ),
                              ],
                            ),
                            StreamBuilder(
                              stream: bloc.orderNobitexStream,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    children: [
                                      snapshot.data != 'null'
                                          ? snapshot.data['status'] == 'failed'
                                              ? Text(
                                                  snapshot.data['message']
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.red),
                                                )
                                              : Container()
                                          : const Text(
                                              'Null was returned',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                      Center(
                                        child: Text(
                                          widget.orderType == 'buy'
                                              ? widget.dstCurrency
                                                      .toUpperCase() +
                                                  " Chart"
                                              : widget.srcCurrency
                                                      .toUpperCase() +
                                                  " Chart",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Pallete.secondary_text_color),
                                        ),
                                      ),
                                      ChartAlClone(
                                          widget.orderType == 'buy'
                                              ? converter(widget.dstCurrency)
                                              : converter(widget.srcCurrency),
                                          amountController.text.toString(),
                                          priceController.text.toString())
                                    ],
                                  );
                                }
                                return Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        widget.orderType == 'buy'
                                            ? widget.dstCurrency.toUpperCase() +
                                                " Chart"
                                            : widget.srcCurrency.toUpperCase() +
                                                " Chart",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Pallete.secondary_text_color),
                                      ),
                                    ),
                                    ChartAlClone(
                                        widget.orderType == 'buy'
                                            ? converter(widget.dstCurrency)
                                            : converter(widget.srcCurrency),
                                        amountController.text.toString(),
                                        priceController.text.toString())
                                  ],
                                );
                              },
                            ),
                          ],
                        );
                      }
                      return CircularProgressIndicator(
                        color: Pallete.dark_primary_color,
                      );
                    }),
                textFieldBuilder(amountController, 'Amount'),
                textFieldBuilder(priceController, 'Price'),
                Container(
                  width: 200,
                  height: 60,
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 2, primary: Pallete.dark_primary_color),
                    onPressed: () {
                      bloc.orderNobitex(
                          widget.token,
                          widget.orderType,
                          widget.srcCurrency,
                          widget.dstCurrency,
                          amountController.text,
                          priceController.text);
                    },
                    child: const Text('Order'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget textFieldBuilder(TextEditingController controller, String hint) {
    return Center(
      child: Container(
        height: 50,
        width: 200,
        padding: const EdgeInsets.all(10),
        child: TextField(
          keyboardType: TextInputType.number,
          controller: controller,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: hint,
              labelStyle: const TextStyle(fontSize: 12)),
        ),
      ),
    );
  }
}
