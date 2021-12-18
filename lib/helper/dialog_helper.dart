import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showPopUpToast(String? message) {
  Fluttertoast.showToast(
      msg: message!,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white70,
      textColor: Colors.black,
      fontSize: 16.0);
}
