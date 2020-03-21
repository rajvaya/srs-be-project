import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spd/data.dart';
import 'package:spd/decode/decode_img.dart';
import 'package:spd/encode/encode_img.dart';
import 'package:spd/loginpage.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: FloatingActionButton.extended(
              heroTag: 1,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EncodeIMG()),
                );
              },
              label: Text('Encode Image'),
              icon: Icon(Icons.add_a_photo),
            ),
          ),
          Center(
            child: FloatingActionButton.extended(
              heroTag: 6,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DecodeIMG()),
                );
              },
              label: Text('Decode Image'),
              icon: Icon(Icons.add_a_photo),
            ),
          ),
          Center(
            child: FloatingActionButton.extended(
              heroTag: 7,
              onPressed: () async {
                fbuser = null;
                await _auth.signOut();
                await _googleSignIn.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              label: Text('LOG OUT'),
              icon: Icon(Icons.add_a_photo),
            ),
          ),
        ],
      ),
    );
  }
}
