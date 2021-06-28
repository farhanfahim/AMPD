import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

class OtpTextField extends StatelessWidget {
  const OtpTextField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: PinCodeFields(
        padding: EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
        length: 4,
        fieldBorderStyle: FieldBorderStyle.Square,
        responsive: false,
        fieldHeight: 55.0,
        fieldWidth: 65.0,
        borderWidth: 1.0,
        activeBorderColor: AppColors.GREY_COLOR,
        /*activeBackgroundColor: Colors.pink.shade100,*/
        borderRadius: BorderRadius.circular(10.0),
        keyboardType: TextInputType.number,
        autoHideKeyboard: false,
        fieldBackgroundColor: AppColors.WHITE_COLOR,
        borderColor: AppColors.GREY_COLOR,
        textStyle: TextStyle(
            fontSize: 18.0,
            color: AppColors.BLUE_COLOR,
            fontFamily: AppFonts.POPPINS_MEDIUM,
            fontWeight: FontWeight.w400),
        onComplete: (output) {
          // Your logic with pin code
          print(output);
        },
      ),
    );
  }
}