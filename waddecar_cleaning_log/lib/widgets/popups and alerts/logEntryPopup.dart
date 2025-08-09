import 'package:flutter/material.dart';
import 'package:waddecar_cleaning_log/widgets/units/newLogForm.dart';

void showMaintenanceForm(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // allows custom height
    backgroundColor: Colors.transparent, // so we can add rounded corners
    isDismissible: true,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.66, // 2/3 of the screen
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: newLogForm(
            onSubmit: () {
              Navigator.of(context).pop();
            },
          ),
        );
      },
    ),
  );
}