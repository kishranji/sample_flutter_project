import 'package:animation_rive/animation_controller/teddyController.dart';
import 'package:animation_rive/animation_controller/tracking_text.dart';
import 'package:animation_rive/model/users.dart';
import 'package:animation_rive/pages/forgot_password.dart';
import 'package:animation_rive/pages/sign_up.dart';
import 'package:animation_rive/utils/database_helper.dart';
import 'package:animation_rive/widgets/loading_stack_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login.dart';

class ChangePasswordPage extends StatefulWidget {
  static const String routeName = '/pages/change_password';
  Users user;

  ChangePasswordPage(this.user);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TeddyController _teddyController;
  String confirmPassword = "";
  String password = "";
  DatabaseHelper databaseHelper = DatabaseHelper();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _teddyController = TeddyController();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingStackScreen(
      isLoading: isLoading,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            "Change Password",
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
                      isObscured: true,
                      hint: "Password",
                      onCaretMoved: (Offset caret) {
                        _teddyController.coverEyes(caret != null);
                        _teddyController.lookAt(null);
                      },
                      onTextChanged: (String value) {
                        password = value;
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
                        confirmPassword = value;
                        _teddyController.setPassword(value);
                      },
                    ),
                    InkWell(
                      onTap: () {
                        if (password != "" && confirmPassword != "") {
                          setState(() {
                            _teddyController.coverEyes(false);
                            isLoading = true;
                          });
                          if (password == confirmPassword) {
                            widget.user.password = confirmPassword;
                            databaseHelper.updateUser(widget.user).then((val){
                              if(val != null){
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.pushNamedAndRemoveUntil(
                                    context, LoginPage.routeName, (route) => false);
                              }else{
                                showToast(context, "Unable to update password");
                                _teddyController.submitPassword();
                              }
                            });

                          } else
                            showToast(context,
                                "Password and confirm password not match!!");
                          _teddyController.submitPassword();
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
                          "Reset Password",
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
