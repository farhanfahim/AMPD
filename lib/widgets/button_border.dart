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
   /* return Container(
      height: 50.0,
      child: RaisedButton(
        onPressed: onTap,
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        color: AppColors.WHITE_COLOR,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: AppColors.WHITE_BLUE)),


        padding: EdgeInsets.all(0.0),
        child: Ink(
          child: Container(
            constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.WHITE_BLUE
              ),
            ),
          ),
        ),
      ),
    );*/

    return GestureDetector(
      onTap: onTap,

      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        height: 50.0,
        width: double.maxFinite,
        child: Container(
          constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
          alignment: Alignment.center,
          decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder (
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                      width: 1.5,
                      color: AppColors.BLUE_COLOR
                  )
              )
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.BLUE_COLOR
            ),
          ),
        ),
      ),
    );
  }
}
