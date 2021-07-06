import 'package:ampd/appresources/app_colors.dart';
import 'package:flutter/material.dart';

class FlatButtonWidget extends StatelessWidget {
  final Function onTap;
  final String text;
  final Color color;

  const FlatButtonWidget(
      {
      this.onTap,
      this.text,
      this.color});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 25.0,
        width: 80.0,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: Container(
          constraints: BoxConstraints(maxWidth: 80.0, minHeight: 25.0),
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
              fontWeight: FontWeight.w200,
            ).copyWith(fontSize: 9.0),
          ),
        ),
      ),
    );
  }
}
