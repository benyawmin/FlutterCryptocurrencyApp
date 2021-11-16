import 'package:cryptocurrency/src/widgets/category_list.dart';
import 'package:cryptocurrency/src/widgets/latest_news_list.dart';
import 'package:flutter/material.dart';
import '../blocs/latest_news_provider.dart';

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    final bloc = LatestNewsProvider.of(context);
    bloc.fetchLatestNews();
    return Column(
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(left: 10, top: 10),
              child: Text(
                'categories',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            )),
        CategoryList(),
        Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(left: 10, top: 30),
              child: Text(
                'Latest News',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            )),
        LatestNewsList(bloc, bloc.newsStream,'Home'),
      ],
    );
  }
}
