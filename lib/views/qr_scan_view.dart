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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: AppColors.WHITE_COLOR,// add custom icons also
            ),
          ),
        ),
        backgroundColor: AppColors.BLUE_COLOR,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                constraints:
                    BoxConstraints(maxWidth: double.maxFinite, minHeight: 50.0),
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(
                            width: 0.5, color: AppColors.BLUE_COLOR))),
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
                      style:
                          AppStyles.blackWithBoldFontTextStyle(context, 20.0),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      height: 30.0.h,
                      margin: EdgeInsets.fromLTRB(0.0, 30.0, 0, 0),
                      child: Center(
                        child: SvgPicture.asset(
                          AppImages.QR_CODE,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 30.0,
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
                            style: AppStyles.detailWithSmallTextSizeTextStyle(),
                            textAlign: TextAlign.center,
                          )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 70.0,
                    ),
                    Text(
                      AppStrings.TIME_REMAINING,
                      style:
                          AppStyles.blackWithBoldFontTextStyle(context, 20.0),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Text(AppStrings.SECONDS,
                        style: AppStyles.detailWithSmallTextSizeTextStyle()),
                    SizedBox(
                      height: 50.0,
                    ),
                    GradientButton(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      text: AppStrings.DONE,
                    ),
                    SizedBox(
                      height: 50.0,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
