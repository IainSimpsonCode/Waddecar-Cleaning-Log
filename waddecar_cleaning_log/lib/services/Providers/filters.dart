import 'package:flutter/material.dart';

class FilterNotifier extends ChangeNotifier {
  String _filterBy = 'location';

  String get filterBy => _filterBy;

  void setFilter(String filter) {
    _filterBy = filter;
    notifyListeners();
  }
}