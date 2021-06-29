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
        },iconColor:AppColors.WHITE_COLOR),
        backgroundColor: AppColors.BLUE_COLOR,
        body: SafeArea(
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.66,
                margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
                          AppStyles.blackWithBoldFontTextStyle(context, 16.0),
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
                      height: 50.0,
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
