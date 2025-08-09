import 'package:flutter/material.dart';

Widget priorityIcon(int priority) {

  Color backgroundColor = Colors.green;
  if (priority == 1) { backgroundColor = Colors.red; }
  else if (priority == 2) { backgroundColor = Colors.deepOrange; }
  else if (priority == 3) { backgroundColor = Colors.amber; }
  else if (priority == 4) { backgroundColor = const Color.fromARGB(255, 213, 255, 59); }
  else if (priority == 5) { backgroundColor = Colors.green; }

  return Container(
    width: 30,
    height: 30,
    decoration: BoxDecoration(
      color: backgroundColor,
      border: Border.all(
        color: Colors.black,
        width: 3,
      ),
      borderRadius: BorderRadius.all(Radius.circular(5))
    ),
    child: Center(
      child: Text("$priority", style: TextStyle(color: Colors.black)),
    ),
  );
}