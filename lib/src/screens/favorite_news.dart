import 'package:cryptocurrency/src/widgets/latest_news_list.dart';
import 'package:flutter/material.dart';
import '../blocs/latest_news_provider.dart';

class FavoriteNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = LatestNewsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Column(
        children: [LatestNewsList(bloc, bloc.savedNewsStream, 'FavoriteNews')],
      ),
    );
  }
}
