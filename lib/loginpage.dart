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
    isLoading = true;
    setState(() {});
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
      isLoading = false;
      print(e);
      setState(() {});
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
    await Future.delayed(Duration(seconds: 3));
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/avatar.png",
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'SPD',
              style: TextStyle(
                  color: Colors.blueGrey[600],
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          !isLoading
              ? Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: FloatingActionButton.extended(
                      onPressed: _signInWithGoogle,
                      label: Text(' Login With Google'),
                      icon: FaIcon(FontAwesomeIcons.google),
                    ),
                  ),
                )
              : Container(
                  color: Colors.white,
                  child: Center(child: CircularProgressIndicator())),
        ],
      ),
    );
  }
}
