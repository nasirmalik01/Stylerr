import 'package:flutter/material.dart';
import 'package:stylerrapp/screens/PasswordScreen.dart';
import 'package:stylerrapp/widgets/OTPVerificationWidgets.dart';

class OTPVerificationScreen extends StatelessWidget {
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
                              title: 'Enter your code')),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                        child: Row(
                          children: <Widget>[
                            TextValues(
                                title:
                                    'We\'ve sent a 4-digit code to +923340803550',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: TextValues(
                                  title: 'Edit Number',
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFF2AB4FF)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 60),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            OTPCodes(context),
                            OTPCodes(context),
                            OTPCodes(context),
                            OTPCodes(context),
                          ],
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                    ),
                    Center(
                      child: TextValues(
                          title: 'Resend Code 00:30',
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.37),
                  child: Center(
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
                          onPressed: () {},

                          child: Text(
                            'Verify',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Nunito',
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
