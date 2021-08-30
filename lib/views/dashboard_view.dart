import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/data/model/UserLocation.dart';
import 'package:ampd/views/home_view.dart';
import 'package:ampd/views/saved_coupon_1_view.dart';
import 'package:ampd/views/side_menu_view.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
      brightness: Theme
          .of(context)
          .appBarTheme
          .brightness,
      backgroundColor: Theme
          .of(context)
          .appBarTheme
          .color,
      title: Text(
        _selectedPageIndex == 1? "Home" : "",
          style: AppStyles.poppinsTextStyle(fontSize: 20.0, weight: FontWeight.w500).copyWith(color: Colors.black)
      ),
      centerTitle: true,
      actions: [
      ],
    );

    final appBar1 = appBar(
        title:"Home",onBackClick: (){

        },
        iconColor:AppColors.WHITE_COLOR,
        hasLeading: _selectedPageIndex == 1? false : true
    );

    final body = PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: listOfMainScreens,
    );

    return Stack(
      children: [
        Scaffold(
          // appBar: _selectedPageIndex == 1? appBar1 : null,
          body: body,
          bottomNavigationBar: Container(
            height: 95.0,
            color: Colors.white,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Material(
                    elevation: 10.0,
                    child: Container(
                      color: Colors.white,
                      height: 65.0,
                      child: Row(
                        children: [

                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print('0 tapped');
                                if (!widget.map['isGuestLogin']) {
                                  setState(() {
                                    _selectedPageIndex = 0;
                                    _pageController.jumpToPage(0);
                                  });
                                } else {
                                  Navigator.pushNamed(context, AppRoutes.SIGN_IN_VIEW);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(10.0),
//                                color: Colors .red,
                                color: Colors.white,
                                child: SvgPicture.asset(
                                  bottomBarIcons[0],


//                                width: 25.0,
//                                height: 25.0,
                                  color: (_selectedPageIndex == 0) ? AppColors
                                  .ACCENT_COLOR : AppColors.UNSELECTED_COLOR,
//                              Theme.of(context).iconTheme.color,
                                  matchTextDirection: true,
                                ),
                              ),
                            ),
                          ),

                          Spacer(),

                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print('2 tapped');
                                if (!widget.map['isGuestLogin']) {
                                  setState(() {
                                    _selectedPageIndex = 2;
                                    _pageController.jumpToPage(2);
                                  });
                                } else {
                                  Navigator.pushNamed(context, AppRoutes.SIGN_IN_VIEW);
                                }
                              },
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  bottomBarIcons[1],
//                                  width: 18.0,
//                                  height: 18.0,
                                  color: (_selectedPageIndex == 2) ? AppColors
                                  .ACCENT_COLOR : AppColors.UNSELECTED_COLOR,
                                  //Theme.of(context).iconTheme.color,
                                  matchTextDirection: true,
                                ),
                              ),
                            ),
                          ),

//                          SizedBox(width: 50.0),
                        ],
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 20.0,
                  left: 0.0,
                  right: 0.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 70.5,
                        width: 70.5,
                        child: FloatingActionButton(
                          elevation: 15,
                          backgroundColor: Colors.white,
                          child: Container(
                            height: 70.5,
                            width: 70.5,
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _selectedPageIndex == 1? AppColors.ACCENT_COLOR : AppColors.UNSELECTED_COLOR,
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
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),

        widget.map['show_tutorial']? _tutorialCount < 3? GestureDetector(
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
                  _tutorialCount == 0? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(_tutorialIcons[0], width: 200.0, height: 200.0,),
                    ],
                  ) : Container(),

                  _tutorialCount == 1? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(_tutorialIcons[1], width: 250.0, height: 250.0,),
                    ],
                  ) : Container(),

                  _tutorialCount == 2? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(_tutorialIcons[2], width: 250.0, height: 250.0,),
                    ],
                  ) : Container()
                ],
              ),
            ),
          ),
        ) : Container() : Container()
      ],
    );
  }
}
