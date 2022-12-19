import 'package:flutter/material.dart';
import 'package:pocket_kakeibo/pages/home_screen.dart';
import 'package:pocket_kakeibo/pages/income_screen.dart';
import 'package:pocket_kakeibo/pages/report_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    IncomeScreen(),
    ReportScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Pocket Kakeibo',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Income',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Report',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
