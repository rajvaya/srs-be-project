import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spd/data.dart';
import 'package:toast/toast.dart';

class ListOfEncoded extends StatefulWidget {
  @override
  _ListOfEncodedState createState() => _ListOfEncodedState();
}

class _ListOfEncodedState extends State<ListOfEncoded> {
  List<dynamic> imgs;
  bool isLoading = true;
  bool noimg = false;





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListofImgs();
  }

  getListofImgs() async {
    try {
      Response response = await Dio().post(
          "https://us-central1-spd-app-7afb5.cloudfunctions.net/gettingLinks",
          data: {
            "UID": fbuser.uid,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
      print(response.data.toString());
      if (response.data.toString().contains("No Encoded images")) {
        print("in no img");
        setState(() {
          noimg = true;
          isLoading = false;
        });
      }
      if (response.data.toString().contains("links_list")) {
        print(response.data['links_list'].runtimeType);
        imgs = response.data['links_list'];
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print(e.toString());
      getListofImgs();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Encoded Images'),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : noimg
                ? Center(
                    child: Text('NO Images Encoded please Encode'),
                  )
                : ListView.builder(
                    itemCount: imgs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 400,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: InkWell(
                              onTap: () {
                                Clipboard.setData(
                                    new ClipboardData(text: imgs[index]));
                                print(imgs[index]);
                                Toast.show("Link Copied to Clipboard", context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM);
                              },
                              child: Image.network(
                                imgs[index],
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              )),
                        ),
                      );
                    },
                  ));
  }
}
