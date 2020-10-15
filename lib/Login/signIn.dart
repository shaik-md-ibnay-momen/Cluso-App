import 'package:chuso/Registration/signUp.dart' as prefix0;
import 'package:chuso/home.dart';
import 'package:chuso/models/outputJson.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'styles.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:chuso/Registration/signUp.dart';
import 'package:chuso/LostPass/resetPass.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:progress_dialog/progress_dialog.dart';

var deviceInfo;
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);
  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>{
  ProgressDialog pr;
  bool _loading = true;
  var Dvtoken;
  final FirebaseMessaging _messaging = FirebaseMessaging();

  @override
  void initState(){
    super.initState();
    _messaging.getToken().then((token){
      print("FCM");
      print("TOKEN");
      Dvtoken = token;
      print(token);
    });

  }

  bool _isLoading =false;
  bool _isHidden = true;
  String _email, _password, _error;
  void _toggleVisibility(){
    setState(() {
      _isHidden = !_isHidden;
    });
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

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
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);

    pr.style(
        message: '  Please wait...  ',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );


    MediaQueryData deviceInfo = MediaQuery.of(context);
    print('padding: ${deviceInfo.size.width}');
    return WillPopScope(

        onWillPop: () {
      showExitPopup();
    },
       child: Scaffold(
           key: scaffoldKey,
              body: Container(

                  decoration:  BoxDecoration(
                 // image: backgroundImage,
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
                          alignment: AlignmentDirectional.bottomCenter,

                          children: <Widget>[

                            Form(
                              key: _formKey,
                              child: new Column(
                                //key: _formKey,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                children: <Widget>[
                                  SizedBox(height: 75.0),

                                Text(
                                    'Clusho',
                                    style:  TextStyle(color: Colors.black,
                                      letterSpacing: .5,
                                        fontFamily: 'Roboto',
                                      fontSize: 48,
                                        fontWeight: FontWeight.bold
                                    ),

                                  ),

                                Text(
                                  'Where passion meets club shops',
                                    style:  TextStyle(color: Colors.black,
                                    //letterSpacing: .5,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                   // fontWeight: FontWeight.bold
                                ),
                                ),
                                  SizedBox(height: 90.0),
                                ButtonTheme(
                                  minWidth: deviceInfo.size.width,
                          buttonColor: Colors.black,
                                  child: FacebookSignInButton(

                                      onPressed: () {

                                        signInFacebook();

                                    // call authentication logic
                                  }),
                                ),

                                  SizedBox(height: 20.0),
                                  buildTextField2("Username"),

                                  SizedBox(height: 10%MediaQuery.of(context).size.height,),

                                  buildTextField("Password"),
                                  SizedBox(height: 10%MediaQuery.of(context).size.height,),

                               Center(
                                 child: Padding(
                                   padding: const EdgeInsets.only(left: 19.0, right: 19.0),
                                   child: Text("\nBY CLICKING LOG IN, YOU AGREE TO OUR TERMS,DATA POLICY AND OUR COOKIES POLICY.",
                                     style:  TextStyle(color: Colors.black,
                                         //fontWeight: FontWeight.bold
                                     ),
                                     textAlign: TextAlign.center,
                                   ),
                                 ),
                               ),
                                  SizedBox(height: 30.0),


                                  ButtonTheme(
                                    height: 50,
                                      minWidth: deviceInfo.size.width-42,
                                      child: FlatButton(

                                        onPressed: () {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          if(emailController.text !="" && passwordController.text !=""){
                                            signin(emailController.text,passwordController.text);
                                          }

                                        },
                                        child: Text("Log in",
                                        style:  TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        ),
                                      ),
                                        color: Colors.black,
                                      )
                                  ),

                                  SizedBox(height: 50.0),

                                  GestureDetector(
                                    onTap: () {

                                      // call SignUp()
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => SignupScreen()));
                                    },

                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                                        child: Text("OR SIGN UP",
                                          style:  TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 50.0),

                                  GestureDetector(
                                    onTap: () {

                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => resetScreen()));
                                    },

                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                                          child: Text("LOST PASSWORD",
                                          style:  TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SignUp()
                                ],
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



  fcm( String device_token,device_type,user_id ) async{
    Map data ={
      'device_token' : device_token,
      'device_type' : device_type,
      'user_id' : user_id,
      'auth_key' : 'NpMyb0AKGKMGFdg9loyqTtTj1'
    };
    var url = 'https://showcase-mtc.eu/push/savetoken';
    var response = await http.post(url,  body: data );
    print('Response body: ${response.body}');
  }


  signInFacebook  () async{
    pr.show();
    final facebookLogin = FacebookLogin();
    facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        print(result.accessToken.token);
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,email&access_token=${token}');
        final profile = jsonDecode(graphResponse.body);
        print(profile['name']);
        print(profile['email']);
        print(profile['id']);
        
        String name=profile['name'];
        String email=profile['email'];
        String id=profile['id'];
        facebook(name,email,id,token);


        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        print(result.errorMessage);
        break;
    }
  }

  signin( String email, String password) async{
    pr.show();
    Map data ={
      'username' : email,
      'password' : password,
      'auth_key' : 'XDNpeCkJAbpRoPCT2Ncqbcj9y'
    };

    var url = 'https://showcase-mtc.eu/api/login';
    var response = await http.post(url,  body: data );
    //print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseJson = json.decode(response.body);

      var responses = OutputJson.fromJson(responseJson);
      List<Result> resultss = responses.result;
   //  print(resultss[0].id);
     print(responses.respond.toString());




     if(responses.respond.toString() == "1"){

       print("sign in");
     setState(() async {
     fcm( Dvtoken,"android",resultss[0].id );
     pr.hide();
     scaffoldKey.currentState
         .showSnackBar(new SnackBar(content: new Text("Signed in successfully")));
     await Future.delayed(const Duration(seconds: 3));
     Navigator.push(context,
         MaterialPageRoute(builder: (context) => Home()));
     });

    }

     else {
       pr.hide();
       scaffoldKey.currentState
           .showSnackBar(new SnackBar(content: new Text(responses.message.toString())));
       emailController.clear();
      passwordController.clear();
     }

    }
  }

  facebook( String name,email,id,token) async{

    Map data ={
      'username' : id,
      'socialid' : id,
      'email' : email,
      'token' : token,
      'socialtype' : 'facebook',
      'auth_key' : 'XDNpeCkJAbpRoPCT2Ncqbcj9y'
    };

    var url = 'https://showcase-mtc.eu/api/social';
    var response = await http.post(url,  body: data );
    //print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseJson = json.decode(response.body);

      var responses = OutputJson.fromJson(responseJson);
      List<Result> resultss = responses.result;
      print(resultss[0].id);
      if(responses.respond.toString() == "1"){
        print(resultss[0].id);
        setState(() {

          fcm( Dvtoken,"android",resultss[0].id );
          pr.hide();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Home()));
        });
      }
      else{

        scaffoldKey.currentState
            .showSnackBar(new SnackBar(content: new Text(responses.message.toString())));

        emailController.clear();
        passwordController.clear();

      }



    }
  }


  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  Widget buildTextField(String hintText){
    MediaQueryData deviceInfo = MediaQuery.of(context);
    return Container(
      width: deviceInfo.size.width-42,
      child: TextFormField (

        controller: passwordController ,
        validator: (input) {

          if(input.length < 6){ return 'Input your Password'; }},
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
       //   prefixIcon: hintText == "Email" ? Icon(Icons.email) : Icon(Icons.lock,color: Colors.grey),
          suffixIcon: hintText == "Password" ? IconButton(
            onPressed: _toggleVisibility,
            icon: _isHidden ? Icon(Icons.visibility_off,color: Colors.white70) : Icon(Icons.visibility,color: Colors.white70),
          ) : null,
        ),
        obscureText: hintText == "Password" ? _isHidden : false,

        onSaved: (input) => _password = input,
      ),
    );
  }


  Widget buildTextField2(String hintText){
    MediaQueryData deviceInfo = MediaQuery.of(context);
    return Container(
      width: deviceInfo.size.width-42,
      child: TextFormField(
        controller: emailController ,
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
         // prefixIcon: hintText == "Email" ? Icon(Icons.email,color: Colors.grey) : Icon(Icons.lock),
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