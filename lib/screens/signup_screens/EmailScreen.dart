import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stylerrapp/screens/signup_screens/MobileNumberScreen.dart';
import 'package:stylerrapp/screens/signup_screens/PasswordScreen.dart';

class EmailScreen extends StatefulWidget {
  static const routeName = 'EmailScreen';

  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  String email = '';
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String name = '';

  @override
  void didChangeDependencies() {
    name = ModalRoute.of(context).settings.arguments;
    print(name);
    super.didChangeDependencies();
  }

  void saveEmail() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    _formKey.currentState.save();

    Future.delayed(Duration(milliseconds: 1500)).then((_) {
      setState(() {
        isLoading = false;
      });

      Navigator.pushNamed(context, PasswordScreen.routeName,
          arguments: ({
            'Name': name,
            'Email': email,
          }));
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
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _formKey,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            right:
                                MediaQuery.of(context).size.width * 0.03),
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.18,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: Color(0xFFF3EEEE)),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MobileNumberScreen(name),
                              ),
                            );
                          },
                          child: Text(
                            'Skip',
                            style: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'Nunito'),
                          ),
                        ),
                      )
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
                            title: 'What\'s your email ?')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                    child: TextValues(
                        title:
                            'Get booking invoices along with discount offers in your inbox',
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, top: 20),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'email can\t be empty';
                        }
                        if (!RegExp(
                                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                            .hasMatch(value)) {
                          return 'Please enter a valid email Address';
                        }
                        return null;
                      },
                      onSaved: (_) {},
                      decoration: InputDecoration(
                        hintText: 'Enter your email address',
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
                    onPressed: isLoading ? null :  saveEmail,
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
      ),
    );
  }
}
