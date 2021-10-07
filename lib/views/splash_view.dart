import 'dart:async';

import 'package:ampd/app/app.dart';
import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with WidgetsBindingObserver {
  bool _openSetting = false;
  @override
  void initState() {

    super.initState();
    Timer(Duration(seconds: 3),
            () =>  checkIsLoggedIn());
      }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        toolbarHeight: 0.0,
      ),
      backgroundColor: AppColors.WHITE_COLOR,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: SvgPicture.asset(
                AppImages.MAIN_LOGO,
              ),
            ),
          ),


          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 15.0),
            child: Text(
              "Version 2.0.9",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 12.0,
                  color: AppColors.COLOR_BLACK,
                  fontFamily: AppFonts.POPPINS_MEDIUM,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Future checkIsLoggedIn() async {


    await App().getAppPreferences().isPreferenceReady;

    App().getAppPreferences().getIsLoggedIn().then((value) {
      if(value) {
        //   ToastUtil.showToast(context, "value: "+value.toString());
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.LOCATION_SETTING_VIEW, (route) => false);
      }else{
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.WELCOME_VIEW, (route) => false);
      }
    }).catchError((onError){
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.WELCOME_VIEW, (route) => false);
    });
  }
}
