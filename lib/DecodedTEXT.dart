import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

import 'data.dart';

class DecodedTEXT extends StatefulWidget {
  @override
  _DecodedTEXTState createState() => _DecodedTEXTState();
}

class _DecodedTEXTState extends State<DecodedTEXT> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Secret Message"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Text(
                msg,
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.content_copy),
        onPressed: () {
          Clipboard.setData(new ClipboardData(text: msg));
          Toast.show("Message Copied to Clipboard", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        },
      ),
    );
  }
}
