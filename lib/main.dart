import 'package:flutter/material.dart';
import 'package:stylerrapp/splash/SplashScreen.dart';


void main() {
  runApp(HomeScreen());
}

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }

}
