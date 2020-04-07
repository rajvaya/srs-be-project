import 'package:flutter/material.dart';
import 'package:spd/loginpage.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SPD',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.white,
        canvasColor: Colors.blueGrey,
      ),
      home: LoginPage(),
    );
  }
}
