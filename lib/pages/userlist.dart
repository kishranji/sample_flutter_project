import 'package:animation_rive/model/users.dart';
import 'package:animation_rive/utils/database_helper.dart';
import 'package:animation_rive/widgets/loading_stack_screen.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Users>>(
      future: databaseHelper.getUserList(),
      builder: (BuildContext context, AsyncSnapshot<List<Users>> snapshot) {
        if (snapshot.hasData) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  Users item = snapshot.data[index];
                  return GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 10.0, right: 10.0, bottom: 10.0, top: 5.0),
                      child: Card(
                        elevation: 2,
                        child: CustomPaint(
                          painter: _CurvePainter(color: Colors.blueGrey),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: Text(
                                        item.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .title
                                            .copyWith(fontSize: 18),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: Text(
                                        item.email,
                                        style: Theme.of(context)
                                            .textTheme
                                            .display1
                                            .copyWith(
                                                color: Color(0xff898989),
                                                fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.blueGrey,
                                  child: Text(
                                    item.name.substring(0, 1).toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      null;
                    },
                  );
                }, childCount: snapshot.data.length),
              )
            ],
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        return Center(
          child: Center(
            child: LoadingStackScreen(
              child: Container(),
              isLoading: true,
            ),
          ),
        );
      },
    );
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}

class _CurvePainter extends CustomPainter {
  Color color;
  int heightOffset;
  double width;

  _CurvePainter(
      {this.color = Colors.grey, this.heightOffset = 30, this.width = 20});

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = this.color;

    Path path = Path()
      ..moveTo(0, size.height / 2 - this.heightOffset)
      ..quadraticBezierTo(
          this.width, size.height / 2, 0, size.height / 2 + this.heightOffset);

    canvas.drawPath(path, paint);
  }
}
