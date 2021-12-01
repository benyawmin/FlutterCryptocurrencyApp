import 'package:cryptocurrency/src/accessories/pallete.dart';
import 'package:cryptocurrency/src/blocs/latest_news_provider.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History(this.token, {Key? key}) : super(key: key);
  final String token;

  @override
  Widget build(BuildContext context) {
    final bloc = LatestNewsProvider.of(context);
    bloc.buyAndSellNobitexx(token);

    return StreamBuilder(
      stream: bloc.buyAndSellNobitexStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          // print(snapshot.data);
          var user = snapshot.data;
          // user = user
          //     .where((i) => i['currency'] != 'rls')
          //     .toList();
          // List userBuyAndSells = [];
          // for (var item in user) {
          //   userBuyAndSells.add(item);
          // }
          // print(userBuyAndSells);

          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 50,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Text('Currency: '),
                            Text(
                              user[index]['currency'].toString().toUpperCase(),
                              style: TextStyle(
                                  color: Pallete.dark_primary_color),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Amount: '),
                            Text(
                              user[index]['amount'].toString(),
                              style: TextStyle(
                                  color:
                                      user[index]['amount'].toString()[0] == '-'
                                          ? Colors.red
                                          : Colors.green),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Balance: '),
                            Text(
                              user[index]['balance'].toString(),
                              style: TextStyle(color: Pallete.accent_color),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
        }
        return CircularProgressIndicator(
          color: Pallete.dark_primary_color,
        );
      },
    );
  }
}
