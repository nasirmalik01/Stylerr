import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylerrapp/main.dart';
import 'package:stylerrapp/screens/HomePageScreen.dart';

class MobileNumberScreen extends StatefulWidget {
  final String name;

  MobileNumberScreen(this.name);

  @override
  _MobileNumberScreenState createState() => _MobileNumberScreenState();
}

final _scaffoldMobileKey = GlobalKey<ScaffoldState>();

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  bool isLoading = false;
  final _formMobileKey = GlobalKey<FormState>();

  Future<bool> loginUser(String phone, BuildContext context) async {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;

      _auth.verifyPhoneNumber(
          phoneNumber: phone,
          timeout: Duration(seconds: 60),
          verificationCompleted: (AuthCredential credential) async {
            Navigator.of(context).pop();

            AuthResult result = await _auth.signInWithCredential(credential);

            FirebaseUser user = result.user;

            if (user != null) {
              print('1');
//              await Firestore.instance.collection('Users').document(user.uid).setData({
//                'Name': widget.name, 'Phone No': user.phoneNumber
//              });
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('isUser', true);
              print(prefs.getBool('isUser'));

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePageScreen(
                            user: user,
                            nameValue: widget.name,
                          )));
            } else {
              print("2 Error");
            }

            //This callback would gets called when verification is done automatically
          },
          verificationFailed: (AuthException exception) {
            setState(() {
              isLoading = false;
            });
            _scaffoldMobileKey.currentState.hideCurrentSnackBar();
            SnackbarError(
                errorMessage: 'You are Temporarily blocked, try again later');
            print(exception);
          },
          codeSent: (String verificationId, [int forceResendingToken]) {
            setState(() {
              isLoading = false;
            });
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Form(
                    key: _formMobileKey,
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom:
                              MediaQuery.of(context).viewInsets.bottom * 0.1),
                      child: SingleChildScrollView(
                        child: Card(
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 10,
                              left: 10,
                              right: 10,
                              bottom:
                                  MediaQuery.of(context).viewInsets.bottom + 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0,
                                      right: 15,
                                      top: 15,
                                      bottom: 10),
                                  child: TextValues(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      title: 'Enter your code'),
                                ),
                                TextValues(
                                    title:
                                        'We\'ve sent a 6-digit code to +92${_phoneController.text.trim()}',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.045,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.2),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Code can\'t be empty';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {},
                                    controller: _codeController,
                                    maxLength: 6,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      labelText: 'Verification Code',
                                      hintText: 'Enter Verification Code',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7.0)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF0EDC62),
                                            width: 2.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7.0)),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.05),
                                    child: Center(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
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
                                              colors: [
                                                Color(0xFF2690DA),
                                                Color(0xFF2AB4FF)
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          child: MaterialButton(
                                            onPressed: isLoading
                                                ? null
                                                : () async {
                                                    final isValid =
                                                        _formMobileKey
                                                            .currentState
                                                            .validate();
                                                    if (!isValid) {
                                                      return;
                                                    }
                                                    final code = _codeController
                                                        .text
                                                        .trim();
                                                    setState(() {
                                                      isLoading = true;
                                                    });
                                                    AuthResult result;
                                                    FirebaseUser user;
                                                    try {
                                                      AuthCredential
                                                          credential =
                                                          PhoneAuthProvider
                                                              .getCredential(
                                                                  verificationId:
                                                                      verificationId,
                                                                  smsCode:
                                                                      code);

                                                      result = await _auth
                                                          .signInWithCredential(
                                                              credential);
                                                      user = result.user;
                                                      print(
                                                          'NO : ${user.phoneNumber}');
                                                    } catch (e) {
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                      _scaffoldMobileKey
                                                          .currentState
                                                          .hideCurrentSnackBar();
                                                      SnackbarError(
                                                          errorMessage:
                                                              'You entered Inorrect Verification Code');
                                                    }

                                                    if (user != null) {
                                                      print('3');
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        isLoading = false;
                                                      });

                                                      final prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      prefs.setBool(
                                                          'isUser', true);
                                                      print(prefs
                                                          .getBool('isUser'));

                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomePageScreen(
                                                            user: user,
                                                            nameValue:
                                                                widget.name,
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      print("4 Error");
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                    }
                                                  },
                                            child: isLoading
                                                ? SpinKitFadingCircle(
                                                    color: Colors.white,
                                                    size: 50.0,
                                                  )
                                                : Text(
                                                    'Verify',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Nunito',
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    )),
                                Container(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
          codeAutoRetrievalTimeout: null);
    } catch (e) {
      Scaffold.of(context).hideCurrentSnackBar();
      SnackbarError(errorMessage: 'Error occurred : Try Again Later');
      print(e);
    }
  }

  loginOtherDeviceUser() {}

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
      key: _scaffoldMobileKey,
      body: Container(
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
                          title: 'Enter your mobile number')),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                  child: TextValues(
                      title:
                          'Enter your mobile number, to create an account or log in',
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 40.0, right: 40, top: 20),
                  child: TextFormField(
                    controller: _phoneController,
//                      validator: (value){
//                        if(value.isEmpty){
//                          return 'Please enter your Phone Number';
//                        }
//                        return null;
//                      },
                    maxLength: 10,
                    decoration: InputDecoration(
                      hintText: '334 080 3550',
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
//                        prefixIcon: Icon(Icons.format_list_numbered),
                      prefixText: '+92    ',
                      prefixStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Nunito'),
                    keyboardType: TextInputType.number,
                    autofocus: true,
                  ),
                ),
              ],
            ),
            Container(
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
                  onPressed: isLoading
                      ? null
                      : () {
                          setState(() {
                            isLoading = true;
                          });
                          final phone = '+92${_phoneController.text.trim()}';
                          print(phone);
                          loginUser(phone, context);
                        },
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
          ],
        ),
      ),
    );
  }
}

void SnackbarError({String errorMessage}) {
  _scaffoldMobileKey.currentState.showSnackBar(SnackBar(
    content: Text(
      errorMessage,
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Color(0xFF323232),
  ));
}
