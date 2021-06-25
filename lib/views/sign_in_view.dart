import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_constants.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:ampd/widgets/custom_text_form.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  int emailValidation = AppConstants.EMAIL_VALIDATION;
  int passwordValidation = AppConstants.PASSWORD_VALIDATION;

  bool _enabled = true;

  var emailFocus = FocusNode();
  var passwordNode = FocusNode();

  String email = "";
  String password = "";

  bool _isEmailValid = false;
  bool obscureText = true;

  IconData checkIconData = Icons.check;
  IconData iconData = Icons.visibility_off;

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
                  Text(
                    "Sign In",
                    style: AppStyles.blackWithBoldFontTextStyle(context, 20.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .23),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            child: Text(
                          "Already have an account, sign in to continue!",
                          style: AppStyles.detailWithSmallTextSizeTextStyle(),
                          textAlign: TextAlign.center,
                        )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25.0),
                        child: Focus(
                          onFocusChange: (value) {
                            if (value) {
                              emailController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset: emailController.text.length));
                            }
                          },
                          child: TextFormField(
//                                enableInteractiveSelection: false,
                            enabled: _enabled,
                            focusNode: emailFocus,
                            cursorColor: AppColors.ACCENT_COLOR,
                            onChanged: (String newVal) {
                              if (newVal.length <= emailValidation) {
                                email = newVal;
                              } else {
                                emailController.value = new TextEditingValue(
                                    text: email,
                                    selection: new TextSelection(
                                        baseOffset: emailValidation,
                                        extentOffset: emailValidation,
                                        affinity: TextAffinity.downstream,
                                        isDirectional: false),
                                    composing: new TextRange(
                                        start: 0, end: emailValidation));
                                //  _emailController.text = text;
                              }
                            },
                            controller: emailController,
                            keyboardType: TextInputType.visiblePassword,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(emailValidation),
                            ],
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(passwordNode),

                            onFieldSubmitted: (texttt) {
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(email);
                              if (emailValid) {
                                _isEmailValid = true;
                              } else {
                                _isEmailValid = false;
                              }
                              FocusScope.of(context).requestFocus(passwordNode);
                            },
                            textInputAction: TextInputAction.next,
                            decoration: AppStyles.decorationWithBorder(
                                AppStrings.EMAIL_ADDRESS),
                            //   , iconData, (){
                            //
                            // }),
                            style: AppStyles.inputTextStyle(context),
                          ),
                        ),
                      ),
                      _isEmailValid
                          ? Positioned(
                              top: 5.0,
                              bottom: 0.0,
                              right: 35.0,
                              child: Icon(
                                checkIconData,
                                color: AppColors.BLUE_COLOR,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25.0),
                        child: Focus(
                          onFocusChange: (value) {
                            if (value) {
                              passwordController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset: passwordController.text.length));
                            }
                          },
                          child: TextFormField(
//                                enableInteractiveSelection: false,
                            enabled: _enabled,
                            focusNode: passwordNode,
                            cursorColor: AppColors.ACCENT_COLOR,
                            onChanged: (String newVal) {
                              if (newVal.length <= passwordValidation) {
                                password = newVal;
                              } else {
                                passwordController.value = new TextEditingValue(
                                    text: password,
                                    selection: new TextSelection(
                                        baseOffset: passwordValidation,
                                        extentOffset: passwordValidation,
                                        affinity: TextAffinity.downstream,
                                        isDirectional: false),
                                    composing: new TextRange(
                                        start: 0, end: passwordValidation));
                                //  _emailController.text = text;
                              }
                            },
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                  passwordValidation),
                            ],
                            /*onEditingComplete: () => FocusScope.of(context).requestFocus(confirmPasswordNode),
                            onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(confirmPasswordNode),*/
                            obscureText: obscureText,
                            textInputAction: TextInputAction.next,
                            decoration: AppStyles.decorationWithBorder(
                                AppStrings.PASSWORD),
                            //   , iconData, (){
                            //
                            // }),
                            style: AppStyles.inputTextStyle(context),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5.0,
                        bottom: 0.0,
                        right: 25.0,
                        child: IconButton(
                            icon: Icon(
                              iconData,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              if (_enabled) {
                                setState(() {
                                  if (obscureText) {
                                    obscureText = false;
                                    iconData = Icons.visibility;
                                  } else {
                                    obscureText = true;
                                    iconData = Icons.visibility_off;
                                  }
                                });
                              }
                            }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0,),
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Forgot password?',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 14.0,

                              color: AppColors.COLOR_BLACK,
                              fontFamily: AppFonts.POPPINS_MEDIUM,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    )
                  ),

                  SizedBox(
                    height: 25.0,
                  ),
                  GradientButton(
                    onTap: () {},
                    text: "Login to my Account",
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  ButtonBorder(
                    onTap: () {},
                    text: "Create an Account",
                  ),
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
