import 'package:flutter/material.dart';
import 'package:stylerrapp/screens/OTP_VerificationScreen.dart';

class PasswordScreen extends StatelessWidget {
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
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02),
                child: Column(
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
                      child: TextField(
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
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.33),
                child: Column(
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
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OTPVerificationScreen()));
                            },

                            child: Text(
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
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
