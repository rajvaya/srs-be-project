import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spd/data.dart';
import 'package:spd/loginpage.dart';
import 'package:spd/selectdatatype.dart';

import 'listofencoded.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SPD Dashboard'),
        centerTitle: true,
        actions: <Widget>[
          Center(
            child: Semantics(
              label: "Log Out",
              child: IconButton(
                enableFeedback: true,
                icon: FaIcon(
                  FontAwesomeIcons.signOutAlt,
                  color: Colors.white,
                ),
                onPressed: () async {
                  fbuser = null;
                  await _auth.signOut();
                  await _googleSignIn.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      child: ClipOval(
                          child: Image.network(
                        fbuser.photoUrl,
                      )),
                      radius: 25,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      greeting() +
                          ' ' +
                          fbuser.displayName[0].toUpperCase() +
                          fbuser.displayName.substring(1),
                      style: TextStyle(
                          color: Colors.blueGrey[600],
                          fontSize: 24,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Card(
                    elevation: 10,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        Operation = "Encode";
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectDataType()),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Image.asset(
                            "assets/padlock.png",
                            height: MediaQuery.of(context).size.height * 0.15,
                          ),
                          Text(
                            'Encode',
                            style: TextStyle(
                                fontSize: 24, color: Colors.blueGrey[400]),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Card(
                    elevation: 10,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        Operation = "Decode";
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectDataType()),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Image.asset(
                            "assets/open-padlock.png",
                            height: MediaQuery.of(context).size.height * 0.15,
                          ),
                          Text(
                            'Decode',
                            style: TextStyle(
                                fontSize: 24, color: Colors.blueGrey[400]),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Card(
                    elevation: 10,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListOfEncoded()),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Image.asset(
                            "assets/photos.png",
                            height: MediaQuery.of(context).size.height * 0.15,
                          ),
                          Text(
                            'Encoded Images',
                            style: TextStyle(
                                fontSize: 24, color: Colors.blueGrey[400]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
