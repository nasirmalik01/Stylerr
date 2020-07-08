import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stylerrapp/widgets/OTPVerificationWidgets.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String phoneNo;

  static const routeName = 'OTPVerificationScreen';

  OTPVerificationScreen([this.phoneNo]);

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  String smsSent, verificationId;

  @override
  Future<void> didChangeDependencies() async {
    verifyPhone();
    super.didChangeDependencies();
  }

  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      if (smsSent == null) {
        return;
      }
      FirebaseAuth.instance.currentUser().then((user) {
        if (user != null) {
          print('Registered');
        } else {
          signIn(smsSent);
        }
      });
    };
    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {};
    final PhoneVerificationFailed verifyFailed = (AuthException e) {
      print('${e.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phoneNo,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }

//
//  Future<bool> smsCodeDialoge(BuildContext context){
//    return showDialog(context: context,
//      barrierDismissible: false,
//      builder: (BuildContext context) {
//        return new AlertDialog(
//          title: Text('Provide OTP'),
//          content: TextField(
//            onChanged: (value)  {
//              this.smssent  = value;
//            },
//          ),
//          contentPadding: EdgeInsets.all(10.0),
//          actions: <Widget>[
//            new FlatButton(
//                onPressed: (){
//                  FirebaseAuth.instance.currentUser().then((user){
//                    if(user != null){
//                      print('Registered');
//                    }
//                    else{
//                      Navigator.of(context).pop();
//                      signIn(smssent);
//                    }
//
//                  }
//                  );
//                },
//                child: Text('Done', style: TextStyle( color: Colors.blue),))
//          ],
//        );
//      },
//    );
//  }
//
//
  Future<void> signIn(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await FirebaseAuth.instance.signInWithCredential(credential)
        .then((user){
      Navigator.of(context).pushReplacementNamed('/loginpage');
    }).catchError((e){
      print(e);
    });
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
    print(widget.phoneNo);
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
                      padding:
                          const EdgeInsets.only(left: 40.0, right: 40, top: 20),
                      child: TextField(
                        onChanged: (value) {
                          smsSent = value;
                        },
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
//                    Padding(
//                        padding: const EdgeInsets.only(
//                            left: 20.0, right: 20, top: 60),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceAround,
//                          children: <Widget>[
//                            OTPCodes(context),
//                            OTPCodes(context),
//                            OTPCodes(context),
//                            OTPCodes(context),
//                            OTPCodes(context),
//                            OTPCodes(context),
//                          ],
//                        )),
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
