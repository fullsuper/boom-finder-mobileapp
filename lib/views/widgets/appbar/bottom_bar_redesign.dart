import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  static int selectedIndex = 0;

  BottomBar(context){
      switch(ModalRoute.of(context).settings.name){
        case '/': selectedIndex = 0; break;
        case '/search_room': selectedIndex = 2; break;
        default: selectedIndex = 1; break;
      }
  }

  @override
  _BottomBarState createState() => _BottomBarState();
}


class _BottomBarState extends State<BottomBar> {
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      BottomBar.selectedIndex = index;
    });
    switch(BottomBar.selectedIndex){
      case 0: Navigator.pushNamed(context, '/'); break;
      case 1: Navigator.pushNamed(context, '/list_room'); break;
      default: Navigator.pushNamed(context, '/search_room'); break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Rooms'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('Search'),
          ),
        ],
        currentIndex: BottomBar.selectedIndex,
        onTap: _onItemTapped,
    );
  }


}
