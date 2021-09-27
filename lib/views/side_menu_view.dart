import 'dart:math';

import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/utils/ToastUtil.dart';
import 'package:ampd/utils/Util.dart';
import 'package:ampd/widgets/animated_gradient_button.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:ampd/viewmodel/side_menu_viewmodel.dart';
import 'package:ampd/widgets/dialog_view.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ampd/app/app.dart';

class SideMenuView extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenuView> with TickerProviderStateMixin {
  SideMenuViewModel _sideMenuViewModel;
  bool _isInternetAvailable = true;

  AnimationController _buttonController;
  @override
  void initState() {
    super.initState();

    _buttonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);

    _sideMenuViewModel = SideMenuViewModel(App());
    subscribeToViewModel();
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    bool pushNotificationSwitch = false;
    int a = 0;
    return Scaffold(
        appBar: appBar(
            title: "",
            onBackClick: () {Navigator.of(context).pop();},
            onActionClick: () { Navigator.pushNamed(context, AppRoutes.NOTIFICATIONS_VIEW);},
            iconColor: AppColors.COLOR_BLACK,
            showActionIcon: true,
          hasLeading: false
        ),
        backgroundColor: AppColors.WHITE_COLOR,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0.0),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Header(
                          heading1: "Preferences",
                          heading2: AppStrings.DISCOVER_MORE),
                      SizedBox(
                        height: 30.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.SETTING_VIEW);
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
                                    "Settings",
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
                                    "Manage your account setting",
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),

                    ],
                  ),

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
        ));
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
        _sideMenuViewModel.logout(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
          ToastUtil.showToast(context, "No internet");
        });
      }
    });
  }

  void subscribeToViewModel() {
    _sideMenuViewModel
        .getSideMenuRepository()
        .getRepositoryResponse()
        .listen((response) async {
      _stopAnimation();

      if (response.msg == "Logged out successfully") {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.WELCOME_VIEW, (Route<dynamic> route) => false);

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
