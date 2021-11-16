import 'package:flutter/material.dart';
import 'latest_news_bloc.dart';
export 'latest_news_bloc.dart';

class LatestNewsProvider extends InheritedWidget {
  final LatestNewsBloc bloc;

  LatestNewsProvider({Key? key, required Widget child})
      : bloc = LatestNewsBloc(),
        super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static LatestNewsBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<LatestNewsProvider>()
            as LatestNewsProvider)
        .bloc;
  }
}
