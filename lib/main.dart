import 'package:animation_rive/animation_controller/teddyController.dart';
import 'package:animation_rive/app_theme.dart';
import 'package:animation_rive/pages/splash.dart';
import 'package:flutter/material.dart';

import 'app_routes.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TeddyController _teddyController;

  @override
  void initState() {
    super.initState();
    _teddyController = TeddyController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sample',
      home: SplashPage(),
     theme: ThemeData(
        primarySwatch: Colors.blueGrey, primaryColor: Colors.blueGrey[700]),
      routes: AppRoutes.appRoutes(context),
    );
  }
}
