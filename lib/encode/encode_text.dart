import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

import '../data.dart';
import 'ecodedimg.dart';

class EncodeTEXT extends StatefulWidget {
  @override
  _EncodeTEXTState createState() => _EncodeTEXTState();
}

class _EncodeTEXTState extends State<EncodeTEXT> {
  File coverImage;
  String coverImgB64;
  TextEditingController password = TextEditingController();
  TextEditingController message = TextEditingController();

  Future getImage(String imgtype) async {
    if (imgtype == "c") {
      coverImage = await ImagePicker.pickImage(source: ImageSource.gallery);
      coverImgB64 = base64Encode(coverImage.readAsBytesSync());
      print(coverImgB64);
    }
    setState(() {});
  }

  encodeCall() async {
    print("inside get HTTPP Encode Call");
    _showDialog();
    try {
      Response response =
          await Dio().post("https://awss3uploader.herokuapp.com/encode",
              data: {
                "cover_image": coverImgB64.toString(),
                "data_to_be_encoded": message.text.toString(),
                "pwd": password.text,
                "UID": fbuser.uid
              },
              options: Options(contentType: Headers.formUrlEncodedContentType));
      print(response);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      imglink = response.data['secret_image_link'];
      endeString = "Encoded Image";
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Encoded()));
      Toast.show("Succseful", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } catch (e) {
      coverImgB64 = null;
      coverImage = null;
      password.text = null;
      message.text = null;
      Toast.show("Something went Wrong Please Try Again", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Navigator.of(context).pop();
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('Encode Text'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: coverImage == null
                    ? FloatingActionButton.extended(
                        heroTag: 10,
                        onPressed: () {
                          getImage("c");
                        },
                        label: Text('Cover Image'),
                        icon: Icon(Icons.image),
                      )
                    : Image.file(coverImage),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  obscureText: false,
                  maxLines: 10,
                  minLines: 1,
                  cursorColor: Colors.blueGrey,
                  decoration: InputDecoration(
                    hintText: "Your Message",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  controller: message,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                obscureText: true,
                cursorColor: Colors.blueGrey,
                decoration: InputDecoration(
                  hintText: "Your Secret Key",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                controller: password,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: showFab
          ? FloatingActionButton.extended(
              heroTag: 4,
              onPressed: () {
                if (coverImage != null &&
                    password.text.isNotEmpty &&
                    message.text.isNotEmpty) {
                  print("ok");
                  encodeCall();
                } else {
                  Toast.show("Complete All The Inputs", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                }
              },
              label: Text('Enocde Text'),
              icon: Icon(Icons.lock_outline),
            )
          : null,
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Please Wait while we Encode Your Text",
            textAlign: TextAlign.center,
          ),
          content: Wrap(
            children: <Widget>[
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          ),
        );
      },
    );
  }
}
