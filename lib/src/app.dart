import 'package:cryptocurrency/src/screens/login_screen.dart';
import 'package:flutter/material.dart';
import '../src/blocs/latest_news_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LatestNewsProvider(
        child: MaterialApp(
      title: 'News',
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: LoginScreen(),
    ));
  }
}