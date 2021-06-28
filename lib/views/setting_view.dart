import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:flutter/material.dart';

class SettingView extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: AppColors.COLOR_BLACK,// add custom icons also
            ),
          ),
        ),
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
