import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waddecar_cleaning_log/services/Providers/appBarNotifier.dart';
import 'package:waddecar_cleaning_log/services/Providers/navBar.dart';
import 'package:waddecar_cleaning_log/widgets/components/filterButtons.dart';
import 'package:waddecar_cleaning_log/widgets/popups%20and%20alerts/floatingActionButton.dart';
import 'package:waddecar_cleaning_log/widgets/units/itemListDisplay.dart';
import 'package:waddecar_cleaning_log/widgets/popups%20and%20alerts/logEntryPopup.dart';

class MaintenanceLogViewer extends StatefulWidget {
  MaintenanceLogViewer({super.key});

  @override
  State<MaintenanceLogViewer> createState() => _MaintenanceLogViewerState();
}

class _MaintenanceLogViewerState extends State<MaintenanceLogViewer> {

  @override
  Widget build(BuildContext context) {

    if (MediaQuery.sizeOf(context).width <= 850) {
      return _mobileView(context);
    }
    else {
      return _desktopView(context);
    }
  }

}

Widget _mobileView(BuildContext context) {
  return Scaffold(
    appBar: Provider.of<AppBarNotifier>(context, listen: false).GlobalAppBar(context),
    bottomNavigationBar: Provider.of<NavBarNotifier>(context, listen: false).NavBar(context),
    backgroundColor: Theme.of(context).colorScheme.surface,
    floatingActionButton: floatingActionButton(context),
    body: Column(
      children: [
        FilterButtons(),
        Expanded(
          child: ListView(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
            children: [

              SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("To-Do", style: Theme.of(context).textTheme.titleMedium),
              ),
              LogItemListView(jobType: "Maintenance", completionLevel: 0),

              SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("In Progress", style: Theme.of(context).textTheme.titleMedium),
              ),
              LogItemListView(jobType: "Maintenance", completionLevel: 1),

              SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Completed", style: Theme.of(context).textTheme.titleMedium),
              ),
              LogItemListView(jobType: "Maintenance", completionLevel: 2),

              SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Upcoming", style: Theme.of(context).textTheme.titleMedium),
              ),
              LogItemListView(jobType: "Maintenance", completionLevel: null, showUpcoming: true),
            ],
          )
        ),
      ],
    )
  );
}

Widget _desktopView(BuildContext context) {
  return Text("MaintenanceLogViewer Desktop");
}