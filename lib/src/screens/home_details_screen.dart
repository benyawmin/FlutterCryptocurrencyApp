import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptocurrency/src/accessories/pallete.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeDetailsScreen extends StatefulWidget {
  final snapshot;
  final index;

  HomeDetailsScreen(this.snapshot, this.index);

  @override
  createState() {
    return HomeDetailsScreenState();
  }
}

class HomeDetailsScreenState extends State<HomeDetailsScreen> {
  bool isLoading = true;
  late String title,url;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Pallete.dark_primary_color,
        title: const Text('Details'),
      ),
      body: WebView(
          key: UniqueKey(),
          initialUrl: widget.snapshot.data[widget.index].url,
          javascriptMode: JavascriptMode.unrestricted),
    );
    // SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       latestNewsImage(widget.snapshot, widget.index),
    //       Align(
    //         child: Row(children: [
    //           Padding(
    //               padding: EdgeInsets.only(top: 10, left: 20, bottom: 10),
    //               child: Row(
    //                 children: [
    //                   Text('Share'),
    //                   GestureDetector(
    //                     child: Icon(Icons.share),
    //                     onTap: () => Share.share(
    //                         (widget.snapshot.data[widget.index]).url),
    //                   ),
    //                   catReturn(widget.snapshot, widget.index),
    //                 ],
    //               )),
    //           Spacer(),
    //           Padding(
    //               padding: EdgeInsets.only(top: 10, right: 20, bottom: 10),
    //               child: Row(
    //                 children: [
    //                   Text('Save'),
    //                   Icon(Icons.bookmark_border_outlined),
    //                 ],
    //               )),
    //         ]),
    //         alignment: Alignment.bottomLeft,
    //       ),
    //       Row(
    //         children: [
    //           SizedBox(
    //             width: 10,
    //           ),
    //           Icon(
    //             Icons.circle,
    //             color: Colors.blue,
    //             size: 8,
    //           ),
    //           SizedBox(
    //             width: 10,
    //           ),
    //           Expanded(
    //               child: Container(
    //             padding: EdgeInsets.all(10),
    //             child: Text(
    //               widget.snapshot.data[widget.index].title.toString(),
    //               style: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 20,
    //                 color: Colors.black,
    //               ),
    //             ),
    //           )),
    //         ],
    //       ),
    //       Container(
    //         margin: EdgeInsets.all(10),
    //         child: Text((widget.snapshot.data[widget.index]).description),
    //       ),
    //     ],
    //   ),
    // )

    // );
  }

  latestNewsImage(snapshot, index) {
    if ((snapshot.data[index]).image != '') {
      return SizedBox(
        width: double.infinity,
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          height: 150,
          imageUrl: snapshot.data[index].image,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(color: Pallete.dark_primary_color,),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        // margin: EdgeInsets.only(bottom: 10),
      );
    } else {
      return const Text('No image available or still waiting for image!');
    }
  }

  catReturn(snapshot, index) {
    var categories = "";
    for (var i in (snapshot.data[index]).category) {
      categories += i + ", ";
    }
    if (categories.isNotEmpty) {
      categories = categories.substring(0, categories.length - 2);
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        categories,
        style: const TextStyle(
            color: Colors.orange, decoration: TextDecoration.underline),
      ),
    );
  }
}