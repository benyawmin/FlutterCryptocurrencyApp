import 'package:flutter/material.dart';
import '../blocs/latest_news_provider.dart';
import '../accessories/accessory.dart';

class SearchBar extends StatelessWidget {
  Widget build(BuildContext context) {
    final bloc = LatestNewsProvider.of(context);
    return Container(
        width: 254,
        child: TextField(
          onSubmitted: (text) => bloc.fetchSearchedNews(text),
          autocorrect: false,
          decoration: InputDecoration(
              hintStyle: TextStyle(color: hexToColor('#cecece')),
              contentPadding: EdgeInsets.all(10),
              isDense: true,
              filled: true,
              fillColor: hexToColor('#f5f5f5'),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: hexToColor('#cecece'))),
              hintText: 'Search...'
              ),
          style: const TextStyle(
            color: Colors.black,
          ),
        ));
  }
}
