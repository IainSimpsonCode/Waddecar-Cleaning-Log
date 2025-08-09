import 'package:flutter/material.dart';

class AppBarNotifier extends ChangeNotifier {
  String _appTitle = "";

  void setAppTitle(String appTitle) {
    _appTitle = appTitle;
  }

  AppBar GlobalAppBar(BuildContext context) {
    return AppBar(title: Text(_appTitle));
  }
}