import 'package:flutter/material.dart';
import 'package:waddecar_cleaning_log/services/Providers/filters.dart';
import 'package:provider/provider.dart';

class FilterButtons extends StatefulWidget {
  FilterButtons({super.key});

  @override
  State<StatefulWidget> createState() => FilterButtonsState();
}

class FilterButtonsState extends State<FilterButtons> {
  
  
  @override
  Widget build(BuildContext context) {

    final filterBy = context.watch<FilterNotifier>().filterBy;

    const filters = {
      "Priority": "priority",
      "Due By": "dueBy",
      "Location": "location"
    };


    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(8),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final displayText = filters.keys.elementAt(index);
          final value = filters.values.elementAt(index);
          final isFilled = filterBy == value;
      
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _getFormattedButton(context, displayText, value, isFilled),
          );
        },
      ),
    );
  }
}

Widget _getFormattedButton(BuildContext context, String displayText, String value, bool isFilled) {
  if (isFilled) {
    return FilledButton(
      child: Text(displayText),
      onPressed: () {
        Provider.of<FilterNotifier>(context, listen: false).setFilter(value);
      }, 
    );
  } else {
    return OutlinedButton(
      child: Text(displayText),
      onPressed: () {
        Provider.of<FilterNotifier>(context, listen: false).setFilter(value);
      }, 
    );
  }
}