import 'package:cryptocurrency/src/blocs/latest_news_provider.dart';
import 'package:cryptocurrency/src/widgets/latest_news_list.dart';
import 'package:flutter/material.dart';

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = LatestNewsProvider.of(context);
    bloc.fetchSearchedNews('cryptocurrency');
    return LatestNewsList(bloc, bloc.searchedListBuilderStream, 'Home');
  }
}
