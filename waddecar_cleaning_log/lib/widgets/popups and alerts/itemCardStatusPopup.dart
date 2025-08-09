import 'package:flutter/material.dart';
import 'package:waddecar_cleaning_log/classes/LogItem.dart';
import 'package:waddecar_cleaning_log/services/firebase.dart';

void showItemCardStatusOptions(BuildContext context, LogItem logItem) {
  showModalBottomSheet(
    context: context,
    builder: (_) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.play_arrow),
          title: Text('Mark To-Do'),
          onTap: () {
            updateDoc(logItem.docID!, "completion", 0);
            Navigator.of(context).pop();
          },
        ),
        logItem.jobType == "Maintenance" ? 
          ListTile(
            leading: Icon(Icons.play_arrow),
            title: Text('Mark In Progress'),
            onTap: () {
              updateDoc(logItem.docID!, "completion", 1);
              Navigator.of(context).pop();
            },
          ) : SizedBox(width: 0, height: 0),
        ListTile(
          leading: Icon(Icons.check),
          title: Text('Mark Completed'),
          onTap: () {
            updateDoc(logItem.docID!, "completion", 2);
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}