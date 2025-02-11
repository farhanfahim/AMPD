import 'package:ampd/appresources/app_colors.dart';
import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final Function onTap;
  final Widget icon;
  final double containerRadius;
  final EdgeInsets padding;
  final Color backColor;
  final Color splashColor;

  const CircularIconButton(
      {this.icon,
      this.onTap,
      this.containerRadius = 40,
      this.backColor = Colors.black26,
      this.splashColor,
      this.padding = const EdgeInsets.all(0)});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: InkWell(
        onTap: onTap,
        child: ClipOval(
          child: Material(
            color: backColor,
            // button color
            child: InkWell(
              splashColor: backColor == AppColors.kBlueColorWithOpacity
                  ? backColor
                  : splashColor, // inkwell color
              child: SizedBox(
                  width: containerRadius, height: containerRadius, child: icon),
              onTap: onTap,
            ),
          ),

        ),
      ),


    );
  }
}
