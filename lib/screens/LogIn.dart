import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("LogIn Screen"),
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