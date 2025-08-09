import 'package:flutter/material.dart';
import 'package:waddecar_cleaning_log/classes/LogItem.dart';
import 'package:waddecar_cleaning_log/services/Providers/filters.dart';
import 'package:provider/provider.dart';

class itemCardOptionButtons extends StatefulWidget {
  itemCardOptionButtons({super.key, required this.logItem});

  final LogItem logItem;

  @override
  State<StatefulWidget> createState() => itemCardOptionButtonsState();
}

class itemCardOptionButtonsState extends State<itemCardOptionButtons> {
  
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 400,
      child: ListView(
        scrollDirection: Axis.horizontal, 
        children: [
          // Not Started
          FilledButton(
            child: Text("To-Do"),
            onPressed: () {
      
            }, 
          ),
      
          // In Progress
          FilledButton(
            child: Text("Doing"),
            onPressed: () {
      
            }, 
          ),
      
          // Completed
          FilledButton(
            child: Text("Done"),
            onPressed: () {
      
            }, 
          ),
      
          // Delete
          FilledButton(
            child: Text("Delete"),
            onPressed: () {
      
            }, 
          ),
        ],
      ),
    );
  }
}