import 'package:cryptocurrency/src/widgets/latest_news_list.dart';
import 'package:cryptocurrency/src/widgets/news_list_builder.dart';
import 'package:cryptocurrency/src/widgets/searchbar.dart';
import 'package:flutter/material.dart';
import '../blocs/latest_news_provider.dart';
import '../widgets/horizontal_search_list.dart';

class Search extends StatelessWidget {
  final tab = new TabBar(tabs: <Tab>[
    new Tab(icon: new Icon(Icons.arrow_forward)),
    new Tab(icon: new Icon(Icons.arrow_downward)),
    new Tab(icon: new Icon(Icons.arrow_back)),
  ]);

  @override
  Widget build(BuildContext context) {
    final bloc = LatestNewsProvider.of(context);

    return DefaultTabController(
      length: 6,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(
              // right: 10,
              left: 10,
              top: 20,
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://thispersondoesnotexist.com/image'),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                SearchBar(),
              ],
            ),
          ),
          Container(
            child: const TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.black,
                labelColor: Colors.blue,
                tabs: [
                  Tab(text: "Latest",),
                  Tab(text: "programming"),
                  Tab(text: "general"),
                  Tab(text: "sports"),
                  Tab(text: "academia"),
                  Tab(text: "politics"),
                ]),
          ),
          Container(
            //Add this to give height
            height: MediaQuery.of(context).size.height,
            child: TabBarView(children: [
              Column(
                children: [
                  StreamBuilder(
                    stream: bloc.searchedListBuilderStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return NewsListBuilder(snapshot);
                      } else if (snapshot.hasError) {
                        return const Text('No results found');
                      }
                      bloc.fetchLatestNews();
                      return Expanded(
                          child: Column(
                        children: [
                          HorizontalSearchList(bloc, bloc.newsStream),
                          LatestNewsList(bloc, bloc.newsStream, 'Search'),
                        ],
                      ));
                    },
                  )
                ],
              ),
              Column(
                children: [
                  StreamBuilder(
                    stream: bloc.searchedListBuilderStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return NewsListBuilder(snapshot);
                      } else if (snapshot.hasError) {
                        return const Text('No results found');
                      }
                      bloc.c1Fetch('programming');
                      return Expanded(
                          child: Column(
                        children: [
                          HorizontalSearchList(bloc, bloc.c1Stream),
                          LatestNewsList(bloc, bloc.c1Stream, 'Search'),
                        ],
                      ));
                    },
                  )
                ],
              ),
              Column(
                children: [
                  StreamBuilder(
                    stream: bloc.searchedListBuilderStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return NewsListBuilder(snapshot);
                      } else if (snapshot.hasError) {
                        return const Text('No results found');
                      }
                      bloc.c2Fetch('general');
                      return Expanded(
                          child: Column(
                        children: [
                          HorizontalSearchList(bloc, bloc.c2Stream),
                          LatestNewsList(bloc, bloc.c2Stream, 'Search'),
                        ],
                      ));
                    },
                  )
                ],
              ),
              Column(
                children: [
                  StreamBuilder(
                    stream: bloc.searchedListBuilderStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return NewsListBuilder(snapshot);
                      } else if (snapshot.hasError) {
                        return const Text('No results found');
                      }
                      bloc.c3Fetch('sports');
                      return Expanded(
                          child: Column(
                        children: [
                          HorizontalSearchList(bloc, bloc.c3Stream),
                          LatestNewsList(bloc, bloc.c3Stream, 'Search'),
                        ],
                      ));
                    },
                  )
                ],
              ),
              Column(
                children: [
                  StreamBuilder(
                    stream: bloc.searchedListBuilderStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return NewsListBuilder(snapshot);
                      } else if (snapshot.hasError) {
                        return const Text('No results found');
                      }
                      bloc.c4Fetch('academia');
                      return Expanded(
                          child: Column(
                        children: [
                          HorizontalSearchList(bloc, bloc.c4Stream),
                          LatestNewsList(bloc, bloc.c4Stream, 'Search'),
                        ],
                      ));
                    },
                  )
                ],
              ),
              Column(
                children: [
                  StreamBuilder(
                    stream: bloc.searchedListBuilderStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return NewsListBuilder(snapshot);
                      } else if (snapshot.hasError) {
                        return const Text('No results found');
                      }
                      bloc.c5Fetch('politics');
                      return Expanded(
                          child: Column(
                        children: [
                          HorizontalSearchList(bloc, bloc.c5Stream),
                          LatestNewsList(bloc, bloc.c5Stream, 'Search'),
                        ],
                      ));
                    },
                  )
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
