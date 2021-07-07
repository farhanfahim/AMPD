import 'dart:math';

import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:intl/intl.dart';

class FilterView extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<FilterView> {

  DateTime selectedDate = DateTime.now();
  bool isDateSelected = false;
  String fromDate="To Expiration",toDate="From Expiration";
  double min=0.0,max=10.0,min1=0.0,max1=500.0;
  @override
  Widget build(BuildContext context) {


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


                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: (){
                                  isDateSelected = false;
                                  _selectDate(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          fromDate,
                                          style: AppStyles.blackWithDifferentFontTextStyle(context, 14.0)
                                              .copyWith(color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                                        ),
                                        SvgPicture.asset(
                                          AppImages.CALENDER,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: (){
                                  isDateSelected = true;
                                  _selectDate(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          toDate,
                                          style: AppStyles.blackWithDifferentFontTextStyle(context, 14.0)
                                              .copyWith(color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                                        ),
                                        SvgPicture.asset(
                                          AppImages.CALENDER,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
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
                        SizedBox(
                          height: 30.0,
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
                                          "\$1000",
                                          style: AppStyles.blackWithBoldFontTextStyle(
                                              context, 11.0).copyWith(color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                                          textAlign: TextAlign.center,

                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10, left: 0, right: 0),
                                      child: FlutterSlider(
                                        values: [min1, max1],
                                        rangeSlider: true,
                                        tooltip: FlutterSliderTooltip(
                                          format: (String value) {
                                            String newValue = value;
                                            if (newValue.contains(".0")) {
                                              newValue.replaceAll(".0", "123");
                                              return ' \$'+newValue;
                                            } else {
                                              return "0" + ' \$ ';
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
                                        max: 1000,
                                        min: 0,

                                        onDragging: (handlerIndex, lowerValue, upperValue) {
                                          min1 = lowerValue;
                                          max1 = upperValue;
                                          setState(() {});
                                        },
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
                                  height: 10.0,
                                ),
                              ],
                            )
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
                        SizedBox(
                          height: 30.0,
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
                                        values: [min, max],
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

                                        onDragging: (handlerIndex, lowerValue, upperValue) {
                                          min = lowerValue;
                                          max = upperValue;
                                          setState(() {});
                                        },
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
                                  height: 10.0,
                                ),
                              ],
                            )
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

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {

        if(!isDateSelected){
          fromDate = getFormatedDate(picked);
        }else{
          toDate = getFormatedDate(picked);

        }

      });
  }

  getFormatedDate(_date) {

    var outputFormat = DateFormat('MM-dd-yyyy');
    return outputFormat.format(_date);
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
