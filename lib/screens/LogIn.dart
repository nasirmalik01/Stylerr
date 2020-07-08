import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylerrapp/main.dart';
import 'package:stylerrapp/screens/signup_screens/NameScreen.dart';

class LoginScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("LogIn Screen"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app
            ),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('isUser');
              Route route = MaterialPageRoute(builder: (context) => NameScreen());
              Navigator.push(context, route);
            },
          )
        ],
      ),
      body: Container(
        child: Center(
          child: Text("LogIn Screen",
          style: TextStyle(
            fontSize: 30.0
          ),),
        ),
      ),
    );
  }

}