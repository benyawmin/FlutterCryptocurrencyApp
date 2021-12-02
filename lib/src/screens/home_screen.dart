import 'package:cryptocurrency/src/accessories/pallete.dart';
import 'package:cryptocurrency/src/screens/user.dart';
import 'package:cryptocurrency/src/widgets/user_secure_storage.dart';
import 'package:flutter/material.dart';
// import 'search.dart';
import 'categories.dart';
import 'chart_al.dart';
import 'history.dart';
import 'home.dart';
import 'prices.dart';

class HomeScreen extends StatefulWidget {
  final String token;
  const HomeScreen(this.token, {Key? key}) : super(key: key);

  @override
  createState() {
    return HomeScreenState();
  }
}

@override
class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> get _widgetOptions => <Widget>[
        User(widget.token),
        const Prices(),
        News(),
        History(widget.token),
        // ChartAl('null', 'Line'),
        // const ItemsWidget(),
        Trade(widget.token),
      ];

  @override
  Widget build(BuildContext context) {
    print(widget.token);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Crypto'),
          backgroundColor: Pallete.dark_primary_color,
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: SizedBox(
          width: 20,
          child: Card(
            shape: const RoundedRectangleBorder(
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
                  icon: Icon(
                    Icons.history,
                  ),
                  label: 'History',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_bag,
                  ),
                  label: 'Trade',
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
