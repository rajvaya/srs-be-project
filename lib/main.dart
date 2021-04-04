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
      title: 'SRS APP',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.indigoAccent,
        scaffoldBackgroundColor: Colors.white,
        canvasColor: Colors.blueGrey,
      ),
      home: LoginPage(),
    );
  }
}
