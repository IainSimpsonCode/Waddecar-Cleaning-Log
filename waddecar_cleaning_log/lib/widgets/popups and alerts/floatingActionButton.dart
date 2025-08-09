import 'package:flutter/material.dart';
import 'package:waddecar_cleaning_log/widgets/popups%20and%20alerts/logEntryPopup.dart';

FloatingActionButton floatingActionButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () => showMaintenanceForm(context),
    tooltip: 'Increment',
    child: const Icon(Icons.add),
  );
}