import 'package:flutter/material.dart';
//import 'package:stylerrapp/my_flutter_app_icons.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;


class LoginMethodsScreen extends StatefulWidget
{
  @override
  _LoginMethodsScreenState createState() => _LoginMethodsScreenState();
}

class _LoginMethodsScreenState extends State<LoginMethodsScreen> {
  bool _isloggedIn=false;
  Map userProfile;
  final facebookLogIn=FacebookLogin();

  void loginWithFB() async{
    final result = await facebookLogIn.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          userProfile = profile;
          _isloggedIn = true;
        });
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => _isloggedIn = false );
        break;
      case FacebookLoginStatus.error:
        setState(() => _isloggedIn = false );
        break;
    }

  }

  _logout(){
    facebookLogIn.logOut();
    setState(() {
      _isloggedIn = false;
    });
  }

  //Image store on firebase
//  _imageStore(){
//    userProfile=Image.network(
//      userProfile["picture"]["data"]["url"],
//      height: 50.0,
//      width: 40.0,
//    ) as Map;
//    var name=userProfile["username"];
//    Firestore.instance.collection('Users').document().setData({
//      'Name':name,
//      'Profile Image':userProfile
//    });  }
//

  @override
  Widget build(BuildContext context) {

    double _width=MediaQuery.of(context).size.width;
    double _height=MediaQuery.of(context).size.height;

    Text _logInText(String text, Color color, FontWeight font,double size){
      return Text(
        '$text',
        style: TextStyle(
            color: color,
            fontWeight: font,
            fontSize: size
        ),
      );
    }


    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: _width,
        height: _height,
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: _height*0.1,
              ),
              _logInText('Stylerr',Colors.pink,FontWeight.w500,46.0),
              _logInText('Salons Booking made easy', Colors.black, FontWeight.w100, 12.0),
              SizedBox(
                height: _height*0.01,
              ),
              Container(
                height: _height*0.35,
                width: _width*0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage('assets/login.png'),
                    fit: BoxFit.fitHeight,
                  ),

                ),

              ),

              SizedBox(
                height: _height*0.1,
              ),
              RaisedButton(
                color: Color.fromRGBO(42, 180,255,1.0),
                child: Text(
                  'Continue with mobile number',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                onPressed: () {
                },

              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        thickness: 0.2,
                        color: Colors.black54,
                        indent: 20.0,
                        endIndent: 20.0,
                      ),
                    ),
                    Text('OR',
                      style: TextStyle(
                          color: Colors.black54
                      ),),
                    Expanded(
                      child: Divider(
                        thickness: 0.2,
                        color: Colors.black54,
                        indent: 20.0,
                        endIndent: 20.0,
                      ),
                    )
                  ],
                ),

              ),
              Padding(
                padding: EdgeInsets.only(bottom: 50.0),
                child: RaisedButton.icon(
                  icon: Icon(Icons.filter_b_and_w, size: 15.0,color: Colors.white),
                  color: Color.fromRGBO(38, 144,218,1.0),
                  splashColor: Colors.blue,
                  // icon: Icon(IconData(0xe900, fontFamily: 'ic_facebook')),
                  label: Text(
                    'LogIn with facebook',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  onPressed: loginWithFB,

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
