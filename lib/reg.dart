import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'dart:async';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';

String url = "https://showcase-mtc.eu/choose-account-app/";

class Reg extends StatefulWidget {
  @override
  RegState createState() => RegState();
}

class RegState extends State<Reg> {
  final webView = FlutterWebviewPlugin();
  TextEditingController controller = TextEditingController(text: url);
  showExitPopup() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Confirm"),
            content: Text("Do you want to exit"),
            actions: <Widget>[
              RaisedButton(
                  child: Text("No"),
                  color: Colors.white,

                  onPressed: () {
                    Navigator.of(context).pop();
                  }),

              RaisedButton(
                  child: Text("Yes"),
                  color: Colors.white,

                  onPressed: () {
                    SystemNavigator.pop();
                  })
            ],
          );
        });
  }
  @override
  void initState() {
    super.initState();

    webView.close();
    controller.addListener(() {
      url = controller.text;
    });
  }

  @override
  void dispose() {
    webView.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        showExitPopup();
      },
      child: Scaffold(
          body: WebView(
            initialUrl: "https://showcase-mtc.eu/choose-account-app/",
            javascriptMode: JavascriptMode.unrestricted,
          )
        // body: Center(
        //   child: Column(
        //     children: <Widget>[
        //       Container(
        //         padding: EdgeInsets.all(10.0),
        //         child: TextField(
        //           controller: controller,
        //         ),
        //       ),
        //       RaisedButton(
        //         onPressed: () {
        //           Navigator.of(context).pushNamed("/webview");
        //         },
        //       )
        //     ],
        //   ),
        // )
      ),
    );
  }
}