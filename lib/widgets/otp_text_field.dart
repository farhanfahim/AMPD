import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
//import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
class OtpTextField extends StatelessWidget {

  final ValueChanged<String> onOtpCodeChanged;

  const OtpTextField({
    this.onOtpCodeChanged,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 30.0),
      child: PinCodeTextField(
        appContext: context,
        // pastedTextStyle: TextStyle(
        //   color: AppColors.ACCENT_COLOR,
        //   fontWeight: FontWeight.bold,
        // ),
        length: 4,
        autoFocus: true,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10),
          borderWidth: 0.5,
          fieldWidth: 65.0,
          fieldHeight: 55.0,
          selectedColor: AppColors.GREY_COLOR,
          activeColor: AppColors.GREY_COLOR,
          inactiveColor: AppColors.GREY_COLOR,
        ),
        // textStyle: AppStyles.,
        textStyle: TextStyle(
            fontSize: 18.0,
            color: AppColors.BLUE_COLOR,
            fontFamily: AppFonts.POPPINS_MEDIUM,
            fontWeight: FontWeight.w400),
        cursorColor:  AppColors.ACCENT_COLOR,
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // onSubmitted: (otp){
        //   onOtpCodeChanged(otp);
        // },
        onCompleted: (otp){
          onOtpCodeChanged(otp);
        },
        // enableActiveFill: true,
        // errorAnimationController: errorController,
        //controller: otpController,
        keyboardType: TextInputType.number,
        beforeTextPaste: (text) {
          print("Allowing to paste $text");
          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //but you can show anything you want here, like your pop up saying wrong paste format or etc
          return false;
        },
      ),
    );
  }
}