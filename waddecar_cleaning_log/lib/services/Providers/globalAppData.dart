import 'package:flutter/material.dart';

class GlobalAppData extends ChangeNotifier {
  String _appTitle = 'location';

  String get appTitle => _appTitle;

  void setAppTitle(String newAppTitle) {
    _appTitle = newAppTitle;
    notifyListeners();
  }
}