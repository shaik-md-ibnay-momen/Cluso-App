import 'package:chuso/models/outputJson.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'styles.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:chuso/Login/signIn.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

var deviceInfo;
class resetScreen extends StatefulWidget {
  const resetScreen({Key key}) : super(key: key);
  @override
  resetScreenState createState() => new resetScreenState();
}

class resetScreenState extends State<resetScreen>{
  bool _isHidden = true;
  String _email, _password, _error;
  var tcVisibility = false;
  var tcText = "";

  TextEditingController emailController = new TextEditingController();

  void _toggleVisibility(){
    setState(() {
      _isHidden = !_isHidden;
    });
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();


  reset( String email) async{
    Map data;
    if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)){
       data ={

        'email' : email,
        'auth_key' : 'XDNpeCkJAbpRoPCT2Ncqbcj9y'
      };
    }
    else{
       data ={
        'username' : email,
        'auth_key' : 'XDNpeCkJAbpRoPCT2Ncqbcj9y'
      };
    }

    var jsonData = null;
    var url = 'https://showcase-mtc.eu/api/lostpwd';
    var response = await http.post(url,  body: data );
    //print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseJson = json.decode(response.body);

      var responses = OutputJson.fromJson(responseJson);

      print(responses.respond);
      if(responses.respond.toString() == "1"){

        scaffoldKey.currentState
            .showSnackBar(new SnackBar(content: new Text(responses.message.toString())));
//        setState(() {
//          tcVisibility = true;
//          tcText = responses.message.toString();
//
//        });
      }
      else{
//        setState(() {
//          tcVisibility = true;
//          tcText = responses.message.toString();
//        });

        scaffoldKey.currentState
            .showSnackBar(new SnackBar(content: new Text(responses.message.toString())));
      }



    }
  }


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
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    print('padding: ${deviceInfo.size.width}');
    double a=deviceInfo.size.width-42;
    return WillPopScope(

        onWillPop: () {
          showExitPopup();
        },
        child: Scaffold(
            key: scaffoldKey,
            body: Container(

                decoration:  BoxDecoration(
                  //image: backgroundImage,

                  gradient: new LinearGradient(
                    colors: [
                      /*  const Color.fromRGBO(162, 146, 199, 0.8),
                        const Color.fromRGBO(51, 51, 63, 0.9),*/
                      // Colors.transparent,
                      const Color(0xffffffff),
                      const Color(0xfff1f1f1),
                      const Color(0xfff1f1f1),
                      const Color(0xffffffff),
                      const Color(0xffffffff),
                      const Color(0xfff1f1f1),
                      const Color(0xfff1f1f1),
                      const Color(0xffffffff),
                      const Color(0xffffffff),
                      const Color(0xfff1f1f1),
                      const Color(0xfff1f1f1),
                      const Color(0xffffffff),
                      const Color(0xffffffff),
                    ],
                    stops: [0.25, 0.25,0.2570,0.2570,0.50,0.50,0.5070,0.5070,0.75,0.75,0.7570,0.7570,1.0],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),

                child: Container(

                  child: new ListView(
                    padding: const EdgeInsets.all(0.0),
                    children: <Widget>[
                      // showAlert(),
                      new Stack(
                       // alignment: AlignmentDirectional.bottomCenter,

                        children: <Widget>[

                          Padding(
                            padding: const EdgeInsets.only(top: 48.0),
                            child: GestureDetector(
                              onTap: () {
                                // call SignUp()
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => LoginScreen()));
                              },


                                child: Padding(
                                  padding: const EdgeInsets.only(left: 21.0, right: 18.0),
                                  child: Text("< back",
                                    style:  TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 88.0,left: 21),
                            child: Text("Forgate Password?",
                              style:  TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 36,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(21.0),
                            child: Form(
                              key: _formKey,
                              child: new Column(
                                //key: _formKey,
                               // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                children: <Widget>[
                                  SizedBox(height: 145.0),


                                  SizedBox(height: 75.0),
                                  ButtonTheme(
                                      height: 50,
                                      minWidth: deviceInfo.size.width-21,
                                      child: Visibility(
                                        visible: tcVisibility,
                                        child: FlatButton(

                                          onPressed: () {
                                            // call reset logic
                                          },

                                            child: Text(tcText,
                                              style:  TextStyle(
                                                  color: Colors.black,

                                                  fontSize: 12
                                              ),
                                            ),

                                          color: Colors.greenAccent,
                                        ),
                                      )
                                  ),

                                  SizedBox(height: 75,),

                                  buildTextField2("Enter username or email"),


                                  SizedBox(height: 10%MediaQuery.of(context).size.height,),




                                  ButtonTheme(
                                      height: 50,
                                      minWidth: deviceInfo.size.width-42,
                                      child: FlatButton(

                                        onPressed: () {
                                          reset(emailController.text);
                                          // call authentication logic
                                        },
                                        child: Text("Reset my password",
                                          style:  TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16
                                          ),
                                        ),
                                        color: Colors.black,
                                      )
                                  ),

                                  SizedBox(height: 70.0),
                                  Text("Clusho",
                                    style:  TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 36,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                  // SignUp()
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                )


            )
        )
    );

  }

  Widget buildTextField2(String hintText){
    MediaQueryData deviceInfo = MediaQuery.of(context);
    return Container(
      width: deviceInfo.size.width-42,
      child: TextFormField(
        controller: emailController,
        validator: (input) {
          if(input.isEmpty){
            //  animationStatus = 0;
            return 'Input your email';
          }
        },

        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),

          ),
        //  prefixIcon: hintText == "Email" ? Icon(Icons.email,color: Colors.grey) : Icon(Icons.lock),
          suffixIcon: hintText == "Password" ? IconButton(
            onPressed: _toggleVisibility,
            icon: _isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
          ) : null,
        ),
        obscureText: hintText == "Password" ? _isHidden : false,

        onSaved: (input) => _email = input,
      ),
    );
  }


}