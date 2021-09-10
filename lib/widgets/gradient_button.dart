import 'package:ampd/appresources/app_colors.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final Function onTap;
  final String text;

  const GradientButton(
      {
      this.onTap,
      this.text});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        height: 50.0,
        width: 350.0,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xff174EA0), Color(0xff1E70C6), Color(0xff2490E9)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(10.0)
        ),
        child: Container(
          constraints: BoxConstraints(maxWidth: 350.0, minHeight: 50.0),
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
