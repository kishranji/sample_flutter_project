import 'dart:convert';

import 'package:animation_rive/animation_controller/teddyController.dart';
import 'package:animation_rive/animation_controller/tracking_text.dart';
import 'package:animation_rive/model/users.dart';
import 'package:animation_rive/utils/database_helper.dart';
import 'package:animation_rive/widgets/loading_stack_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/pages/sign_up';
  Users user;

  ProfilePage(this.user);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TeddyController _teddyController;
  bool isLoading = false;
  String Username = "";
  String PhoneNumber = "";
  String EmailAddress = "";
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _teddyController = TeddyController();
    Username = widget.user.name;
    PhoneNumber = widget.user.phone;
    EmailAddress = widget.user.email;
  }

  @override
  Widget build(BuildContext context) {
    return LoadingStackScreen(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                        hint: "User Name",
                        text: widget.user.name,
                        onTextChanged: (String value) {
                          Username = value;
                        },
                        onCaretMoved: (Offset caret) {
                          _teddyController.lookAt(caret);
                        }),
                    TrackingTextInput(
                        hint: "Phone Number",
                        text: widget.user.phone,
                        onTextChanged: (String value) {
                          PhoneNumber = value;
                        },
                        maxLines: 10,
                        inputType: TextInputType.number,
                        onCaretMoved: (Offset caret) {
                          _teddyController.lookAt(caret);
                        }),
                    TrackingTextInput(
                        hint: "Email Address",
                        text: widget.user.email,
                        onTextChanged: (String value) {
                          EmailAddress = value;
                        },
                        inputType: TextInputType.emailAddress,
                        onCaretMoved: (Offset caret) {
                          _teddyController.lookAt(caret);
                        }),
                    InkWell(
                      onTap: () {
                        if (Username != "" &&
                            EmailAddress != "" &&
                            PhoneNumber != "") {
                          if (PhoneNumber.length == 10) {
                            setState(() {
                              isLoading = true;
                            });

                            Users aUser = widget.user;
                            aUser.name = Username;
                            aUser.phone = PhoneNumber;
                            aUser.email = EmailAddress;
                            databaseHelper.updateUser(aUser).then((val) async {
                              print(val);
                              if (val != null) {
                                _teddyController.playSuccess();
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                pref
                                    .setString(
                                        "user", json.encode(aUser.toMap()))
                                    .then((_) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Home(aUser),
                                      ),
                                      (route) => false);
                                });
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                _teddyController.submitPassword();
                              }
                            });
                          } else {
                            showToast(
                                context, "Please enter a valid phone number");
                            _teddyController.submitPassword();
                          }
                        } else {
                          showToast(context, "Please fill all the fields");
                          _teddyController.submitPassword();
                        }
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
                          "Update",
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
            ],
          ),
        ),
      ),
      isLoading: isLoading,
    );
  }

  void showToast(BuildContext context, String s) {
    Fluttertoast.showToast(
        msg: s,
        timeInSecForIos: 3,
        backgroundColor: Colors.blueGrey[700],
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM);
  }
}
