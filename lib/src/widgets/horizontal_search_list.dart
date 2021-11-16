import 'package:cryptocurrency/src/screens/home_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'loading_categories.dart';

class HorizontalSearchList extends StatelessWidget {
  final bloc;
  final blocStream;
  HorizontalSearchList(this.bloc, this.blocStream);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: blocStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeDetailsScreen(
                                  snapshot,
                                  index,
                                )));
                  },
                  child: Container(
                    width: 220,
                    height: 200,
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Stack(
                        alignment: Alignment.center,
                        fit: StackFit.expand,
                        children: [
                          CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: snapshot.data[index].image,
                            placeholder: (context, url) =>
                                new LoadingCategories(),
                            errorWidget: (context, url, error) =>
                                new Icon(Icons.image),
                          ),
                          Container(
                              padding: EdgeInsets.all(5),
                              margin:
                                  EdgeInsets.only(top: 70, right: 10, left: 10),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      snapshot.data[index].title,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      snapshot.data[index].description,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return LoadingCategories();
      },
    );
  }
}
