import 'package:chuso/home.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:chuso/Login/signIn.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EEE',
      home: new MyHomePage(title: 'Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AppBar appBar;
  bool accepted = false;

  @override
  @override
  Widget build(BuildContext context) {
    //appBar = getAppBar();

    return Scaffold(
      //  appBar: appBar,

        body: Stack(children: <Widget>[
          LoginScreen(),
        ]));
  }


  getAppBar() {
    return AppBar(
      title: Text(widget.title),
    );
  }
}
