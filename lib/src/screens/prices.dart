import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptocurrency/src/blocs/latest_news_provider.dart';
import 'package:flutter/material.dart';

import 'crypto_detail.dart';

class Profile extends StatelessWidget {
  static const TextStyle proftxtnormal =
      TextStyle(color: Colors.white, fontSize: 14);
  static const TextStyle proftxtbold =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16);
  static const TextStyle proftxtunderlined = TextStyle(
      color: Colors.white, decoration: TextDecoration.underline, fontSize: 14);

  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = LatestNewsProvider.of(context);
    bloc.pingGecko();
    return Container(
      height: 500,
      child: StreamBuilder(
        stream: bloc.geckoStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: () async {
                await bloc.pingGecko();
              },
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, index) {
                  bool rise;
                  if (snapshot.data[index]['price_change_percentage_24h']
                          .toString()[0] ==
                      '-') {
                    rise = false;
                  } else {
                    rise = true;
                  }
                  return Container(
                      margin:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      width: 380,
                      height: 60,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CryptoDetail(
                                        snapshot.data[index], rise)));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 30,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          '${(snapshot.data[index])['image']}',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    (snapshot.data[index])['name'],
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  rise
                                      ? Container(
                                          margin:
                                              const EdgeInsets.only(right: 5),
                                          child: const Icon(
                                            Icons.trending_up_outlined,
                                            color: Colors.green,
                                          ),
                                        )
                                      : Container(
                                          margin:
                                              const EdgeInsets.only(right: 5),
                                          child: const Icon(
                                            Icons.trending_down_outlined,
                                            color: Colors.red,
                                          ),
                                        ),
                                  rise
                                      ? Container(
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          child: Text(
                                            snapshot.data[index][
                                                        'price_change_percentage_24h']
                                                    .toStringAsFixed(2) +
                                                '%',
                                            style: const TextStyle(
                                                color: Colors.green),
                                          ),
                                        )
                                      : Container(
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          child: Text(
                                            snapshot.data[index][
                                                        'price_change_percentage_24h']
                                                    .toStringAsFixed(2) +
                                                '%',
                                            style: const TextStyle(
                                                color: Colors.red),
                                          ),
                                        ),
                                  Text(
                                    ((snapshot.data[index])['current_price'])
                                            .toString() +
                                        " USD",
                                    style: TextStyle(color: Colors.purple[700]),
                                  ),
                                ],
                              )
                            ],
                          )));
                },
              ),
            );
          }
          return Center(
              child: CircularProgressIndicator(
            color: Colors.purple[700],
          ));
        },
      ),
    );
  }
}
