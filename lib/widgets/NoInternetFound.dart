import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoInternetFound extends StatelessWidget {
  BuildContext context;
  ValueChanged<BuildContext> onPressed;
  NoInternetFound(this. context, this.onPressed);

  @override
  Widget build(BuildContext bc) {
    return Container(
      width: MediaQuery.of(bc).size.width,
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
              style: AppStyles.detailWithSmallTextSizeTextStyle(),
              textAlign: TextAlign.center,
            )
          ),

          SizedBox(
            height: 20,
          ),
          GradientButton(
            onTap: (){onPressed(bc);},
            text: "Try Again",

          ),
        ],
      ),
    );
  }
}
