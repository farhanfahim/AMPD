import 'dart:io';
import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_constants.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/data/model/UserLocation.dart';
import 'package:ampd/views/home_view.dart';
import 'package:ampd/views/saved_coupon_1_view.dart';
import 'package:ampd/views/side_menu_view.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_appstore/open_appstore.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart' as gcl;
import 'package:sizer/sizer.dart';
import 'package:ampd/utils/LocationPermissionHandler.dart';
import 'package:ampd/utils/loader.dart';
import 'package:location_permissions/location_permissions.dart'
    as locationPermission;

class DashboardView extends StatefulWidget {
  bool isGuestLogin;
  Map<String, dynamic> map;

  DashboardView(this.map);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  List<String> _tutorialIcons = [
    AppImages.IC_TUTORIAL_DISLIKE,
    AppImages.IC_TUTORIAL_LIKE,
    AppImages.IC_TUTORIAL_DETAILS,
  ];

  int _tutorialCount = 0;

  List<String> bottomBarIcons = [
    AppImages.IC_COUPONS,
    AppImages.IC_MENU,
  ];

  List<Widget> listOfMainScreens = [];

  var _selectedPageIndex;
  PageController _pageController;

  @override
  void initState() {
    updateAppDialog();
    _selectedPageIndex = widget.map['tab_index'];
    listOfMainScreens = [
      SavedCoupons1View(),
      HomeView(widget.map['isGuestLogin']),
      SideMenuView(),
    ];

    _pageController = PageController(initialPage: _selectedPageIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBar2 = AppBar(
//      elevation: 0.6,
      brightness: Theme.of(context).appBarTheme.brightness,
      backgroundColor: Theme.of(context).appBarTheme.color,
      title: Text(_selectedPageIndex == 1 ? "Home" : "",
          style: AppStyles.poppinsTextStyle(
                  fontSize: 20.0, weight: FontWeight.w500)
              .copyWith(color: Colors.black)),
      centerTitle: true,
      actions: [],
    );

    final appBar1 = appBar(
        title: "Home",
        onBackClick: () {},
        iconColor: AppColors.WHITE_COLOR,
        hasLeading: _selectedPageIndex == 1 ? false : true);

    final body = Container(
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: listOfMainScreens,
            ),
          ),
        ],
      ),
    );

    return Stack(
      children: [
        Scaffold(
          body: body,
          floatingActionButton: FloatingActionButton(
            elevation: 15,
            backgroundColor: Colors.white,
            child: Container(
              height: 80,
              width: 80,
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _selectedPageIndex == 1
                    ? AppColors.ACCENT_COLOR
                    : AppColors.UNSELECTED_COLOR,
                //border: Border.all(color: darkBlueColor, width: 1.7)
              ),
              child: SvgPicture.asset(
                AppImages.IC_HOME,
                width: 20.0,
                height: 20.0,
                color: Colors.white,
                //Theme.of(context).iconTheme.color,
                matchTextDirection: true,
              ),
            ),
            onPressed: () {
              print('1 tapped');
              setState(() {
                _selectedPageIndex = 1;
                _pageController.jumpToPage(1);
              });
            },
          ),
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 4,
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              items: [
                BottomNavigationBarItem(
                    icon: GestureDetector(
                      onTap: () {
                        print('2 tapped');
                        if (!widget.map['isGuestLogin']) {
                          setState(() {
                            _selectedPageIndex = 0;
                            _pageController.jumpToPage(0);
                          });
                        } else {
                          Navigator.pushNamedAndRemoveUntil(context,
                              AppRoutes.SIGN_IN_VIEW, (route) => false);
                        }
                      },
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.fromLTRB(10,10,30,10),
                        child: SvgPicture.asset(
                          bottomBarIcons[0],
//                                  width: 18.0,
//                                  height: 18.0,
                          color: (_selectedPageIndex == 0)
                              ? AppColors.ACCENT_COLOR
                              : AppColors.UNSELECTED_COLOR,
                          //Theme.of(context).iconTheme.color,
                          matchTextDirection: true,
                        ),
                      ),
                    ),
                    title: Text(
                      "Title",
                      style: TextStyle(fontSize: 1),
                    )),
                BottomNavigationBarItem(
                    icon: GestureDetector(
                      onTap: () {
                        print('2 tapped');
                        if (!widget.map['isGuestLogin']) {
                          setState(() {
                            _selectedPageIndex = 2;
                            _pageController.jumpToPage(2);
                          });
                        } else {
                          Navigator.pushNamedAndRemoveUntil(context,
                              AppRoutes.SIGN_IN_VIEW, (route) => false);
                        }
                      },
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.fromLTRB(30,10,10,10),
                        child: SvgPicture.asset(
                          bottomBarIcons[1],
//                                  width: 18.0,
//                                  height: 18.0,
                          color: (_selectedPageIndex == 2)
                              ? AppColors.ACCENT_COLOR
                              : AppColors.UNSELECTED_COLOR,
                          //Theme.of(context).iconTheme.color,
                          matchTextDirection: true,
                        ),
                      ),
                    ),
                    title: Text(
                      "Title",
                      style: TextStyle(fontSize: 1),
                    )),
              ],
              onTap: (index) {
                print(index);
              },
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
        widget.map['show_tutorial']
            ? _tutorialCount < 3
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _tutorialCount++;
                      });
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.black54.withOpacity(0.75),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(left: 30.0, right: 30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _tutorialCount == 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        _tutorialIcons[0],
                                        width: 200.0,
                                        height: 200.0,
                                      ),
                                    ],
                                  )
                                : Container(),
                            _tutorialCount == 1
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image.asset(
                                        _tutorialIcons[1],
                                        width: 250.0,
                                        height: 250.0,
                                      ),
                                    ],
                                  )
                                : Container(),
                            _tutorialCount == 2
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        _tutorialIcons[2],
                                        width: 250.0,
                                        height: 250.0,
                                      ),
                                    ],
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    ),
                  )
                : Container()
            : Container()
      ],
    );
  }

  void updateAppDialog() {
    Map<String, dynamic> appData = null;

    FirebaseFirestore.instance
        .collection('app_update')
        .doc('app_id')
        .get()
        .then((chatlistSnapshot) async {
      // print(chatlistSnapshot.length.toString());

      appData = chatlistSnapshot.data();

      print(appData.toString());

      // setState(() {
      //   appUpdateMap = appData;
      // });
      //
      if (AppConstants.APP_VERSION < appData['version_number']) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context1) {
              return WillPopScope(
                onWillPop: () => Future.value(false),
                child: UpdateDialog(
                  contex: context,
                  subTitle:
                      "A newer version is available for download! Please update the app by visiting the ${Platform.isIOS ? 'App Store.' : 'Google Play Store.'}",
                  title: "New Version Available",
                  buttonText1: "Update Now",
                  buttonText2: "Later",
                  showLaterButton: !appData['force_update'],
                  onPressed1: () {
                    if (appData['force_update'] == false) {
                      Navigator.pop(context1);
                    }

                    /* OpenAppstore.launch(androidAppId: "com.app.ampd",
                        iOSAppId: "1561178517");*/
                  },
                  onPressed2: () {
                    Navigator.pop(context1);
                  },
                ),
              );
            });
      }
    });
  }
}

