import 'package:animation_rive/model/users.dart';
import 'package:animation_rive/pages/profile_page.dart';
import 'package:animation_rive/pages/userlist.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class DrawerItems {
  String title;
  IconData icon;

  DrawerItems(this.title, this.icon);
}

class Home extends StatefulWidget {
  final drawerItems = [
    new DrawerItems("Home", Icons.home),
    new DrawerItems("Profile", Icons.edit),
    new DrawerItems("Log Out", Icons.account_circle)
  ];
  final Users _myUser;

  Home(this._myUser);

  @override
  _HomeState createState() => _HomeState(_myUser);
}

class _HomeState extends State<Home> {
  int _selectedDrawerIndex = 0;
  Users _myUsers;
  String title = "Home";

  _HomeState(this._myUsers);

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return UserList();
      case 1:
        return ProfilePage(_myUsers);
      default:
        return new Text("Error");
    }
  }

  Future<void> _logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginPage.routeName, (route) => false);
  }

  _onSelectItem(int index) {
    var d = widget.drawerItems[index];
    if (index == 2) {
      _logout();
    } else {
      setState(() => _selectedDrawerIndex = index);
      setState(() {
        title = d.title;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          title,
          style: Theme.of(context)
              .textTheme
              .display1
              .copyWith(color: Colors.black, fontSize: 24),
        ),
        elevation: 0,
        iconTheme: new IconThemeData(color: Colors.blueGrey[700]),
        backgroundColor: Colors.white,
        centerTitle: true,
//        leading: Icon(Icons.add),
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(_myUsers.name),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              accountEmail: new Text(_myUsers.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blueGrey[700]
                        : Colors.white,
                child: Text(
                  _myUsers.name.substring(0, 1).toUpperCase(),
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
