import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waddecar_cleaning_log/services/Providers/appBarNotifier.dart';

class NavBarNotifier extends ChangeNotifier {
  int _selectedIndex = 1;

  final Map<String, BottomNavigationBarItem> _bottomNavBarPages = {
    "Maintenance": BottomNavigationBarItem(icon: Icon(Icons.handyman), label: 'Maintenance'),
    "Home": BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    "Cleaning": BottomNavigationBarItem(icon: Icon(Icons.handyman), label: 'Cleaning')
  };

  BottomNavigationBar NavBar(BuildContext context) {
    final keys = _bottomNavBarPages.keys.toList();

    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (int index) {
        _selectedIndex = index;
        
        Provider.of<AppBarNotifier>(context, listen: false).setAppTitle(keys[index]);
        Navigator.pushNamed(context, "/${keys[index]}");
      },
      items: _bottomNavBarPages.values.toList(),
    );
  }
}