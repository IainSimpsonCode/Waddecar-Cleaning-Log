import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:waddecar_cleaning_log/pages/CleaningLogViewer.dart';
import 'package:waddecar_cleaning_log/pages/MaintenanceLogViewer.dart';
import 'package:waddecar_cleaning_log/services/Providers/appBarNotifier.dart';
import 'package:waddecar_cleaning_log/services/Providers/filters.dart';
import 'package:waddecar_cleaning_log/services/Providers/globalAppData.dart';
import 'package:waddecar_cleaning_log/services/Providers/navBar.dart';
import 'package:waddecar_cleaning_log/services/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:waddecar_cleaning_log/style.dart';
import 'package:waddecar_cleaning_log/widgets/popups%20and%20alerts/floatingActionButton.dart';
import 'package:waddecar_cleaning_log/widgets/popups%20and%20alerts/logEntryPopup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FilterNotifier()),
        ChangeNotifierProvider(create: (_) => GlobalAppData()),
        ChangeNotifierProvider(create: (_) => NavBarNotifier()),
        ChangeNotifierProvider(create: (_) => AppBarNotifier()),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waddecar Mainenance Log',
      theme: lightTheme,
      initialRoute: '/',
      routes: {
        "/": (context) => MyHomePage(),
        "/Home": (context) => MyHomePage(),
        "/Maintenance": (context) => MaintenanceLogViewer(),
        "/Cleaning": (context) => CleaningLogViewer()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Provider.of<AppBarNotifier>(context, listen: false).GlobalAppBar(context),
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: Provider.of<NavBarNotifier>(context, listen: false).NavBar(context),
      floatingActionButton: floatingActionButton(context),
      body: Text("Pick a screen"),
    );
  }
}
