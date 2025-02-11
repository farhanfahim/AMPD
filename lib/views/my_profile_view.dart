import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/data/database/app_preferences.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../appresources/app_colors.dart';
import '../appresources/app_strings.dart';

class MyProfileView extends StatefulWidget {
  @override
  _MyProfileViewState createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {

  AppPreferences _appPreferences = new AppPreferences();

  String _name = "--";
  String _email = "--";
  String _phone = "--";
  String _imageUrl = "";

  @override
  void initState() {
    super.initState();

    _appPreferences.isPreferenceReady;
    _appPreferences.getUserDetails().then((userData) {
      print(userData.toJson());

      setState(() {
        _email = userData.data.email;
        _phone = userData.data.phone;
        if(userData.data.image!= null) {
          _imageUrl = userData.data.imageUrl;
        }else{
          _imageUrl = "";
        }
        _name = "${userData.data.firstName} ${userData.data.lastName}";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // call this method here to hide soft keyboard
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
          appBar: appBar(
              title: "",
              showCloseIcon: false,
              onBackClick: () {Navigator.of(context).pop();},
              onActionClick: () { Navigator.pushNamed(context, AppRoutes.EDIT_PROFILE_VIEW).then((value) {
                _appPreferences.getUserDetails().then((userData) {
                  print(userData.toJson());

                  setState(() {
                    _email = userData.data.email;
                    _phone = userData.data.phone;
                    if(userData.data.image!= null) {
                      _imageUrl = userData.data.imageUrl;
                    }else{
                      _imageUrl = "";
                    }
                    _name = "${userData.data.firstName} ${userData.data.lastName}";
                  });
                });
              });},
              iconColor: AppColors.COLOR_BLACK,
              showAction: true,
              actionText:"Edit Profile"),
          backgroundColor: AppColors.WHITE_COLOR,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: Container(
                        decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0),
                                side: BorderSide(
                                    width: 10,
                                    color: AppColors.AVATAR_BORDER_COLOR))),
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundColor: AppColors.WHITE_COLOR,
                          child:  _imageUrl.isNotEmpty?cacheImageVIewWithCustomSize(
                              url: _imageUrl,
                              context: context,
                              width: 120,
                              height: 120,
                              radius: 80.0):ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.asset(
                              "assets/images/user.png",
                              fit: BoxFit.fill,
                            ),
                          ),

                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      _name,
                      style:
                      AppStyles.blackWithBoldFontTextStyle(context, 30.0).copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),

                    SizedBox(
                      height: 25.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Column(
                        children: [
                          divider(),
                          SizedBox(
                            height: 25.0,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    AppStrings.EMAIL,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: AppColors.COLOR_BLACK,
                                        fontFamily: AppFonts.POPPINS_MEDIUM,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text(
                                    _email,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: AppColors
                                            .APP__DETAILS_TEXT_COLOR,
                                        fontFamily: AppFonts.POPPINS_MEDIUM,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 25.0,
                          ),
                          divider(),
                          SizedBox(
                            height: 25.0,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    AppStrings.PHONE,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: AppColors.COLOR_BLACK,
                                        fontFamily: AppFonts.POPPINS_MEDIUM,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text(
                                    _phone,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: AppColors
                                            .APP__DETAILS_TEXT_COLOR,
                                        fontFamily: AppFonts.POPPINS_MEDIUM,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 25.0,
                          ),

                          divider(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.CHANGE_PASSWORD_VIEW);
                      },
                      child: Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        child: Column(

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
                                        "Change Password",
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
                                        "Update your password",
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
                              height: 25.0,
                            ),
                            divider(),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),

                  ],
                ),
              ),
            ),
          )),
    );
  }
}
