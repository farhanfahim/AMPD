import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/utils/Util.dart';
import 'package:ampd/widgets/StaggerAnimation.dart';
import 'package:flutter/material.dart';

class AnimatedGradientButton extends StatelessWidget {
  final Function onTap;
  final Function onAnimationTap;
  final AnimationController buttonController;
  final String text;

  const AnimatedGradientButton(
      {
      this.onTap,
      this.onAnimationTap,
      this.buttonController,
      this.text});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
     /* child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        height: 50.0,
        width: double.maxFinite,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xff174EA0), Color(0xff1E70C6), Color(0xff2490E9)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(10.0)
        ),
        child: Container(
          constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
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
      ),*/
      child: StaggerAnimation(
        titleButton: text,
        buttonController: buttonController.view,
        onTap: onAnimationTap,
      ),
    );
  }
}
