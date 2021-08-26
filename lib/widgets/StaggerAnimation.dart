
import 'package:flutter/material.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_styles.dart';

class StaggerAnimation extends StatelessWidget {
  final VoidCallback onTap;
  final String titleButton;

  StaggerAnimation({
    Key key,
    this.buttonController,
    this.onTap,
    this.titleButton = "Sign In",
  })  : buttonSqueezeanimation = Tween(
    begin: 350.0,
    end: 65.0,
  ).animate(
    CurvedAnimation(
      parent: buttonController,
      curve: const Interval(
        0.0,
        0.150,
      ),
    ),
  ),
        containerCircleAnimation = EdgeInsetsTween(
          begin: const EdgeInsets.only(bottom: 30.0),
          end: const EdgeInsets.only(bottom: 0.0),
        ).animate(
          CurvedAnimation(
            parent: buttonController,
            curve: const Interval(
              0.500,
              0.800,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final AnimationController buttonController;
  final Animation<EdgeInsets> containerCircleAnimation;
  final Animation buttonSqueezeanimation;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonSqueezeanimation.value,
        padding:  const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey,
          //     offset: Offset(0.0, 1.0), //(x,y)
          //     blurRadius: 2.0,
          //   ),
          // ],
          borderRadius: buttonSqueezeanimation.value < 75.0 ? BorderRadius.circular(40.0) : BorderRadius.circular(10.0),
          color: AppColors.ACCENT_COLOR,
        ),
        child: buttonSqueezeanimation.value > 75.0
            ? Center(
              child: Text(titleButton,
                style: AppStyles.inputTextStyleWithPoppinsBold().copyWith(
                  letterSpacing: 0.3
                ),
        ),
            )
            : Container(

              child: const CircularProgressIndicator(
          value: null,
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: buttonController,
    );
  }
}
