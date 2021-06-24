import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoInternetFound extends StatelessWidget {

  Function onPressed;
  BuildContext context;

  NoInternetFound(this. context, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SvgPicture.asset(
            AppImages.NO_INTERNET_IMAGE,
            width: 100.0,
            height: 100.0,
            matchTextDirection: true,
          ),

         // Image.asset(AppImages.NO_INTERNET_IMAGE, scale: 2.5,),

          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
             "No Internet Connectivity! \nPlease check your internet connection and Try Again.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppFonts.SF_PRO_FONT_BOLD,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.ACCENT_COLOR,
              ),
            ),
          ),

          SizedBox(
            height: 20,
          ),

          Container(
            width: 150.0,
              child: button(context: context,title: "Try Again", onTap: onPressed))
        ],
      ),
    );
  }
}
