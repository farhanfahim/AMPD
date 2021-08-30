import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ToastUtil {
  static void showToast(BuildContext context, String msg) {
   // print("msg " + msg);

    if (msg == null) {
      return;
    }
   // _failMessage(msg, context);
    Toast.show(msg, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  static void showSnackBar(BuildContext context,String msg){

    final snackBar = SnackBar(content: Text(msg!=null?msg:""));
    ScaffoldState().showSnackBar(snackBar);
  }

  static void _failMessage(message, context) {
    /// Showing Error messageSnackBarDemo
    /// Ability so close message
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 20),
      // action: SnackBarAction(
      //   label: "Close",
      //   onPressed: () {
      //     // Some code to undo the change.
      //   },
      // ),
    );

    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
