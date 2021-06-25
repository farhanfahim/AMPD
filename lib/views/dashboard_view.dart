import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/views/home_view.dart';
import 'package:ampd/views/saved_coupons_view.dart';
import 'package:ampd/views/side_menu_view.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  List<String> bottomBarIcons = [
    AppImages.IC_COUPONS,
    AppImages.IC_MENU,
  ];

  List<Widget> listOfMainScreens = [
    SavedCouponsView(),
    HomeView(),
    SideMenuView(),
  ];

  var _selectedPageIndex;
  PageController _pageController;

  @override
  void initState() {
    _selectedPageIndex = 1;
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
    final appBar = AppBar(
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
        _selectedPageIndex == 1? AppStrings.HOME : "",
          style: AppStyles.poppinsTextStyle(fontSize: 20.0, weight: FontWeight.w500).copyWith(color: Colors.black)
      ),
      centerTitle: true,
      actions: [
      ],
    );

    final body = PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: listOfMainScreens,
    );

    return Scaffold(
      appBar: appBar,
      body: body,
      bottomNavigationBar: Container(
        height: 90.0,
        color: Colors.white,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Material(
                elevation: 10.0,
                child: Container(
                  color: Colors.white,
                  height: 60.0,
                  child: Row(
                    children: [
                      SizedBox(width: 50.0),

                      GestureDetector(
                        onTap: () {
                          print('0 tapped');
                          setState(() {
                            _selectedPageIndex = 0;
                            _pageController.jumpToPage(0);
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            bottomBarIcons[0],
                            width: 25.0,
                            height: 25.0,
                            color: (_selectedPageIndex == 0) ? AppColors
                            .ACCENT_COLOR : AppColors.UNSELECTED_COLOR,
//                              Theme.of(context).iconTheme.color,
                            matchTextDirection: true,
                          ),
                        ),
                      ),

                      Spacer(),

                      GestureDetector(
                        onTap: () {
                          print('2 tapped');
                          setState(() {
                            _selectedPageIndex = 2;
                            _pageController.jumpToPage(2);
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            bottomBarIcons[1],
                            width: 18.0,
                            height: 18.0,
                            color: (_selectedPageIndex == 2) ? AppColors
                            .ACCENT_COLOR : AppColors.UNSELECTED_COLOR,
                            //Theme.of(context).iconTheme.color,
                            matchTextDirection: true,
                          ),
                        ),
                      ),

                      SizedBox(width: 50.0),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 15.0,
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
    );
  }
}
