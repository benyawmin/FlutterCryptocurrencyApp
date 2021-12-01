import 'package:cryptocurrency/src/accessories/pallete.dart';
import 'package:cryptocurrency/src/blocs/latest_news_provider.dart';
import 'package:flutter/material.dart';
import 'latest_news_list.dart';

class BasedOnData extends StatelessWidget {
  final String data;
  final String dataType;
  BasedOnData(this.data, this.dataType);
  @override
  Widget build(BuildContext context) {
    final bloc = LatestNewsProvider.of(context);
    final blocStream;
    if (dataType == 'Categories') {
      bloc.fetchByCat(data);
      blocStream = bloc.filteredByCatStream;
    } else {
      bloc.fetchByRegion(data);
      blocStream = bloc.filteredByRegionStream;
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Pallete.dark_primary_color,
          title: Text(data.toString()),
        ),
        body: Column(
          children: [LatestNewsList(bloc, blocStream, 'BasedOnData')],
        ));
  }
}
