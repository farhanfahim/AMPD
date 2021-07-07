import 'dart:math';

import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/widgets/button_border.dart';
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
    int a = 0;
    return Scaffold(
        appBar: appBar(
            title: "",
            onBackClick: () {
              Navigator.of(context).pop();
            },
            iconColor: AppColors.COLOR_BLACK),
        backgroundColor: AppColors.WHITE_COLOR,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Header(
                          heading1: AppStrings.SETTING,
                          heading2: AppStrings.MANAGE_YOUR_ACCOUNT_SETTING),
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
                                  style: AppStyles.blackWithDifferentFontTextStyle(
                                          context, 12.0)
                                      .copyWith(
                                          color: AppColors
                                              .APP__DETAILS_TEXT_COLOR_LIGHT),
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
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.CHANGE_PASSWORD_VIEW);
                              },
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16.0,
                                color:
                                    AppColors.COLOR_BLACK, // add custom icons also
                              ),
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
                        height: 30.0,
                      ),

                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(

                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right:15.0),
                              child: Text(
                                "20\nmile",
                                style: AppStyles.blackWithBoldFontTextStyle(
                                    context, 11.0).copyWith(color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                                textAlign: TextAlign.center,

                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 0, right: 0),
                            child: FlutterSlider(
                              values: [00, 10],
                              rangeSlider: true,
                              tooltip: FlutterSliderTooltip(
                                format: (String value) {
                                  String newValue = value;
                                  if (newValue.contains(".0")) {
                                    newValue.replaceAll(".0", "123");
                                    return newValue + ' \nmile ';
                                  } else {
                                    return "0" + ' \nmile ';
                                  }
                                },
                                textStyle: TextStyle(
                                  color: AppColors.BLUE_COLOR,
                                  fontSize: 11.0,
                                  fontFamily: AppFonts.POPPINS,
                                  fontWeight: FontWeight.w600,
                                ),
                                alwaysShowTooltip: true,
                                direction: FlutterSliderTooltipDirection.top,
                                positionOffset:
                                FlutterSliderTooltipPositionOffset(top: -30),
                              ),
                              max: 20,
                              min: 0,
                              trackBar: FlutterSliderTrackBar(
                                inactiveTrackBarHeight: 6,
                                activeTrackBarHeight: 6,
                                activeTrackBar:
                                BoxDecoration(color: AppColors.BLUE_COLOR),
                              ),
                              handler: FlutterSliderHandler(
                                decoration: BoxDecoration(),
                                child: Container(
                                  height: 20.0,
                                  width: 20.0,
                                  decoration: BoxDecoration(
                                      color: AppColors.BLUE_COLOR,
                                      borderRadius: BorderRadius.circular(15)),
                                  padding: EdgeInsets.all(5),
                                ),
                              ),
                              rightHandler: FlutterSliderHandler(
                                decoration: BoxDecoration(),
                                child: Container(
                                  height: 20.0,
                                  width: 20.0,
                                  decoration: BoxDecoration(
                                      color: AppColors.BLUE_COLOR,
                                      borderRadius: BorderRadius.circular(15)),
                                  padding: EdgeInsets.all(5),
                                ),
                              ),

                              /* onDragging: (handlerIndex, lowerValue, upperValue) {
                            _lowerValue = lowerValue;
                            _upperValue = upperValue;
                            setState(() {

                            });
                          },*/
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  )
                )
              ],
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
            style: AppStyles.blackWithBoldFontTextStyle(context, 18.0)
                .copyWith(color: AppColors.COLOR_BLACK),
          ),
          SizedBox(
            height: 6.0,
          ),
          Text(
            heading2,
            style: AppStyles.blackWithDifferentFontTextStyle(context, 14.0)
                .copyWith(color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
          ),
        ],
      ),
    );
  }
}

customHandler(IconData icon) {
  return FlutterSliderHandler(
    decoration: BoxDecoration(),
    child: Container(
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.3), shape: BoxShape.circle),
        child: Icon(
          icon,
          color: Colors.white,
          size: 23,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              spreadRadius: 0.05,
              blurRadius: 5,
              offset: Offset(0, 1))
        ],
      ),
    ),
  );
}
