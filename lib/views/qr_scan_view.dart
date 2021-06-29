import 'dart:math';

import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_constants.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:ampd/widgets/otp_text_field.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class QrScanView extends StatefulWidget {
  @override
  _QrScanState createState() => _QrScanState();
}

class _QrScanState extends State<QrScanView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
            title: "",
            onBackClick: () {
              Navigator.of(context).pop();
            },
            iconColor: AppColors.WHITE_COLOR),
        backgroundColor: AppColors.BLUE_COLOR,
        body: SafeArea(
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              constraints:
                  BoxConstraints(maxWidth: double.maxFinite, minHeight: 50.0),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side:
                          BorderSide(width: 0.5, color: AppColors.BLUE_COLOR))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    AppStrings.SCAN_QR_CODE,
                    style: AppStyles.blackWithBoldFontTextStyle(context, 20.0),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    height: 30.0.h,
                    margin: EdgeInsets.fromLTRB(0.0, 30.0, 0, 0),
                    child: Center(
                      child: SvgPicture.asset(
                        AppImages.QR_IMAGE,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .14),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            child: Text(
                          AppStrings.TIME_REMAINING_TO_SCAN,
                          style: AppStyles.blackWithBoldFontTextStyle(
                              context, 16.0),
                          textAlign: TextAlign.center,
                        )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CountDownWidget(),
                      SizedBox(
                        width: 8.0,

                      ),
                      CountDownWidget(),
                    ],
                  ),

                  SizedBox(
                    height: 30.0,
                  ),
                  Text(AppStrings.SECONDS,
                      style: AppStyles.detailWithSmallTextSizeTextStyle()),
                  SizedBox(
                    height: 20.0,
                  ),
                  GradientButton(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    text: AppStrings.DONE,
                  ),
                  SizedBox(
                    height: 40.0,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class CountDownWidget extends StatelessWidget {
  const CountDownWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                constraints: BoxConstraints(
                    maxWidth: 35.0, minHeight: 70.0),
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                    color: AppColors.COUNTDOWN_COLOR_LIGHT1,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10.0),
                        side: BorderSide(
                            width: 0.5,
                            color: AppColors.COUNTDOWN_COLOR_LIGHT1))),
              ),
              Container(
                constraints: BoxConstraints(
                    maxWidth: 35.0, minHeight: 32.0),
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                    color: AppColors.COUNTDOWN_COLOR_LIGHT2,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10.0),
                        side: BorderSide(
                            width: 0.5,
                            color: AppColors.COUNTDOWN_COLOR_LIGHT2))),
              ),

              Positioned.fill(
                child: Align(
                    alignment: Alignment.center,
                  child: Text(
                    "1",
                    style: AppStyles.blackWithBoldFontTextStyle(context, 30.0).copyWith(color: AppColors.WHITE_COLOR)
                    ,
                  ),
                ),
              ),

            ],
          )
        ],
      ),
    );
  }
}
