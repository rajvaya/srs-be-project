import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spd/dashboard.dart';
import 'package:spd/data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String url;
  bool isLoading = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  _signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      print("LOGGDIN AS : " + user.email.toString());
      fbuser = user;
      var response = await Dio().post(
          "https://us-central1-spd-app-7afb5.cloudfunctions.net/addUID",
          data: {"UID": fbuser.uid},
          options: Options(contentType: Headers.formUrlEncodedContentType));
      if (response.data["message"] == "User Added") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashBoard()),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chckuser();
  }

  chckuser() async {
    var user = await _auth.currentUser();
    await Future.delayed(Duration(seconds: 2));
    if (user != null) {
      setState(() {
        fbuser = user;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashBoard()),
        );
      });
    }

    if (user == null) {
      setState(() {
        //  isSignedIn = false;
        isLoading = false;
      });
    }
    // _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()))
        : Scaffold(
            body: Center(
              child: FloatingActionButton.extended(
                onPressed: _signInWithGoogle,
                label: Text('Login With Google'),
                icon: FaIcon(FontAwesomeIcons.google),
              ),
            ),
          );
  }
}