class UpdateDialog extends StatefulWidget {
  String title;
  String subTitle;
  String buttonText1;
  String buttonText2;
  Function onPressed1;
  Function onPressed2;
  Widget child;
  BuildContext contex;

  bool showLaterButton;

  UpdateDialog(
      {this.showLaterButton,
      this.title = "",
      this.buttonText1 = "",
      this.buttonText2 = "",
      this.onPressed1,
      this.onPressed2,
      this.child,
      this.contex,
      this.subTitle = ""});

  @override
  _UpdateDialogState createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.48;
    double width = MediaQuery.of(context).size.width * 0.4;
    double height1 = MediaQuery.of(context).size.height * 0.5;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 15.0),
      backgroundColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        Text(
                          widget.title,
                          style: AppStyles.staticLabelsTextStyle(context)
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18.0),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.subTitle,
                          textAlign: TextAlign.center,
                          style: AppStyles.staticLabelsTextStyle(context),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: buttonWithColor(
                                title: widget.buttonText1,
                                color: AppColors.APP_MAIN_SPLASH_COLOR,
                                onTap: () {
                                  widget.onPressed1();
                                },
                              ),
                            ),
                            widget.showLaterButton
                                ? SizedBox(
                                    width: 20,
                                  )
                                : Container(),
                            widget.showLaterButton
                                ? Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: buttonWithColor(
                                      color: AppColors.ACCENT_COLOR,
                                      title: widget.buttonText2,
                                      // btnColor: AppColors.APPGREENCOLOR,
                                      onTap: () {
                                        widget.onPressed2();
                                      },
                                    ),
                                  )
                                : Container(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              widget.showLaterButton
                  ? Positioned.fill(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                            width: 40,
                            height: 40,
                            child: FloatingActionButton(
                              heroTag: "tag",
                              backgroundColor: AppColors.ACCENT_COLOR,
                              // backgroundColor:
                              // AppColors.PRIMARY_COLORTWO,
                              elevation: 2,
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              // onPressed: widget.addClickListner
                            )),
                      ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}

