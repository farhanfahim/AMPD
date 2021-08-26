
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
            gradient: LinearGradient(colors: [Color(0xff174EA0), Color(0xff1E70C6), Color(0xff2490E9)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          borderRadius: buttonSqueezeanimation.value < 75.0 ? BorderRadius.circular(40.0) : BorderRadius.circular(10.0),
          color: AppColors.ACCENT_COLOR,
        ),
        child: buttonSqueezeanimation.value > 75.0
            ? Center(
              child: Text(titleButton,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
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
