import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {


    FlatButton _categories(String text){
     return FlatButton(
       shape:RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(0.0),
         side: BorderSide(color: Colors.black),
       ),
        onPressed: (){
          Text('$text Button Pressed.');
        },
        child: Text(
          '$text',
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.black,
          ),
        ),

      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: 100.0,
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'LET US FIND SERVICES\n '
                      '\t\t\t\t\t\t\t\t\t\t'
                      'NEAR YOU',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.0,
                  ),
                ),
              ),
              SizedBox(
                height: 100.0,
              ),
              _categories('MEN'),
              _categories('WOMEN'),
              _categories('BOTH'),

              SizedBox(
                height: 40.0,
              )
            ],
          )
        ),
      ),
    );
  }

}