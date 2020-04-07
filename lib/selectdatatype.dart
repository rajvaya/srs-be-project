import 'package:flutter/material.dart';
import 'package:spd/data.dart';
import 'package:spd/decode/decode_img.dart';
import 'package:spd/decode/decode_text.dart';
import 'package:spd/encode/encode_img.dart';
import 'package:spd/encode/encode_text.dart';

class SelectDataType extends StatefulWidget {
  @override
  _SelectDataTypeState createState() => _SelectDataTypeState();
}

class _SelectDataTypeState extends State<SelectDataType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Data Type To ' + Operation),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
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
                        if (Operation == "Encode") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EncodeIMG()),
                          );
                        }
                        if (Operation == "Decode") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DecodeIMG()),
                          );
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Image.asset(
                            "assets/photo.png",
                            height: MediaQuery.of(context).size.height * 0.18,
                          ),
                          Text(
                            'Image',
                            style: TextStyle(
                                fontSize: 24, color: Colors.blueGrey[400]),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
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
                        if (Operation == "Encode") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EncodeTEXT()),
                          );
                        }
                        if (Operation == "Decode") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DecodeTEXT()),
                          );
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Image.asset(
                            "assets/font.png",
                            height: MediaQuery.of(context).size.height * 0.18,
                          ),
                          Text(
                            'Text',
                            style: TextStyle(
                                fontSize: 24, color: Colors.blueGrey[400]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
          ]),
    );
  }
}
