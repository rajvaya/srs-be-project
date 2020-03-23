import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spd/data.dart';
import 'package:spd/encode/ecodedimg.dart';
import 'package:toast/toast.dart';

class EncodeIMG extends StatefulWidget {
  @override
  _EncodeIMGState createState() => _EncodeIMGState();
}

class _EncodeIMGState extends State<EncodeIMG> {
  File coverImage;
  File secretImage;
  String secretImgB64;
  String coverImgB64;
  TextEditingController password = TextEditingController();

  Future getImage(String imgtype) async {
    if (imgtype == "s") {
      secretImage = await ImagePicker.pickImage(source: ImageSource.gallery);
      secretImgB64 = base64Encode(secretImage.readAsBytesSync());
      print(secretImgB64);
    }
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
                "data_to_be_encoded": secretImgB64.toString(),
                "pwd": password.text,
                "UID": fbuser.uid
              },
              options: Options(contentType: Headers.formUrlEncodedContentType));
      print(response);
      Navigator.of(context).pop();
      imglink = response.data['secret_image_link'];
      endeString = "Encoded Image";
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Encoded()));
      Toast.show("Succsefull", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } catch (e) {
      coverImgB64 = null;
      coverImage = null;
      secretImgB64 = null;
      secretImgB64 = null;
      password.text = null;
      Toast.show("Something went Wrong Opps Please Try Again", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Navigator.of(context).pop();

      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Encode IMG'),
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
                        heroTag: 2,
                        onPressed: () {
                          getImage("c");
                        },
                        label: Text('cover img'),
                        icon: Icon(Icons.account_circle),
                      )
                    : Image.file(coverImage),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: secretImage == null
                    ? FloatingActionButton.extended(
                        heroTag: 3,
                        onPressed: () {
                          getImage("s");
                        },
                        label: Text('Secret Img'),
                        icon: Icon(Icons.account_circle),
                      )
                    : Image.file(secretImage),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                obscureText: true,
                cursorColor: Colors.teal,
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
            Container(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 4,
        onPressed: () {
          if (coverImage != null &&
              secretImage != null &&
              password.text.isNotEmpty) {
            print("ok");
            encodeCall();
          } else {
            print("COMPLETE ALL DATA");
            Toast.show("Complete all the Inputs", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          }
        },
        label: Text('Enocde'),
        icon: Icon(Icons.account_circle),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Please Wait while we encode your data"),
          content: Wrap(
            children: <Widget>[
              Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Colors.blue[300],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
