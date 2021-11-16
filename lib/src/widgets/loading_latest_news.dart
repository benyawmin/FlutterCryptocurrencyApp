import 'package:flutter/material.dart';

class LoadingLatestNews extends StatefulWidget {
  createState() {
    return new LoadingLatestNewsState();
  }
}

class LoadingLatestNewsState extends State<LoadingLatestNews>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 400));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: _animationController,
        child: Column(
          children: [
            SizedBox(width: 20),
            buildContainer(),
          ],
        ));
  }

  buildContainer() {
    return Container(
      width: 300,
      height: 300,
      color: Colors.grey[350],
      margin: EdgeInsets.only(top: 10, bottom: 10),
    );
  }

  @override
  dispose() {
    _animationController.dispose(); 
    super.dispose();
  }
}
