import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stylerrapp/screens/signup_screens/EmailScreen.dart';

class NameScreen extends StatefulWidget {

  static const routeName = 'NameScreen';
  @override
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  String name = '';

  //var userCollection = Firestore.instance.collection('Users');
  bool isLoading = false;
  final _formNameKey = GlobalKey<FormState>();

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

  Future<void> moveNameToNextScreen() async {
    final isValid = _formNameKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formNameKey.currentState.save();
    setState(() {
      isLoading = true;
    });

    Future.delayed(Duration(milliseconds: 1500)).then((value) {
      setState(() {
        isLoading = false;
      });
      Navigator.pushNamed(context, EmailScreen.routeName, arguments: name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _formNameKey,
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
                            title: 'What\'s your name ?')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                    child: TextValues(
                        title:
                            'Your name helps your stylist / barber to confirm who have booked with them',
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Name can\'t be empty';
                        }
                        return null;
                      },
                      onSaved: (_) {},
                      decoration: InputDecoration(
                        hintText: 'Enter your full name',
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
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: TextValues(
                        title: 'By signing up with Stylerr, you agree to our',
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                  Center(
                    child: TextValues(
                        title: 'terms and conditions',
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.blue),
                  ),
                  SizedBox(
                    height: 22,
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
                          onPressed: isLoading ? null : moveNameToNextScreen,
                          child: isLoading
                              ? SpinKitFadingCircle(
                                  color: Colors.white,
                                  size: 50.0,
                                )
                              : Text(
                                  'Create Account',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Nunito',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
