import 'package:flutter/material.dart';

class Appwidget{
  static TextStyle boldTextFieldStyle(){
    return TextStyle(
        color: Colors.black,
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins");
  }
  static TextStyle HeadlineTextFieldStyle() {
    return TextStyle(
        color: Colors.black,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins");
  }
  static TextStyle LightTextFieldStyle() {
    return TextStyle(
        color: Colors.black38,
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        fontFamily: "Poppins");
  }
  static TextStyle SemiBoldTextFieldStyle() {
    return TextStyle(
        color: Colors.black,
        fontSize: 21.0,
        fontWeight: FontWeight.w500,
        fontFamily: "Poppins");
  }
}
