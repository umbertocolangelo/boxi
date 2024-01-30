import 'package:boxi/pages/locker_map_page.dart';
import 'package:boxi/pages/locker_list_page.dart';
import 'package:boxi/pages/myboxes_page.dart';
import 'package:boxi/pages/profile_page.dart';
import 'package:flutter/material.dart';

class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget({super.key});

  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    MapPage(label: 'Map'),
    ListPage(label: 'List'),
    MyBoxesPage(label: 'MyBoxes'),
    ProfilePage(label: 'Profile'),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedLabelStyle: TextStyle(fontSize: 10),
      unselectedLabelStyle: TextStyle(fontSize: 10),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'List',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'MyBoxes',
        ),
      ],
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      iconSize: 26,
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => _screens[_currentIndex],
          ),
        );
      },
    );
  }
}

