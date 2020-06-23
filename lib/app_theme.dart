import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData themeData() {
    const MaterialColor mamaPink = const MaterialColor(
      0xFFFE9BC0,
      const <int, Color>{
        50: const Color(0xFFFF98BE),
        100: const Color(0xFFFF98BE),
        200: const Color(0xFFFF98BE),
        300: const Color(0xFFFF98BE),
        400: const Color(0xFFFF98BE),
        500: const Color(0xFFFF98BE),
        600: const Color(0xFFFF98BE),
        700: const Color(0xFFFF98BE),
        800: const Color(0xFFFF98BE),
        900: const Color(0xFFFF98BE),
      },
    );

    return ThemeData(
      // ignore: unrelated_type_equality_checks
      primaryColor: Colors.blueGrey[700],
      // Colors.pinkAccent,
      // ignore: unrelated_type_equality_checks
      primaryColorLight: Color(0xFFFFCCDF),
      backgroundColor: Colors.white,
      splashColor: Color(0xFFFF98BE),
      primarySwatch: mamaPink,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Helvatica',
      textTheme: TextTheme(

          title: TextStyle(
              fontSize: 21.0,
              color: Colors.black,
              fontFamily: 'Helvatica',fontWeight: FontWeight.w500 //grey.shade400,
              ),
          headline: TextStyle(
              fontSize: 19.0, color: Colors.black, fontFamily: 'Helvatica',fontWeight: FontWeight.w500),
          body1: TextStyle(fontSize: 15.0, color: Colors.black,fontFamily: 'Helvatica',fontStyle: FontStyle.normal),
          body2: TextStyle(fontSize: 16.0, color: Colors.black,fontFamily: 'Helvatica',fontWeight: FontWeight.w700),
          display1: TextStyle(fontSize: 18.0, color: Colors.black,fontFamily: 'Helvatica',fontWeight: FontWeight.w700),
          display2: TextStyle(fontSize: 17.0, color: Colors.black,fontFamily: 'Helvatica',fontWeight: FontWeight.w500),
          display3: TextStyle(fontSize: 17.0, color: Colors.black,fontFamily: 'Helvatica',fontStyle: FontStyle.normal),
          display4: TextStyle(
            color: Colors.pinkAccent,
            fontWeight: FontWeight.normal,
            fontSize: 16.0,
            decoration: TextDecoration.underline,
          ),
          subtitle: TextStyle(fontSize: 14.0, color: Colors.grey,fontFamily: 'Helvatica',fontStyle: FontStyle.normal),
          caption: TextStyle(fontSize: 12.0, color: Colors.grey,fontFamily: 'Helvatica',fontStyle: FontStyle.normal)),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.pinkAccent,
      ),
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0.0,
        textTheme: TextTheme(
            title: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        )),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      tabBarTheme: TabBarTheme(
          labelColor: Colors.black,
          labelStyle: TextStyle(color: Colors.black),
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 4.0, color: Color(0xFFFF98BE)),
              insets: EdgeInsets.symmetric(horizontal: 20)),
          unselectedLabelColor: Color(0x4d000000),
          labelPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0)),
    );
  }

  static ThemeData calendarThemeData() => themeData().copyWith(
        accentColor: themeData().primaryColor,
      );

  static ThemeData antenatalThemeData() => themeData().copyWith(
        tabBarTheme: TabBarTheme(
            labelColor: themeData().primaryColor,
            labelStyle: TextStyle(
              fontSize: 18,
              color: themeData().primaryColor,
            ),
            indicator: UnderlineTabIndicator(
                borderSide:
                    BorderSide(width: 2, color: themeData().primaryColor),
                insets: EdgeInsets.symmetric(horizontal: 10)),
            unselectedLabelColor: Color(0x4d000000),
            labelPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 30),
            unselectedLabelStyle: TextStyle(
              fontSize: 18,
            )),
      );
}


class AppMaleTheme {
  static ThemeData themeData() {
    const MaterialColor mamaPink = const MaterialColor(
      0xFFFE9BC0,
      const <int, Color>{
        50: const Color(0xFFFF98BE),
        100: const Color(0xFFFF98BE),
        200: const Color(0xFFFF98BE),
        300: const Color(0xFFFF98BE),
        400: const Color(0xFFFF98BE),
        500: const Color(0xFFFF98BE),
        600: const Color(0xFFFF98BE),
        700: const Color(0xFFFF98BE),
        800: const Color(0xFFFF98BE),
        900: const Color(0xFFFF98BE),
      },
    );

    return ThemeData(
      // ignore: unrelated_type_equality_checks
      primaryColor: Color(0xFF8FB5FF),
      // Colors.pinkAccent,
      // ignore: unrelated_type_equality_checks
      primaryColorLight: Color(0xFFC7DAFE),
      backgroundColor: Colors.white,
      splashColor: Color(0xFFC7DAFE),
      primarySwatch: mamaPink,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Helvatica',
      textTheme: TextTheme(
          title: TextStyle(
              fontSize: 21.0,
              color: Colors.black,
              fontFamily: 'Helvatica',fontWeight: FontWeight.w500 //grey.shade400,
          ),
          headline: TextStyle(
              fontSize: 19.0, color: Colors.black, fontFamily: 'Helvatica',fontWeight: FontWeight.w500),
          body1: TextStyle(fontSize: 15.0, color: Colors.black,fontFamily: 'Helvatica',fontStyle: FontStyle.normal),
          display1: TextStyle(fontSize: 18.0, color: Colors.black,fontFamily: 'Helvatica',fontWeight: FontWeight.w700),
          display2: TextStyle(fontSize: 17.0, color: Colors.black,fontFamily: 'Helvatica',fontWeight: FontWeight.w500),
          display3: TextStyle(fontSize: 17.0, color: Colors.black,fontFamily: 'Helvatica',fontStyle: FontStyle.normal),
          display4: TextStyle(
            color: Colors.pinkAccent,
            fontWeight: FontWeight.normal,
            fontSize: 16.0,
            decoration: TextDecoration.underline,
          ),
          subtitle: TextStyle(fontSize: 14.0, color: Colors.grey,fontFamily: 'Helvatica',fontStyle: FontStyle.normal),
          caption: TextStyle(fontSize: 12.0, color: Colors.grey,fontFamily: 'Helvatica',fontStyle: FontStyle.normal)),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.pinkAccent,
      ),
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0.0,
        textTheme: TextTheme(
            title: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            )),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      tabBarTheme: TabBarTheme(
          labelColor: Colors.black,
          labelStyle: TextStyle(color: Colors.black),
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 4.0, color: Color(0xFF8FB5FF)),
              insets: EdgeInsets.symmetric(horizontal: 20)),
          unselectedLabelColor: Color(0x4d000000),
          labelPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0)),
    );
  }

  static ThemeData calendarThemeData() => themeData().copyWith(
    accentColor: themeData().primaryColor,
  );

  static ThemeData antenatalThemeData() => themeData().copyWith(
    tabBarTheme: TabBarTheme(
        labelColor: themeData().primaryColor,
        labelStyle: TextStyle(
          fontSize: 18,
          color: themeData().primaryColor,
        ),
        indicator: UnderlineTabIndicator(
            borderSide:
            BorderSide(width: 2, color: themeData().primaryColor),
            insets: EdgeInsets.symmetric(horizontal: 10)),
        unselectedLabelColor: Color(0x4d000000),
        labelPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 30),
        unselectedLabelStyle: TextStyle(
          fontSize: 18,
        )),
  );
}