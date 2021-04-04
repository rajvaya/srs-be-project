import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spd/encode/ecodedimg.dart';
import 'package:toast/toast.dart';

import '../data.dart';

class DecodeIMG extends StatefulWidget {
  @override
  _DecodeIMGState createState() => _DecodeIMGState();
}

class _DecodeIMGState extends State<DecodeIMG> {
  // ignore: non_constant_identifier_names
  File ImageFile;
  // ignore: non_constant_identifier_names
  String ImgB64;
  TextEditingController password = TextEditingController();

  Future getImage() async {
    ImageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    ImgB64 = base64Encode(ImageFile.readAsBytesSync());
    print(ImgB64);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Decode Image'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: ImageFile == null
                    ? FloatingActionButton.extended(
                        heroTag: 2,
                        onPressed: () {
                          getImage();
                        },
                        label: Text('Select Image'),
                        icon: Icon(Icons.image),
                      )
                    : Image.file(ImageFile),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.02,
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
                if (ImageFile != null && password.text.isNotEmpty) {
                  print("ok");
                  decodeCall();
                } else {
                  Toast.show("Complete All The Inputs", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                }
              },
              label: Text('Decode Image'),
              icon: Icon(Icons.lock_open),
            )
          : null,
    );
  }

  decodeCall() async {
    print("inside get HTTPP Encode Call");
    _showDialog();
    try {
      Response response =
          await Dio().post("https://srs-flask-backend.herokuapp.com/decodeImage",
              data: {
                "secret_image": ImgB64.toString(),
                "pwd": password.text,
              },
              options: Options(contentType: Headers.formUrlEncodedContentType));
      print(response.data.toString());
      if (response.data.toString().contains("link")) {
        print(" in LINK ");
        imglink = response.data['link'];
        endeString = "Decoded Image";
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Encoded()),
        );
        Toast.show("Succseful", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }

      if (response.data.toString().contains("message")) {
        Navigator.of(context).pop();
        Toast.show(response.data["message"], context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    } catch (e) {
      Toast.show("Something went Wrong Opps Please Try Again", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Navigator.of(context).pop();
      print(e);
    }
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
            "Please Wait while We Decode your Image",
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
