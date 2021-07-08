import 'dart:async';

import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_constants.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:ampd/widgets/custom_text_form.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../appresources/app_colors.dart';
import '../appresources/app_colors.dart';
import '../appresources/app_strings.dart';

class MyProfileView extends StatefulWidget {
  @override
  _MyProfileViewState createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {
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
              onBackClick: () {Navigator.of(context).pop();},
              onActionClick: () { Navigator.pushNamed(context, AppRoutes.EDIT_PROFILE_VIEW);},
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: Image.asset(
                              "assets/images/profile.png",
                              fit: BoxFit.cover,
                            ),
                          ),

                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      "Yusuf Nahass",
                      style:
                      AppStyles.blackWithBoldFontTextStyle(context, 30.0).copyWith(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery
                              .of(context)
                              .size
                              .width * .09),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                              child: Text(
                                "Bucharest Romania",
                                style: AppStyles
                                    .detailWithSmallTextSizeTextStyle(),
                                textAlign: TextAlign.center,
                              )),
                        ],
                      ),
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
                                    "YusufNahass@email.com",
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
                                    "(800) 362-9239",
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
                    )

                  ],
                ),
              ),
            ),
          )),
    );
  }
}
