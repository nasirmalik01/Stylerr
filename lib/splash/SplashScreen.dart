import 'package:flutter/material.dart';
import 'package:stylerrapp/screens/Categories.dart';
import 'package:stylerrapp/screens/LogIn.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {


  @override
  _SplashScreenState createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {


  Text _text(String text,Color color,FontWeight font,double size ){
    return Text("$text",
      style: TextStyle(
          color: color,
          fontWeight: font,
          fontSize: size,
      ),);
  }

  Future<bool> _future() async{
    await Future.delayed(Duration(milliseconds: 5000));
    return false;
  }

  void _navigateToScreen(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => CategoriesScreen())
    );
  }

  void _navigateToLogIn(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => LoginScreen())
    );
  }

  Text _text1(String text, Color color, FontWeight font,double size){
    return Text(
      '$text',
      style: TextStyle(
        color: color,
        fontWeight: font,
        fontSize: size
      ),
    );
  }

  @override
  void initState() {
    super.initState();
       _future().then(
           (value) {
             if (value) {
               _navigateToLogIn();
             } else {
               _navigateToScreen();
             }
           });
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Color(529953),
        body: Container(
          child:Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 200.0,
                ),
                 _text1('Stylerr',Colors.pink,FontWeight.w900,48.0),
              //2nd Text
                _text1('Salon Bookings Made Easy',Colors.white,FontWeight.w100,12.0),
                SizedBox(
                  height: 170.0,
                ),
                _text(
                    'Loading...',
                    Colors.white,
                    FontWeight.w100,
                    24.0),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left:20.0,right:25.0),
                    child: LinearProgressIndicator(value: 0.5,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue))),

                 ],
            ),
          )
          ),
        );
  }
}
