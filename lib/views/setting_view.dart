import 'dart:math';

import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class SettingView extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    bool pushNotificationSwitch = false;
    double _lowerValue = 50;
    double _upperValue = 180;
    return Scaffold(
        appBar: appBar(title:"",onBackClick: (){
          Navigator.of(context).pop();
        },iconColor:AppColors.COLOR_BLACK),
        backgroundColor: AppColors.WHITE_COLOR,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Header(heading1:AppStrings.SETTING,heading2:AppStrings.MANAGE_YOUR_ACCOUNT_SETTING),

                    SizedBox(
                      height: 50.0,
                    ),
                    Container(

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.NOTIFICATIONS,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 14.0,
                                color: AppColors.COLOR_BLACK,
                                fontFamily: AppFonts.POPPINS_MEDIUM,
                                fontWeight: FontWeight.w400),
                          ),
                          Container(
                            child: CupertinoSwitch(
                              activeColor: AppColors.BLUE_COLOR,
                              value: pushNotificationSwitch,
                              onChanged: (value) {

                                print(value);
                                setState(() {
                                  pushNotificationSwitch = value;
                                });

                              },
                              // activeColor: Colors.green,
                            ),
                          )

                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    divider(),

                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                "Change Password",
                                style: AppStyles.blackWithDifferentFontTextStyle(context, 12.0).copyWith(color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                              ),
                              SizedBox(
                                height: 6.0,
                              ),
                              Text(
                                "Update your password",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: AppColors.COLOR_BLACK,
                                    fontFamily: AppFonts.POPPINS_MEDIUM,
                                    fontWeight: FontWeight.w400),
                              ),





                            ],
                          ),

                          Spacer(),

                          Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16.0,
                              color: AppColors.COLOR_BLACK,// add custom icons also
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      width: double.maxFinite,
                      child: Text(
                        "Set Radius",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 14.0,
                            color: AppColors.COLOR_BLACK,
                            fontFamily: AppFonts.POPPINS_MEDIUM,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                  ],

                ),

              ),

          ),
        ));
  }
}
class Header extends StatelessWidget {
  final String heading1;
  final String heading2;
  const Header({
    this.heading1,
    this.heading2,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.0,
          ),
          Text(
            heading1,
            style: AppStyles.blackWithBoldFontTextStyle(context, 18.0).copyWith(color: AppColors.COLOR_BLACK),
          ),
          SizedBox(
            height: 6.0,
          ),
          Text(
            heading2,
            style: AppStyles.blackWithDifferentFontTextStyle(context, 14.0).copyWith(color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
          ),





        ],
      ),
    );
  }
}
