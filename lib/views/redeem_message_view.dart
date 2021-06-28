import 'dart:math';

import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RedeemMessageView extends StatefulWidget {
  @override
  _RedeemMessageState createState() => _RedeemMessageState();
}

class _RedeemMessageState extends State<RedeemMessageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(title:"",onBackClick: (){
          Navigator.of(context).pop();
        }),
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
                      AppStrings.REDEEM_MESSAGE,
                      style:
                          AppStyles.blackWithBoldFontTextStyle(context, 20.0),
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
                            AppStrings.REDEEM_MESSAGE_TEXT,
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
