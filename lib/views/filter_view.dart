import 'dart:math';

import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class FilterView extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<FilterView> {
  @override
  Widget build(BuildContext context) {
    bool pushNotificationSwitch = false;
    int a  = 0;
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
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 0.0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(

                      children: [
                        Header(
                            heading1: AppStrings.FILTER,
                            heading2: AppStrings.FILTER_YOUR),
                        SizedBox(
                          height: 50.0,
                        ),


                        Container(
                          width: double.maxFinite,
                          child: Text(
                            "Amount",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 14.0,
                                color: AppColors.COLOR_BLACK,
                                fontFamily: AppFonts.POPPINS_MEDIUM,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30, left: 0, right: 0),
                          child: FlutterSlider(

                            values: [00, 500],
                            rangeSlider: true,
                            tooltip: FlutterSliderTooltip(
                              format: (String value) {

                                return '\$ '+value ;

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
                              FlutterSliderTooltipPositionOffset(top: -20),
                            ),
                            max: 1000,
                            min: 0,
                            trackBar: FlutterSliderTrackBar(
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

                        divider(),

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
                        Container(
                          margin: EdgeInsets.only(top: 40, left: 0, right: 0),
                          child: FlutterSlider(

                            values: [00, 10],
                            rangeSlider: true,
                            tooltip: FlutterSliderTooltip(
                              format: (String value) {

                                String newValue = value;
                                if(newValue.contains(".0")){
                                  newValue.replaceAll(".0", "123");
                                  return newValue + ' \nmile ';
                                }else{
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
                        divider(),

                        SizedBox(
                          height: 60.0,
                        ),
                      ],
                    ),
                  ),
                  GradientButton(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    text: AppStrings.FILTER,
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
