import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastClass {
  static showToast(
      {required String msg,
      Color? color,
      Color? bgColor,
      ToastGravity? gravity}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity ?? ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor ?? Colors.black,
        textColor: color ?? Colors.white,
        fontSize: 16.0);
  }
}
