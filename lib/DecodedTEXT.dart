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
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Text(msg),
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
