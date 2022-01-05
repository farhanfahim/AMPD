import 'dart:convert';
import 'dart:math';

import 'package:ampd/app/app.dart';
import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/data/database/app_preferences.dart';
import 'package:ampd/data/model/login_response_model.dart';
import 'package:ampd/utils/ToastUtil.dart';
import 'package:ampd/utils/Util.dart';
import 'package:ampd/viewmodel/edit_profile_viewmodel.dart';
import 'package:ampd/viewmodel/settings_viewmodel.dart';
import 'package:ampd/widgets/animated_gradient_button.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:ampd/widgets/dialog_view.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class SettingView extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<SettingView> with TickerProviderStateMixin{

  SettingsViewModel _settingsViewModel;
  AnimationController _buttonController;
  bool pushNotificationSwitch = false;
  int a = 0;
  double min=0.0,max=100.0;

  bool _isInAsyncCall = false;
  bool _isInternetAvailable = true;

  AppPreferences _appPreferences = new AppPreferences();

  LoginResponseModel userDetails;
  @override
  void initState() {
    super.initState();
    _buttonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _settingsViewModel = SettingsViewModel(App());

    _appPreferences.getUserDetails().then((userData) {
      setState(() {
        userDetails = userData;
        pushNotificationSwitch = userData.data.pushNotifications == 1? true : false;
        min = userData.data.radius.toDouble();
      });
    });
    subscribeToViewModel();
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  Future<bool> _onBackPressed() {
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.DASHBOARD_VIEW, (route) => false, arguments: {
      'isGuestLogin': false,
      'tab_index': 1,
      'show_tutorial': false
    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:_onBackPressed,
      child: Scaffold(
          appBar: appBar(
              title: "",
              showCloseIcon: true,
              onBackClick: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.DASHBOARD_VIEW, (route) => false, arguments: {
                  'isGuestLogin': false,
                  'tab_index': 1,
                  'show_tutorial': false
                });

              },
              iconColor: AppColors.COLOR_BLACK),
          backgroundColor: AppColors.WHITE_COLOR,
          body: SafeArea(
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
                        height: 20.0,
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
                                  callUpdateProfileApi();
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
                        height: 20.0,
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
                                        "100\nmile",
                                        style: AppStyles.blackWithBoldFontTextStyle(
                                            context, 11.0).copyWith(color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                                        textAlign: TextAlign.center,

                                      ),
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(top: 10, left: 0, right: 0),
                                    child: FlutterSlider(
                                      values: [min],
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
                                      max: 100,
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
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.MY_PROFILE_VIEW);
                        },
                        child: Container(
                          color: AppColors.WHITE_COLOR,
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
                                    "My Profile",
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
                                    "Manage your profile",
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
                                color:
                                AppColors.COLOR_BLACK, // add custom icons also
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.TERMS_CONDITIONS);
                        },
                        child: Container(
                          color: AppColors.WHITE_COLOR,
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
                                    "Help",
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
                                    "Help and Terms of use",
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
                                color:
                                AppColors.COLOR_BLACK, // add custom icons also
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, AppRoutes.ABOUT);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              color: AppColors.WHITE_COLOR,
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
                                        "About us",
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
                                        "Who we are",
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
                                    color:
                                    AppColors.COLOR_BLACK, // add custom icons also
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Spacer(),
                Row(
                  children: [

                    Expanded(flex:1,child: Container()),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: (){

                          showDialog(
                              context: context,
                              builder: (BuildContext context1) {
                                return CustomDialog(
                                  showAnimatedBtn: true,
                                  contex: context,
                                  subTitle: "Are you sure?",
                                  //title: "Your feedback will help us improve our services.",

                                  btnWidget: AnimatedGradientButton(
                                    onAnimationTap: () {
                                      callLogoutApi();
                                    },
                                    buttonController: _buttonController,
                                    text: AppStrings.YES,
                                  ),
                                  buttonText2: AppStrings.NO,
                                  onPressed2: () {
                                    Navigator.pop(context1);
                                  },
                                  onPressed3:(){
                                    Navigator.pop(context1);
                                  },
                                  showImage: false,
                                );
                              });



                        },
                        child: Container(


                          decoration: ShapeDecoration(
                            color: AppColors.RED_COLOR2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  bottomLeft: Radius.circular(30.0)),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15,bottom: 15),
                            child: Text(
                              "LOG OUT",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: AppColors.WHITE_COLOR,
                                  fontFamily: AppFonts.POPPINS_MEDIUM,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                )


              ],
            ),
          )),
    );
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
        map['push_notifications'] = pushNotificationSwitch? 1 : 0;
        map['radius'] = min;
        _settingsViewModel.updateSettings(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
          ToastUtil.showToast(context, "No internet");
        });
      }
    });
  }




  Future<void> callLogoutApi() async {
    _playAnimation();
    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
        });

        var map = Map<String, dynamic>();
        _settingsViewModel.logout(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
          ToastUtil.showToast(context, "No internet");
        });
      }
    });
  }
  void subscribeToViewModel() {
    _settingsViewModel
        .getSettingsRepository()
        .getRepositoryResponse()
        .listen((response) async {
      _stopAnimation();
      if (mounted) {
        setState(() {
          _isInAsyncCall = false;
        });
      }
      if (response.msg == "Logged out successfully") {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.WELCOME_VIEW, (Route<dynamic> route) => false);

      }
      else if (response.success) {
        if(response.data == 0) {
          userDetails.data.radius = min.toInt();
          userDetails.data.pushNotifications = pushNotificationSwitch? 1 : 0;
          _appPreferences.setUserDetails(data: jsonEncode(userDetails));
          print(response.toString());
        }
      } else if (response.data is DioError) {
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

  Future<Null> _playAnimation() async {
    try {
      await _buttonController.forward();
    } on TickerCanceled {}
  }

  Future<Null> _stopAnimation() async {
    try {
      await _buttonController.reverse();
    } on TickerCanceled {}
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
