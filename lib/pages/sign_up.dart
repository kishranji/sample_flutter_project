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

class SignUpPage extends StatefulWidget {
  static const String routeName = '/pages/sign_up';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TeddyController _teddyController;
  bool isLoading = false;
  String Username = "";
  String Password = "";
  String ConfirmPassword = "";
  String PhoneNumber = "";
  String EmailAddress = "";
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _teddyController = TeddyController();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingStackScreen(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            "Sign Up",
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
                        hint: "User Name",
                        onTextChanged: (String value) {
                          Username = value;
                        },
                        onCaretMoved: (Offset caret) {
                          _teddyController.lookAt(caret);
                        }),
                    TrackingTextInput(
                        hint: "Phone Number",
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
                        onTextChanged: (String value) {
                          EmailAddress = value;
                        },
                        inputType: TextInputType.emailAddress,
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
                    TrackingTextInput(
                      isObscured: true,
                      hint: "Confirm Password",
                      onCaretMoved: (Offset caret) {
                        _teddyController.coverEyes(caret != null);
                        _teddyController.lookAt(null);
                      },
                      onTextChanged: (String value) {
                        ConfirmPassword = value;
                        _teddyController.setPassword(value);
                      },
                    ),
                    InkWell(
                      onTap: () {
                        if (Username != "" &&
                            Password != "" &&
                            ConfirmPassword != "" &&
                            EmailAddress != "" &&
                            PhoneNumber != "") {
                          if (ConfirmPassword == Password) {
                            if (PhoneNumber.length == 10) {
                              setState(() {
                                isLoading = true;
                              });

                              databaseHelper
                                  .checkUser(EmailAddress, PhoneNumber)
                                  .then((val) {
                                if (val < 1) {
                                  Users aUser = Users(Username, PhoneNumber,
                                      EmailAddress, Password);
                                  databaseHelper.insertUser(aUser).then((val) {
                                    print(val);
                                    if (val != null) {
                                      _teddyController.playSuccess();

                                      Future.delayed(
                                          Duration(milliseconds: 300),
                                          () => Navigator.pop(context));

                                      setState(() {
                                        isLoading = false;
                                      });
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      _teddyController.submitPassword();
                                    }
                                  });
                                } else {
                                  showToast(context,
                                      "User Email or Phone number already registered");
                                  setState(() {
                                    isLoading = false;
                                  });
                                  _teddyController.submitPassword();
                                }
                              });
                            }else {
                              showToast(context,
                                  "Please enter a valid phone number");
                              _teddyController.submitPassword();
                            }
                          } else {
                            showToast(context,
                                "Password doesn't match confirm password");
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
                          "Register",
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
