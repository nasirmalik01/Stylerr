import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylerrapp/screens/HomePageScreen.dart';
import 'package:stylerrapp/screens/LogIn.dart';
import 'package:stylerrapp/screens/signup_screens/EmailScreen.dart';
import 'package:stylerrapp/screens/signup_screens/NameScreen.dart';
import 'package:stylerrapp/screens/signup_screens/OTP_VerificationScreen.dart';
import 'package:stylerrapp/screens/signup_screens/PasswordScreen.dart';

bool isUser = false;

void main() {
  runApp(HomeScreen(isUser));
}

class HomeScreen extends StatefulWidget {
  final bool isUser;

  HomeScreen(this.isUser);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

FirebaseUser user;
String name;

class _HomeScreenState extends State<HomeScreen> {
  bool isUser = false;

  @override
  void initState() {
    super.initState();
    _initCheck();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Nubito'),
      home: WaitingScreen(isUser),
      routes: {
        EmailScreen.routeName: (context) => EmailScreen(),
        PasswordScreen.routeName: (context) => PasswordScreen(),
        NameScreen.routeName: (context) => NameScreen()
      },
    );
  }

  void _initCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isUser') != null) {
      setState(() {
        isUser = prefs.getBool('isUser');
      });
      user = await FirebaseAuth.instance.currentUser();

//      DocumentSnapshot documentSnapshot =
//      await Firestore.instance.collection('Users').document(user.uid).get();
//      String type =  documentSnapshot.data['Type'];
//      print('Type : $type');


//      DocumentSnapshot documentSnapshot =
//          await Firestore.instance.collection('Users').document(user.uid).get();
//      name =  documentSnapshot.data['Name'];
//      print(user.uid);
//      print('name : $name');
//      if(user.email != null){
//        print(documentSnapshot.data['Email']);
//      }
//      else{
//        print(documentSnapshot.data['Phone No']);
//      }
    }
  }
}

class WaitingScreen extends StatefulWidget {
  final bool isUser;

  WaitingScreen(this.isUser);

  @override
  _WaitingScreenState createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (c) => widget.isUser
                  ? HomePageScreen(
                      user: user,
                    )
                  : NameScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitThreeBounce(
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
