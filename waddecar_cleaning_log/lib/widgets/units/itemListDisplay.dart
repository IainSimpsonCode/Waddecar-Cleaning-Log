import 'package:flutter/material.dart';
import 'package:waddecar_cleaning_log/classes/LogItem.dart';
import 'package:waddecar_cleaning_log/services/Providers/filters.dart';
import 'package:waddecar_cleaning_log/services/firebase.dart';
import 'package:provider/provider.dart';
import 'package:waddecar_cleaning_log/widgets/components/itemCard.dart';


class LogItemListView extends StatefulWidget {
  LogItemListView({super.key, required this.jobType, required this.completionLevel, this.showUpcoming = false});

  final String jobType;
  final int? completionLevel;
  final bool showUpcoming;

  @override
  State<LogItemListView> createState() => _LogItemListViewState();
}

class _LogItemListViewState extends State<LogItemListView> {
  @override
  Widget build(BuildContext context) {

    final filterBy = context.watch<FilterNotifier>().filterBy;

    return StreamBuilder<List<LogItem>>(
      stream: streamLogItems(widget.jobType, widget.completionLevel, widget.showUpcoming),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          print(snapshot.error);
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final logs = snapshot.data ?? [];

        logs.sort((a, b) {
          switch (filterBy) {
            case 'priority':
              return a.priority.compareTo(b.priority); // highest priority first
            case 'dueBy':
              if (a.dueBy == null && b.dueBy == null) return 0;
              if (a.dueBy == null) return 1;
              if (b.dueBy == null) return -1;
              return a.dueBy!.compareTo(b.dueBy!); // ascending
            case 'location':
              return a.location.toLowerCase().compareTo(b.location.toLowerCase());
            default:
              return 0;
          }
        });

        if (logs.isEmpty) {
          return Center(child: Text('No logs found.'));
        }

        List<itemCard> columnItems = [];
        for (LogItem log in logs) {
          columnItems.add(log.toItemCard());
        }
        return Column(children: columnItems);
      },
    );
  }
}
