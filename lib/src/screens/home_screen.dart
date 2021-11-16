import 'package:flutter/material.dart';
import 'Search.dart';
import 'categories.dart';
import 'chart_al.dart';
import 'prices.dart';

class HomeScreen extends StatefulWidget {
  createState() {
    return new HomeScreenState();
  }
}

@override
class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    ChartAl('null', 'Line'),
    Profile(),
    News(),
    SingleChildScrollView(
      child: Search(),
    ),
    ChartAl('null', 'Line'),
    // Home(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Crypto'),
          backgroundColor: Colors.purple[700],
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          width: 20,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            )),
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.map_outlined),
                  label: 'Charts',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.monetization_on_outlined,
                  ),
                  label: 'Prices',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.article),
                  label: 'News',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onTapItem,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              showSelectedLabels: true,
            ),
          ),
        ));
  }

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}