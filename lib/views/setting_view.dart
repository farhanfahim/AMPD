import 'dart:math';

import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SettingView extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(title:"",onBackClick: (){
          Navigator.of(context).pop();
        }),
        backgroundColor: AppColors.WHITE_COLOR,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(

                children: [


                ],
              ),

          ),
        ));
  }
}
