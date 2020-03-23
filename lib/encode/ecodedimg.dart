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
        title: Text(endeString),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Image.network(
                  imglink,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
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
