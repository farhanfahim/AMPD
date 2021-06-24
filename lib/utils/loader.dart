import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  bool isLoading;
  Color color;
  Loader({this.isLoading,this.color});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
        child: Lottie.asset('assets/json/loading.json',width: 100,height: 100))
        : Container(
      width: 0,
      height: 0,
    );
  }
}