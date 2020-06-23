import 'dart:convert';

import 'package:animation_rive/animation_controller/teddyController.dart';
import 'package:animation_rive/animation_controller/tracking_text.dart';
import 'package:animation_rive/pages/forgot_password.dart';
import 'package:animation_rive/pages/home.dart';
import 'package:animation_rive/pages/sign_up.dart';
import 'package:animation_rive/utils/database_helper.dart';
import 'package:animation_rive/widgets/loading_stack_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/pages/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  TeddyController _teddyController;
  String Username = "";
  String Password = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _teddyController = TeddyController();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingStackScreen(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            "Login",
            style: Theme.of(context)
                .textTheme
                .display1
                .copyWith(color: Colors.black, fontSize: 24),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 200,
                child: FlareActor(
                  "assets/Teddy.flr",
                  shouldClip: false,
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.contain,
                  controller: _teddyController,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                    border:
                        new Border.all(color: Colors.blueGrey[700], width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TrackingTextInput(
                        hint: "Email Address",
                        onTextChanged: (String value) {
                          Username = value;
                        },
                        onCaretMoved: (Offset caret) {
                          _teddyController.lookAt(caret);
                        }),
                    TrackingTextInput(
                      isObscured: true,
                      hint: "Password",
                      onCaretMoved: (Offset caret) {
                        _teddyController.coverEyes(caret != null);
                        _teddyController.lookAt(null);
                      },
                      onTextChanged: (String value) {
                        Password = value;
                        _teddyController.setPassword(value);
                      },
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _teddyController.coverEyes(false);
                          isLoading = true;
                        });
                        databaseHelper
                            .getUser(Username, Password)
                            .then((val) async {
                          if (val != null) {
                            _teddyController.playSuccess();
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            pref
                                .setString("user", json.encode(val.toMap()))
                                .then((_) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Home(val),
                                  ),
                                  (route) => false);
                            });
                          } else {
                            setState(() {
                              _teddyController.coverEyes(false);
                              isLoading = false;
                            });
                            _teddyController.submitPassword();
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Colors.purple, Colors.pink])),
                        child: Text(
                          "Sign In",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    GestureDetector(
                      child: Text(
                        "Forgot Password?",
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Colors.blueGrey[700]),
                      ),
                      onTap: () => Navigator.pushNamed(
                          context, ForgotPassword.routeName),
                    ),
                    GestureDetector(
                      child: Text(
                        "Register!!",
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Colors.blueGrey[700]),
                      ),
                      onTap: () =>
                          Navigator.pushNamed(context, SignUpPage.routeName),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      isLoading: isLoading,
    );
  }
}
