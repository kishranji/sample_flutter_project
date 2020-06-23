import 'package:animation_rive/animation_controller/teddyController.dart';
import 'package:animation_rive/animation_controller/tracking_text.dart';
import 'package:animation_rive/pages/change_password.dart';
import 'package:animation_rive/pages/sign_up.dart';
import 'package:animation_rive/utils/database_helper.dart';
import 'package:animation_rive/widgets/loading_stack_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPassword extends StatefulWidget {
  static const String routeName = '/pages/forgot_password';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TeddyController _teddyController;
  DatabaseHelper databaseHelper = DatabaseHelper();
  String PhoneNumber = "";
  bool isLoading = false;
  String Otp = "";

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
            "Forgot Password",
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
                        hint: "Mobile Number",
                        inputType: TextInputType.number,
                        maxLines: 10,
                        onTextChanged: (String value) {
                          PhoneNumber = value;
                        },
                        onCaretMoved: (Offset caret) {
                          _teddyController.lookAt(caret);
                        }),
                    TrackingTextInput(
                      isObscured: true,
                      hint: "Otp (any 4 digit)",
                      maxLines: 4,
                      inputType: TextInputType.number,
                      onCaretMoved: (Offset caret) {
                        _teddyController.coverEyes(caret != null);
                        _teddyController.lookAt(null);
                      },
                      onTextChanged: (String value) {
                        Otp = value;
                        _teddyController.setPassword(value);
                      },
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isLoading = true;
                          _teddyController.coverEyes(false);
                        });
                        if (PhoneNumber != "" && Otp != "") {
                          if (PhoneNumber.length == 10) {
                            if (Otp.length == 4) {
                              databaseHelper
                                  .getUserWithMobile(PhoneNumber)
                                  .then((val) {
                                if (val != null) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  _teddyController.playSuccess();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ChangePasswordPage(val),
                                      ));
                                } else {
                                  _teddyController.submitPassword();
                                  showToast(context, "Invalid Mobile Number");
                                }
                              });
                            } else {
                              _teddyController.submitPassword();
                              showToast(context, "please enter a valid otp");
                            }
                          } else {
                            _teddyController.submitPassword();
                            showToast(
                                context, "please enter a valid phone number");
                          }
                        } else
                          _teddyController.submitPassword();
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
                          "Change Password",
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
    setState(() {
      isLoading = false;
    });
    Fluttertoast.showToast(
        msg: s,
        timeInSecForIos: 3,
        backgroundColor: Colors.blueGrey[700],
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM);
  }
}
