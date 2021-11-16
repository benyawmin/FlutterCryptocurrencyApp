import 'package:flutter/material.dart';

class LoadingCategories extends StatefulWidget {
  createState() {
    return new LoadingCategoriesState();
  }
}

class LoadingCategoriesState extends State<LoadingCategories>
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
      child: buildContainer(),
      // Row(
      //   children: [
      //     SizedBox(width: 10),
      //     buildContainer(),
      //     SizedBox(width: 10),
      //     buildContainer(),
      //     SizedBox(
      //       width: 10,
      //     ),
      //     buildContainer(),
      //     SizedBox(
      //       width: 10,
      //     ),
      //     buildContainer()
      //   ],
      // )
    );
  }

  buildContainer() {
    return SizedBox(
      child: Container(
        width: 200,
        height: 120,
        color: Colors.grey[350],
        margin: EdgeInsets.only(top: 10, bottom: 10),
      ),
    );
  }

  @override
  dispose() {
    _animationController.dispose(); // you need this
    super.dispose();
  }
}
