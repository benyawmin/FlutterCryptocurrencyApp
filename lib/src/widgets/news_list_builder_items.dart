import 'package:cryptocurrency/src/accessories/accessory.dart';
import 'package:cryptocurrency/src/screens/home_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';
import 'loading_latest_news.dart';
import '../resources/repository.dart';
import '../blocs/latest_news_provider.dart';

class NewsListBuilderItems extends StatefulWidget {
  final snapshot;
  final index;
  NewsListBuilderItems(this.snapshot, this.index);

  createState() {
    return new NewsListBuilderItemsState();
  }
}

class NewsListBuilderItemsState extends State<NewsListBuilderItems> {
  final _repository = Repository();
  List<bool> selected = List.filled(30, false);
  @override
  Widget build(BuildContext context) {
    final bloc = LatestNewsProvider.of(context);
    return Container(
      width: 300,
      child: GestureDetector(
        onTap: () {
          if (widget.snapshot.hasData) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeDetailsScreen(
                          widget.snapshot,
                          widget.index,
                        )));
          }
        },
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.blue,
                      size: 8,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      (widget.snapshot.data[widget.index]).title.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Text((widget.snapshot.data[widget.index]).description),
              ),
              SizedBox(
                child: Container(
                  height: 10,
                ),
              ),
              latestNewsImage(widget.snapshot, widget.index),
              Align(
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.only(top: 10, left: 20, bottom: 10),
                      child: Row(
                        children: [
                          Text('Share'),
                          GestureDetector(
                            child: Icon(
                              Icons.share_outlined,
                              color: hexToColor('#cecece'),
                            ),
                            onTap: () => Share.share(
                                (widget.snapshot.data[widget.index]).url),
                          ),
                        ],
                      )),
                  Spacer(),
                  Padding(
                      padding: EdgeInsets.only(top: 10, right: 20, bottom: 10),
                      child: Row(
                        children: [
                          Text('Save'),
                          GestureDetector(
                            child: Icon(
                              selected[widget.index]
                                  ? Icons.bookmark
                                  : Icons.bookmark_border_outlined,
                              color: hexToColor('#cecece'),
                            ),
                            onTap: () {
                              setState(() {
                                selected[widget.index] =
                                    !selected[widget.index];
                                // _repository.addToDb(
                                //     widget.snapshot.data[widget.index]);

                                // bloc.addToSavedNews(
                                //     widget.snapshot, widget.index);
                              });
                            },
                          )
                        ],
                      ))
                ]),
                alignment: Alignment.bottomLeft,
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.7),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
        ),
      ),
    );
  }

  latestNewsImage(snapshot, index) {
    if ((snapshot.data[index]).image != '') {
      return Container(
        child: ClipRRect(
          child: CachedNetworkImage(
            imageUrl: snapshot.data[index].image,
            placeholder: (context, url) => new LoadingLatestNews(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.all(20),
      );
    } else {
      return Text('No image available or still waiting for image!');
    }
  }
}
