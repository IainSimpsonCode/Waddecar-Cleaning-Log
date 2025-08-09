import 'package:flutter/material.dart';
import 'package:waddecar_cleaning_log/classes/LogItem.dart';
import 'package:waddecar_cleaning_log/services/firebase.dart';
import 'package:waddecar_cleaning_log/widgets/components/itemCardOptionButtons.dart';
import 'package:waddecar_cleaning_log/widgets/components/priorityIcon.dart';
import 'package:waddecar_cleaning_log/widgets/popups%20and%20alerts/itemCardStatusPopup.dart';

class itemCard extends StatefulWidget {
  itemCard({super.key, required this.logItem});

  final LogItem logItem;

  bool extended = false;

  @override
  State<itemCard> createState() => _itemCardState();
}

class _itemCardState extends State<itemCard> {

  @override
  Widget build(BuildContext context) {

    // Check if the card is a current or upcoming task
    bool isFuture = false;
    if (widget.logItem.availableFrom!.isAfter(DateTime.now())) {
      isFuture = true;
    }

    final Duration? daysToDue = widget.logItem.dueBy?.difference(DateTime.now());
    final String dueDateMessage = (widget.logItem.dueBy == null) ? "No due date set" : "${daysToDue!.inDays < 0 ? "Overdue" : "Due in"}: ${daysToDue.inDays >= 21 ? (daysToDue.inDays / 7).floor() : daysToDue.inDays} ${daysToDue!.inDays >= 21 ? "Weeks" : "Days"}";
    
    final Duration? daysToAvailable = widget.logItem.availableFrom?.difference(DateTime.now());
    final String availableFromMessage = isFuture ? "Available In: ${daysToAvailable!.inDays >= 21 ? (daysToAvailable.inDays / 7).floor() : daysToAvailable.inDays} ${daysToAvailable.inDays >= 21 ? "Weeks" : "Days"}" : "";

    Color? highlightColour = null;
    if (widget.logItem.dueBy == null) { // Highlight yellow if the due date is not set
      highlightColour = Colors.amberAccent.withAlpha(100);
    }
    else if (daysToDue != null && daysToDue.inDays <= 0) {
      highlightColour = Colors.redAccent.withAlpha(100);
    }


    return ListTile(
      tileColor: highlightColour,
      leading: priorityIcon(widget.logItem.priority),
      title: Text(widget.logItem.title),
      subtitle: widget.extended ? Text(widget.logItem.description) : null,
      trailing: _trailingWidgets(context, dueDateMessage, availableFromMessage, widget.logItem),
      isThreeLine: widget.extended,
      onTap: () {
        setState(() {
          widget.extended = !widget.extended;
        });
      },
    );
  }
}

Widget _trailingWidgets(BuildContext context, String dueDateMessage, String availableInMessage, LogItem logItem) {
  return SizedBox(
    width: 160,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: 8,
      children: [
        Text("$dueDateMessage${availableInMessage != "" ? "\n" : ""}$availableInMessage\n${logItem.location}", textAlign: TextAlign.end,),
        availableInMessage == "" ? IconButton(
          onPressed: () {
            showItemCardStatusOptions(context, logItem);
          }, 
          icon: Icon(Icons.list)
        ) : SizedBox(),
      ],
    ),
  );
}