import 'package:fennechms/screens/home_screen.dart';
import 'package:fennechms/screens/profile_screen.dart';
import 'package:fennechms/screens/search_screen.dart';
import 'package:fennechms/screens/services_screen.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {
  static const routeName = 'tab_screen';

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _pages = [];
  int _selectedPageIndex = 0;
  Future<bool> _onWillPop() async {
    return (await false);
  }

  @override
  void initState() {
    _pages = [
      {
        'page': HomeScreen(),
        'title': 'Home Screen',
      },
      {
        'page': SearchScreen(),
        'title': 'Search Screen',
      },
      {
        'page': ServicesScreen(),
        'title': 'Services Screen',
      },
      {
        'page': ProfileScreen(),
        'title': 'Profile Screen',
      }
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(_pages[_selectedPageIndex]['title'].toString())),
          automaticallyImplyLeading: false,
        ),
        body: _pages[_selectedPageIndex]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 30,
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.white,
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              backgroundColor: Theme.of(context).primaryColor,
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.local_activity,
                color: Colors.white,
              ),
              backgroundColor: Theme.of(context).primaryColor,
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.miscellaneous_services,
                color: Colors.white,
              ),
              backgroundColor: Theme.of(context).primaryColor,
              label: 'Services',
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              backgroundColor: Theme.of(context).primaryColor,
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
