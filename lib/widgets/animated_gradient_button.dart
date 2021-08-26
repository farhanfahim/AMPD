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
      child: StaggerAnimation(
        titleButton: text,
        buttonController: buttonController.view,
        onTap: onAnimationTap,
      ),
    );
  }
}
