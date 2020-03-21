import 'package:flutter/material.dart';
import 'package:spd/data.dart';

class IMG extends StatefulWidget {
  @override
  _IMGState createState() => _IMGState();
}

class _IMGState extends State<IMG> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.memory(imgfromres),
    );
  }
}
