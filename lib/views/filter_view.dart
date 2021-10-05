import 'dart:math';
import 'dart:convert';
import 'package:ampd/app/app.dart';
import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/data/database/app_preferences.dart';
import 'package:ampd/data/model/login_response_model.dart';
import 'package:ampd/utils/ToastUtil.dart';
import 'package:ampd/utils/Util.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:intl/intl.dart';
import 'package:ampd/viewmodel/filter_viewmodel.dart';
class FilterView extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<FilterView>{

  bool isApiCalling = false;
  FilterViewModel _filterViewModel;
  bool _isInternetAvailable = true;
  bool _enabled = true;
  LoginResponseModel userDetails;

  bool expirationSwitch = false;
  bool discountAmountSwitch = false;
  bool locationSwitch = false;
  bool alphabetSwitch = false;
  DateTime selectedDate = DateTime.now();
  bool isDateSelected = false;
  String startDate="Start Expiration",endDate="End Expiration";
  double min=0.0,max=300.0,min1=0.0,max1=300.0;
  AppPreferences _appPreferences = new AppPreferences();
  @override
  void initState() {
    super.initState();

    _appPreferences.getUserDetails().then((userData) {
      setState(() {
        userDetails = userData;
        expirationSwitch = userData.data.soonestExpiration == 1? true : false;
        discountAmountSwitch = userData.data.highestDiscountAmount == 1? true : false;
        locationSwitch = userData.data.nearestLocation == 1? true : false;
        alphabetSwitch = userData.data.sortingAscending == 1? true : false;
        min1 = userData.data.radius.toDouble();
      });
    });

    _filterViewModel = FilterViewModel(App());
    subscribeToViewModel();
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: appBar(
            title: "",
            onBackClick: () {

              isApiCalling?Navigator.pushReplacementNamed(context, AppRoutes.SAVED_COUPONS_2,arguments: {
                'isFromFilterScreen': true,
                'startDate': startDate,
                'endDate': endDate,
                'minPrice': min1,
                'maxPrice': max1,
                'minRadius': min,
                'maxRadius': max,
              }):Navigator.of(context).pop();
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
                          height: 30.0,
                        ),

                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Expiration (Soonest)",
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
                                  value: expirationSwitch,
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      expirationSwitch = value;
                                      discountAmountSwitch = false;
                                      locationSwitch = false;
                                      alphabetSwitch = false;
                                    });
                                    callUpdateProfileApi();
                                    //
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

                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Discount Amount (Highest)",
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
                                  value: discountAmountSwitch,
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      discountAmountSwitch = value;
                                      expirationSwitch = false;
                                      locationSwitch = false;
                                      alphabetSwitch = false;
                                    });
                                    callUpdateProfileApi();
                                    //
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

                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Location (Nearest)",
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
                                  value: locationSwitch,
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      locationSwitch = value;
                                      expirationSwitch = false;
                                      discountAmountSwitch = false;
                                      alphabetSwitch = false;
                                    });
                                    callUpdateProfileApi();
                                    //
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

                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Alphabetically (A-Z)",
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
                                  value: alphabetSwitch,
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      alphabetSwitch = value;
                                      locationSwitch = false;
                                      expirationSwitch = false;
                                      discountAmountSwitch = false;

                                    });
                                    callUpdateProfileApi();
                                    //
                                  },
                                  // activeColor: Colors.green,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),


                        Container(
                          width: double.maxFinite,
                          child: Text(
                            "Ammount",
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

                            child: Column(

                              children: [
                                Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right:15.0),
                                        child: Text(
                                          " \$ 1000",
                                          style: AppStyles.blackWithBoldFontTextStyle(
                                              context, 11.0).copyWith(color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                                          textAlign: TextAlign.center,

                                        ),
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(top: 10, left: 0, right: 0),
                                      child: FlutterSlider(
                                        values: [min,max],
                                        rangeSlider: true,
                                        tooltip: FlutterSliderTooltip(
                                          format: (String value) {
                                            String newValue = value;
                                            if (newValue.contains(".0")) {
                                              newValue.replaceAll(".0", "123");
                                              return "\$ "+newValue;
                                            } else {
                                              return "\$ 0";
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
                                          min = lowerValue;
                                          max = upperValue;

                                          callUpdateProfileApi();
                                          print("min $min");
                                          print("max $max");
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

                              ],
                            )
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

                            child: Column(

                              children: [
                                Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right:15.0),
                                        child: Text(
                                          "1000\nmile",
                                          style: AppStyles.blackWithBoldFontTextStyle(
                                              context, 11.0).copyWith(color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                                          textAlign: TextAlign.center,

                                        ),
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(top: 10, left: 0, right: 0),
                                      child: FlutterSlider(
                                        values: [min1],
                                        rangeSlider: false,
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
                                        max: 1000,
                                        min: 0,

                                        onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                                          setState(() {
                                            min1 = lowerValue;
                                            max1 = upperValue;
                                          });

                                          callUpdateProfileApi();
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
                                  height: 20.0,
                                ),
                              ],
                            )
                        ),

                      ],
                    ),
                  ),
                  /*GradientButton(
                    onTap: () {

                      Navigator.pushReplacementNamed(context, AppRoutes.SAVED_COUPONS_2,arguments: {
                        'isFromFilterScreen': true,
                        'startDate': startDate,
                        'endDate': endDate,
                        'minPrice': min1,
                        'maxPrice': max1,
                        'minRadius': min,
                        'maxRadius': max,
                      });
                    },
                    text: AppStrings.APPLY,
                  ),*/
                ],
              ),
            ),
          ),
        ));


  }



  getFormatedDate(_date) {

    var outputFormat = DateFormat('yyyy-MM-dd');
    return outputFormat.format(_date);
  }


  Future<void> callUpdateProfileApi() async {
    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
//          _isInAsyncCall = true;
        });

        var map = Map<String, dynamic>();
        map['soonest_expiration'] = expirationSwitch? 1 : 0;
        map['highest_discount_amount'] = discountAmountSwitch? 1 : 0;
        map['nearest_location'] = locationSwitch? 1 : 0;
        map['sorting_ascending'] = alphabetSwitch? 1 : 0;
        _filterViewModel.updateProfile(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
          ToastUtil.showToast(context, "No internet");
        });
      }
    });
  }

  void subscribeToViewModel() {
    _filterViewModel
        .getAboutRepository()
        .getRepositoryResponse()
        .listen((response) async {

      if(mounted) {
        setState(() {
          _enabled = true;
        });
      }

      if (response.success) {

          isApiCalling = true;
          userDetails.data.soonestExpiration = expirationSwitch? 1 : 0;
          userDetails.data.highestDiscountAmount = discountAmountSwitch? 1 : 0;
          userDetails.data.nearestLocation = locationSwitch? 1 : 0;
          userDetails.data.sortingAscending = alphabetSwitch? 1 : 0;
          userDetails.data.radius = max1.toInt();
          _appPreferences.setUserDetails(data: jsonEncode(userDetails));
          ToastUtil.showToast(context, "${userDetails.data.radius}");
      }else if (response.data is DioError) {
        if (response.statusCode == 401) {
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.WELCOME_VIEW, (Route<dynamic> route) => false);
        }else{
          _isInternetAvailable = Util.showErrorMsg(context, response.data);
        }
      } else {
        ToastUtil.showToast(context, response.msg);
      }
    });
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
