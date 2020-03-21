import 'package:flutter/material.dart';
import 'package:save_in_gallery/save_in_gallery.dart';

import '../data.dart';

class Encoded extends StatefulWidget {
  @override
  _EncodedState createState() => _EncodedState();
}

class _EncodedState extends State<Encoded> {
  final _imageSaver = ImageSaver();
  saveIMG() async {
    final res = await _imageSaver.saveImage(
      imageBytes: imgfromres,
      directoryName: "SPD",
    );
    print(res.toString());
  }

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
            child: Image.memory(imgfromres),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.file_download),
        onPressed: () {
          saveIMG();
        },
      ),
    );
  }
}
