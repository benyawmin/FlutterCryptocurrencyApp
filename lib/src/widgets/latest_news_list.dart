import 'package:flutter/material.dart';
import 'loading_latest_news.dart';
import 'news_list_builder.dart';

class LatestNewsList extends StatelessWidget {
  final bloc;
  final blocStream;
  final fromWidget;

  LatestNewsList(this.bloc, this.blocStream, this.fromWidget);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: blocStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return NewsListBuilder(snapshot);
          } else if (snapshot.hasError) {
            return Text('Nothing was found');
          }
          if (fromWidget == 'FavoriteNews')
          return Center(
            child: Text('No Favorites yet', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 26),),
          );
          return Center(
            child: LoadingLatestNews(),
          );
        });
  }
}
