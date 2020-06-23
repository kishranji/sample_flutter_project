import 'package:flutter/material.dart';

class LoadingStackScreen extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  LoadingStackScreen({this.child, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        (isLoading == true)
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.grey.withOpacity(0.7),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 72,
                        width: 72,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/images/loading.gif',
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
