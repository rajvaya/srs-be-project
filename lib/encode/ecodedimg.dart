import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

import '../data.dart';

class Encoded extends StatefulWidget {
  @override
  _EncodedState createState() => _EncodedState();
}

class _EncodedState extends State<Encoded> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Encoded IMG'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Image.network(imglink),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.content_copy),
        onPressed: () {
          Clipboard.setData(new ClipboardData(text: imglink));
          Toast.show("Link Copied to Clipboard", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        },
      ),
    );
  }
}
