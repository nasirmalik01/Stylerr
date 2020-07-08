import 'package:flutter/material.dart';

Container OTPCodes(BuildContext context){
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: Colors.black54)
    ),
    height: MediaQuery.of(context).size.height*0.07,
    width: MediaQuery.of(context).size.width*0.12,
    child: Center(
      child: Text(
        '4',
        style: TextStyle(
          fontSize: 25
        ),
      ),
    ),
  );
}
