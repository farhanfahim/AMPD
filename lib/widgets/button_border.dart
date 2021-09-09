import 'package:ampd/appresources/app_colors.dart';
import 'package:flutter/material.dart';

class ButtonBorder extends StatelessWidget {
  final Function onTap;
  final String text;

  const ButtonBorder(
      {
      this.onTap,
      this.text});
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,

      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        height: 47.0,
        width: double.maxFinite,
        child: Container(
          constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
          alignment: Alignment.center,
          decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder (
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                      width: 0.5,
                      color: AppColors.BLUE_COLOR
                  )
              )
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.BLUE_COLOR,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
