import 'dart:async';
import 'dart:io';
import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/utils/LocationPermissionHandler.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:sizer/sizer.dart';
import 'package:geolocator/geolocator.dart' as gcl;

class LocationSettingView extends StatefulWidget {
  @override
  _LocationSettingViewState createState() => _LocationSettingViewState();
}

class _LocationSettingViewState extends State<LocationSettingView> with WidgetsBindingObserver{

  bool isSettingEnable = false;
  @override
  Future<void> initState()  {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    checkPermissionEveryTime();

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print("app in resumed");
        checkPermissionEveryTime();
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
    }
  }

  void getCurrentLatLong() async {

    PermissionStatus permission = await LocationPermissionHandler.checkLocationPermission();

    if(permission == PermissionStatus.granted) {
      navigate();
      setState(() {
        isSettingEnable = true;
      });
    } else {
      Platform.isAndroid ? AppSettings.openAppSettings() : AppSettings.openLocationSettings();
    }
  }

  void checkPermissionEveryTime() async {

    PermissionStatus permission = await LocationPermissionHandler.checkLocationPermission();

    if(permission == PermissionStatus.granted) {
      navigate();
      setState(() {
        isSettingEnable = true;
      });
      print("permission granted");
    }else{
      print("permission denied");
    }
  }


  navigate() {
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.DASHBOARD_VIEW, (route) => false, arguments: {
      'isGuestLogin': false,
      'tab_index': 1,
      'show_tutorial': false
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.WHITE_COLOR,
        elevation: 0.0,
        toolbarHeight: 0.0,
      ),
      backgroundColor: AppColors.WHITE_COLOR,
      body: isSettingEnable?null:Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(20.0),
              decoration: ShapeDecoration(
                  color: AppColors.LIGHT_FILTER_CROSS_BG,
                  shape: RoundedRectangleBorder (
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                          width: 0.5,
                          color: AppColors.LIGHT_FILTER_CROSS_BG
                      )
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'APMD requires access to your location',
                    textAlign: TextAlign.left,
                    style: AppStyles.poppinsTextStyle(
                        fontSize: 14.0, weight: FontWeight.w500)
                        .copyWith(color: AppColors.COLOR_BLACK),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Enable Location to access nearby offers.',
                    textAlign: TextAlign.left,
                    style: AppStyles.poppinsTextStyle(
                        fontSize: 12.0, weight: FontWeight.w500)
                        .copyWith(color: AppColors.UNSELECTED_COLOR),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    child: GradientButton(
                      onTap: () {
                        getCurrentLatLong();

                      },
                      text: "Turn on location service",
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
