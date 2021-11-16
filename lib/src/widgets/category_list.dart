import 'package:flutter/material.dart';
import 'based_on_data.dart';
import 'loading_categories.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../resources/categories.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      height: 120,
      margin: EdgeInsets.only(top: 15),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (var i in getCategories())
            GestureDetector(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 180,
                    height: 200,
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: i.imageAssetUrl,
                        placeholder: (context, url) => new LoadingCategories(),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                    ),
                  ),
                  Text(
                    i.categorieName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BasedOnData(i.categorieName, 'Categories'))),
            )
        ],
        padding: EdgeInsets.all(8),
      ),
    );
  }
}
