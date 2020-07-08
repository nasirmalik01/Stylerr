import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylerrapp/screens/HomePageScreen.dart';

class PasswordScreen extends StatefulWidget {
  static const routeName = 'PasswordScreen';

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

final _scaffoldPasswordKey = GlobalKey<ScaffoldState>();

class _PasswordScreenState extends State<PasswordScreen> {
  String password = '';
  bool isLoading = false;
  final _formPasswordKey = GlobalKey<FormState>();
  String name;
  var email;

  @override
  void didChangeDependencies() {
    final userData =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    name = userData['Name'];
    email = userData['Email'];
    super.didChangeDependencies();
  }

  Future<void> registerUser() async {
    final isValid = _formPasswordKey.currentState.validate();
    if (!isValid) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    _formPasswordKey.currentState.save();

    try {
      final newUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (newUser != null) {
        print('User registered successfully');
//        Navigator.push(
//            context,
//            MaterialPageRoute(
//                builder: (context) => ChatScreen()));
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });

      if (e.message ==
          'The given password is invalid. [ Password should be at least 6 characters ]')
        _scaffoldPasswordKey.currentState.hideCurrentSnackBar();
      _scaffoldPasswordKey.currentState.showSnackBar(SnackBar(
        content: Text(
          e.message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF323232),
      ));

      if (e.message ==
          'A network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
        _scaffoldPasswordKey.currentState.hideCurrentSnackBar();
        SnackbarError(errorMessage: 'Connection Timeout. Try Again');
      }

      if (e.message == 'The email address is badly formatted.') {
        _scaffoldPasswordKey.currentState.hideCurrentSnackBar();
        SnackbarError(errorMessage: 'Email Address is bady formatted');
      }

      if (e.message ==
          'The email address is already in use by another account.') {
        _scaffoldPasswordKey.currentState.hideCurrentSnackBar();
        SnackbarError(
            errorMessage:
                'The Email Address is already in use by another account');
      }
      return;
    }

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print('UID : ${user.uid}');

//    await Firestore.instance
//        .collection('Users')
//        .document(user.uid)
//        .setData({'Name': name, 'Email': user.email, 'Password': password});

    setState(() {
      isLoading = false;
    });

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isUser', true);
    print(prefs.getBool('isUser'));

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomePageScreen(
                user: user, nameValue: name)));


  }

  Text TextValues(
      {String title, double fontSize, Color color, FontWeight fontWeight}) {
    return Text(
      title,
      style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontFamily: 'Nunito',
          fontWeight: fontWeight),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldPasswordKey,
      body: Form(
        key: _formPasswordKey,
        child: Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.05,
              bottom: MediaQuery.of(context).size.height * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Color(0xFF2AB4FF),
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02),
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 15, top: 15, bottom: 10),
                        child: TextValues(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            title: 'Create a strong password ?')),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Password  can\'t be empty';
                        }

                        if (!RegExp(
                                r'^(?=.*[A-Z])(?=.*[a-z])(?=.*?[0-9]).{8,}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid password';
                        }

                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Nubito',
                          color: Colors.grey,
                        ),
                      ),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Nunito'),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Color(0xFFF0EFEF),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 10, right: 10),
                            child: TextValues(
                                title:
                                    'For security your password needs to be atleast 8 characters.',
                                fontWeight: FontWeight.normal,
                                fontSize: 13,
                                color: Colors.black),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5.0, left: 10, right: 10),
                            child: TextValues(
                                title: 'consisting of:',
                                fontWeight: FontWeight.normal,
                                fontSize: 13,
                                color: Colors.black),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5.0, left: 10, right: 10),
                            child: TextValues(
                                title: 'upper and lower case letters',
                                fontWeight: FontWeight.normal,
                                fontSize: 13,
                                color: Colors.black),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5.0, left: 10, right: 10, bottom: 10),
                            child: TextValues(
                                title: 'numbers',
                                fontWeight: FontWeight.normal,
                                fontSize: 13,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: TextValues(
                        title: 'Have an invitation Code?',
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.032,
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 25,
                            spreadRadius: 0.5,
                            offset: Offset(0, 2))
                      ]),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF2690DA), Color(0xFF2AB4FF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: MaterialButton(
                          onPressed: isLoading ? null :  registerUser,
                          child: isLoading
                              ? SpinKitFadingCircle(
                                  color: Colors.white,
                                  size: 50.0,
                                )
                              : Text(
                                  'Continue',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Nunito',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

void SnackbarError({String errorMessage}) {
  _scaffoldPasswordKey.currentState.showSnackBar(SnackBar(
    content: Text(
      errorMessage,
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Color(0xFF323232),
  ));
}
