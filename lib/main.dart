import 'package:flutter/material.dart';
import 'package:location_service/provider/location_service_provider.dart';
import 'package:location_service/service/location_service.dart';
import 'package:location_service/service/notification_service.dart';
import 'package:location_service/view/page/home_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  PrefManager().pref = await SharedPreferences.getInstance();

  await NotificationService().initializeNotifications();
  runApp(
    Provider<LocationService>(
      create: (_) => LocationService(),
      child: ChangeNotifierProvider<LocationProvider>(
        create: (context) => LocationProvider(
          locationService: Provider.of<LocationService>(context, listen: false),
        ),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const HomePage(),
    );
  }
}
