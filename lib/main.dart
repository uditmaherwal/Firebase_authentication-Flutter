import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'SigninPage.dart';
import 'SignupPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.black),
      ),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        '/SignupPage': (BuildContext context) => SignupPage(),
        '/SigninPage': (BuildContext context) => SigninPage(),
      },
    );
  }
}
