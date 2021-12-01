import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptocurrency/src/accessories/pallete.dart';
import 'package:flutter/material.dart';
import 'chart_al.dart';

class CryptoDetail extends StatefulWidget {
  final item;
  bool rise;
  String dropDownValue = 'Line';
  String chartType = 'Line';

  CryptoDetail(this.item, this.rise, {Key? key}) : super(key: key);

  @override
  State<CryptoDetail> createState() => _CryptoDetailState();
}

class _CryptoDetailState extends State<CryptoDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item['name']),
        backgroundColor: Pallete.dark_primary_color,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            height: 60,
            width: 60,
            child: CachedNetworkImage(
              imageUrl: '${(widget.item)['image']}',
            ),
          ),
          Text(
            '\$' + widget.item['current_price'].toString(),
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.rise
                    ? Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: const Icon(
                          Icons.trending_up_outlined,
                          color: Colors.green,
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: const Icon(
                          Icons.trending_down_outlined,
                          color: Colors.red,
                        ),
                      ),
                widget.rise
                    ? Container(
                        // margin: EdgeInsets.only(right: 10),
                        child: Text(
                          widget.item['price_change_percentage_24h']
                                  .toStringAsFixed(2) +
                              '%',
                          style: TextStyle(color: Colors.green, fontSize: 18),
                        ),
                      )
                    : Container(
                        // margin: EdgeInsets.only(right: 10),
                        child: Text(
                          widget.item['price_change_percentage_24h']
                                  .toStringAsFixed(2) +
                              '%',
                          style: const TextStyle(color: Colors.red, fontSize: 18),
                        ),
                      ),
              ],
            ),
          ),
          // DropdownButton<String>(
          //   items: <String>['A', 'B', 'C', 'D'].map((String value) {
          //     return DropdownMenuItem<String>(
          //       value: value,
          //       child: Text(value),
          //     );
          //   }).toList(),
          //   onChanged: (_) {},
          // ),
          DropdownButton<String>(
      value: widget.dropDownValue,
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
          widget.dropDownValue = newValue!;
        });
        widget.chartType = widget.dropDownValue;
      },
      items: <String>['Line', 'Area', 'Ohlc', 'Candle']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),
          const SizedBox(
            height: 20,
          ),
          ChartAl(widget.item['id'], widget.chartType),
          // Text('Technical Chart'),
        ],
      ),
    );
  }
}