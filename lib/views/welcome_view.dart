import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeView extends StatefulWidget {
  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.WHITE_COLOR,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  SizedBox(
                    height: 200.0,
                  ),
                  SvgPicture.asset(
                    AppImages.MAIN_LOGO,
                  ),

                  SizedBox(
                    height: 70.0,
                  ),

                  SizedBox(
                    height: 50.0,
                  ),

                  Text("Get Started",style: AppStyles.blackWithBoldFontTextStyle(context, 20.0),),


                  SizedBox(
                    height: 30.0,
                  ),


                  Container(
                    margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .2),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(child: Text("Create account or sign in to start saving!",style: AppStyles.detailWithSmallTextSizeTextStyle(),textAlign: TextAlign.center,)),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 30.0,
                  ),
                  GradientButton(onTap:(){},text: "Create Account",),
                  SizedBox(
                    height: 15.0,
                  ),
                  ButtonBorder(onTap:(){
                    Navigator.pushNamed(context, AppRoutes.SIGN_IN_VIEW);
                  },text: "Sign In",),
                  SizedBox(
                    height: 15.0,
                  ),
                  ButtonBorder(onTap:(){},text: "Guest Log In",),
                  SizedBox(
                    height: 50.0,
                  )

                ],
              ),
            ),
          ),
        ));
  }
}
