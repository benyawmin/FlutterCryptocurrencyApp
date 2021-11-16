import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptocurrency/src/accessories/accessory.dart';
import 'package:cryptocurrency/src/screens/home_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share_plus/share_plus.dart';

import 'loading_categories.dart';

class HorizontalLatestList extends StatelessWidget {
  final bloc;
  final blocStream;

  HorizontalLatestList(
    this.bloc,
    this.blocStream,
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: blocStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: 200,
                child: GestureDetector(
                  onTap: () {
                    if (snapshot.hasData) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeDetailsScreen(
                                    snapshot,
                                    index,
                                  )));
                    }
                  },
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      children: [
                        latestNewsImage(snapshot, index),
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Text(
                              (snapshot.data[index]).title.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          child: Container(
                            // margin: EdgeInsets.only(top: 35),
                            padding: EdgeInsets.all(10),
                            child: Row(children: [
                              GestureDetector(
                                child: Icon(Icons.share_outlined,
                                    color: hexToColor('#cecece')),
                                onTap: () =>
                                    Share.share((snapshot.data[index]).url),
                              ),
                              Icon(
                                Icons.bookmark_border_outlined,
                                color: hexToColor('#cecece'),
                              )
                            ]),
                          ),
                          alignment: Alignment.center,
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
            },
          );
        }
        return ListView(
          scrollDirection: Axis.horizontal,
          children: [
            LoadingCategories(),
            SizedBox(
              width: 10,
            ),
            LoadingCategories(),
            SizedBox(
              width: 10,
            ),
            LoadingCategories(),
          ],
        );
      },
    );
  }

  latestNewsImage(snapshot, index) {
    if ((snapshot.data[index]).image != '') {
      return Container(
        width: double.infinity,
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          height: 95,
          imageUrl: snapshot.data[index].image,
          placeholder: (context, url) => new Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => new Icon(Icons.error),
        ),
      );
    } else {
      return Text('No image available or still waiting for image!');
    }
  }
}
