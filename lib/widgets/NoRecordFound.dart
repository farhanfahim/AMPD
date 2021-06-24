import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoRecordFound extends StatelessWidget {
  final String msg;
  final String image;

  NoRecordFound(this.msg,this.image);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SvgPicture.asset(
              image,
              width: 240.0,
              height: 100.0,
              matchTextDirection: true,
            ),

            // Image.asset(image, width: 240.0, height: 100.0,),

            SizedBox(
              height: 20,
            ),
            Text(
              msg.isEmpty? "No Record Found!":msg,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppFonts.SF_PRO_FONT_BOLD,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.ACCENT_COLOR,
              ),
            )
          ],
        ),
      ),
    );
  }
}
