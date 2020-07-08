import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylerrapp/main.dart';
import 'package:stylerrapp/screens/signup_screens/NameScreen.dart';

class HomePageScreen extends StatefulWidget {
  final FirebaseUser user;
  final String nameValue;

//  final String password;
//  bool isEmail;

//  HomePageScreen({this.user, this.name, this.password, this.isEmail = false});
  HomePageScreen({this.user, this.nameValue});

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  String type;
  String nameData;

  @override
  Future<void> didChangeDependencies() async {
//    print(widget.isEmail);
//    if(widget.isEmail == true){
//      await Firestore.instance
//          .collection('Users')
//          .document(widget.user.uid)
//          .setData({'Name': widget.name, 'Email': widget.user.email, 'Password': widget.password});
//    }
//    else  {
//      await Firestore.instance.collection('Users')
//          .document(widget.user.uid)
//          .setData({
//        'Name': widget.name, 'Phone No': widget.user.phoneNumber
//      });
//    }

    DocumentSnapshot documentSnapshot = await Firestore.instance
        .collection('Users')
        .document(widget.user.uid)
        .get();
    if (documentSnapshot.data != null) {
      type = documentSnapshot.data['Type'];
      nameData = documentSnapshot.data['Name'];

      if (type == 'Email') {
        print('Number 1');
        await Firestore.instance
            .collection('Users')
            .document(widget.user.uid)
            .setData({
          'Type': 'Email',
          'Name': nameData,
          'Email': widget.user.email
        });
      } else {
        print('Number 2');
        await Firestore.instance
            .collection('Users')
            .document(widget.user.uid)
            .setData({
          'Type': 'Phone',
          'Name': nameData,
          'Phone No': widget.user.phoneNumber
        });
      }
    } else {
      print('Number 3');
      if (widget.user.email != null) {
        await Firestore.instance
            .collection('Users')
            .document(widget.user.uid)
            .setData({
          'Type': 'Email',
          'Name': widget.nameValue,
          'Email': widget.user.email
        });
      } else {
        print('Number 4');
        await Firestore.instance
            .collection('Users')
            .document(widget.user.uid)
            .setData({
          'Type': 'Phone',
          'Name': widget.nameValue,
          'Phone No': widget.user.phoneNumber
        });
      }
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backpressed,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('isUser');
//                Route route =
//                    MaterialPageRoute(builder: (context) => NameScreen());
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(NameScreen.routeName, (Route<dynamic> route) => false);
              },
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "You are Logged in succesfully",
                style: TextStyle(color: Colors.lightBlue, fontSize: 32),
              ),
              SizedBox(
                height: 16,
              ),
              (widget.user.phoneNumber != null)
                  ? Text(
                      "${widget.user.uid}\n${widget.user.phoneNumber}",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  : Text(
                      "${widget.user.uid}\n${widget.user.email}",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _backpressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                'Are you sure ? ',
                style: TextStyle(
                  fontFamily: 'Nunito',
                ),
              ),
              content: Text(
                'Do you really want to exit ?',
                style: TextStyle(
                  fontFamily: 'Nunito',
                ),
              ),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text(
                    'No',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    SystemNavigator.pop();
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
              ],
            ));
  }
}
