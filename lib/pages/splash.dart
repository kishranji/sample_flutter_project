import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:animation_rive/model/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'login.dart';

class SplashPage extends StatefulWidget {
  static const timeout = const Duration(seconds: 4);
  static const ms = const Duration(milliseconds: 1);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer _timer;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  get val => null;

  Timer _startTimeout(BuildContext context, int milliseconds) {
    var duration = milliseconds == null
        ? SplashPage.timeout
        : SplashPage.ms * milliseconds;
    return Timer(duration, () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var user = pref.getString('user');
      if (user != null) {
        var loginUser = Users.fromMapObject(json.decode(user));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Home(loginUser),
            ),
            (route) => false);
      } else
        Navigator.pushNamedAndRemoveUntil(
            context, LoginPage.routeName, (route) => false);
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      setState(() {
        _timer = _startTimeout(context, 3000);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: new Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Image.asset(
          "assets/images/flutter_logo.png",
          fit: BoxFit.fitHeight,
          width: MediaQuery.of(context).size.width * 0.5,
        ),
      ),
    );
  }
}
