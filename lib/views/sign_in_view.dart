import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_constants.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:ampd/widgets/custom_text_form.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  int numberValidation = AppConstants.PHONE_VALIDATION;
  int emailValidation = AppConstants.EMAIL_VALIDATION;
  int passwordValidation = AppConstants.PASSWORD_VALIDATION;

  bool _enabled = true;

  var emailFocus = FocusNode();
  var passwordNode = FocusNode();

  String email = "";
  String password = "";
  String phoneNo = "";

  bool _isEmailValid = false;
  bool obscureText = true;

  IconData checkIconData = Icons.check;
  IconData iconData = Icons.visibility_off;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // call this method here to hide soft keyboard
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
          backgroundColor: AppColors.WHITE_COLOR,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 30.0.h,
                      margin: EdgeInsets.fromLTRB(0.0, 30.0, 0, 0),
                      child: Center(
                        child: SvgPicture.asset(
                          AppImages.MAIN_LOGO,
                        ),
                      ),
                    ),
                    Text(
                      "Sign In",
                      style:
                          AppStyles.blackWithBoldFontTextStyle(context, 20.0),
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
                    customEmailTextField(context),
                    SizedBox(
                      height: 20.0,
                    ),
                    customPasswordTextField(context),
                    SizedBox(
                      height: 25.0,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25.0,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              showBottomSheetWidget(
                                  context,
                                  "Forgot password",
                                  AppStrings.PHONE_NUMBER_DESC,
                                  customWidget(context), () {
                                print("submit");
                              }, AppStrings.RECOVER_NOW);
                            },
                            child: Text(
                              AppStrings.FORGET_PASSWORD,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: AppColors.COLOR_BLACK,
                                  fontFamily: AppFonts.POPPINS_MEDIUM,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 25.0,
                    ),
                    GradientButton(
                      onTap: () {},
                      text: AppStrings.LOGIN_TO_MY_ACCOUNT,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    ButtonBorder(
                      onTap: () {
                        showBottomSheetWidget(
                            context,
                            AppStrings.PHONE_NUMBER_TITLE,
                            AppStrings.PHONE_NUMBER_DESC,
                            customWidget(context), () {
                          showBottomSheetWidget(
                              context,
                              AppStrings.ENTER_OTP_DIGIT,
                              AppStrings.OTP_DESC,
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 50.0),
                                child: PinCodeTextField(
                                  appContext: context,
                                  // pastedTextStyle: TextStyle(
                                  //   color: AppColors.ACCENT_COLOR,
                                  //   fontWeight: FontWeight.bold,
                                  // ),
                                  length: 4,
                                  animationType: AnimationType.fade,
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.underline,
                                    // borderRadius: BorderRadius.circular(5),
                                    selectedColor: AppColors.ACCENT_COLOR,
                                    activeColor: AppColors.APP_MAIN_SPLASH_COLOR_DARK,
                                    inactiveColor: AppColors.APP_MAIN_SPLASH_COLOR_DARK,
                                  ),
                                  // textStyle: AppStyles.,
                                  textStyle: AppStyles.inputTextStyle(context),
                                  cursorColor:  AppColors.ACCENT_COLOR,
                                  animationDuration: Duration(milliseconds: 300),
                                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                  // enableActiveFill: true,
                                  // errorAnimationController: errorController,
                                 // controller: controller1,
                                  keyboardType: TextInputType.number,
                                  beforeTextPaste: (text) {
                                    print("Allowing to paste $text");
                                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                    return false;
                                  },
                                ),
                              ), () {
                            print("submit");
                          }, AppStrings.SUBMIT);
                        }, AppStrings.SUBMIT);
                      },
                      text: AppStrings.CREATE_AN_ACCOUNT,
                    ),
                    SizedBox(
                      height: 50.0,
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Stack customEmailTextField(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.0),
          child: Focus(
            onFocusChange: (value) {
              if (value) {
                emailController.selection = TextSelection.fromPosition(
                    TextPosition(offset: emailController.text.length));
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
                      composing: new TextRange(start: 0, end: emailValidation));
                  //  _emailController.text = text;
                }
              },
              controller: emailController,
              keyboardType: TextInputType.visiblePassword,
              inputFormatters: [
                LengthLimitingTextInputFormatter(emailValidation),
              ],
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(passwordNode),

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
              decoration:
                  AppStyles.decorationWithBorder(AppStrings.EMAIL_ADDRESS),
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
    );
  }

  Stack customPasswordTextField(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.0),
          child: Focus(
            onFocusChange: (value) {
              if (value) {
                passwordController.selection = TextSelection.fromPosition(
                    TextPosition(offset: passwordController.text.length));
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
                      composing:
                          new TextRange(start: 0, end: passwordValidation));
                  //  _emailController.text = text;
                }
              },
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              inputFormatters: [
                LengthLimitingTextInputFormatter(passwordValidation),
              ],
              /*onEditingComplete: () => FocusScope.of(context).requestFocus(confirmPasswordNode),
                          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(confirmPasswordNode),*/
              obscureText: obscureText,
              textInputAction: TextInputAction.next,
              decoration: AppStyles.decorationWithBorder(AppStrings.PASSWORD),
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
    );
  }

  Stack customWidget(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.0),
          child: Focus(
            onFocusChange: (value) {
              if (value) {
                numberController.selection = TextSelection.fromPosition(
                    TextPosition(offset: numberController.text.length));
              }
            },
            child: TextFormField(
//                                enableInteractiveSelection: false,
              enabled: _enabled,
              cursorColor: AppColors.ACCENT_COLOR,
              onChanged: (String newVal) {
                if (newVal.length <= numberValidation) {
                  email = newVal;
                } else {
                  numberController.value = new TextEditingValue(
                      text: email,
                      selection: new TextSelection(
                          baseOffset: numberValidation,
                          extentOffset: numberValidation,
                          affinity: TextAffinity.downstream,
                          isDirectional: false),
                      composing:
                          new TextRange(start: 0, end: numberValidation));
                  //  _emailController.text = text;
                }
              },
              controller: numberController,
              keyboardType: TextInputType.visiblePassword,
              inputFormatters: [
                LengthLimitingTextInputFormatter(numberValidation),
              ],

              onFieldSubmitted: (texttt) {
                /*final regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
                                if (regExp.hasMatch(phoneNo)) {
                                  _isEmailValid = true;
                                } else {
                                  _isEmailValid = false;
                                }*/
              },
              textInputAction: TextInputAction.next,
              decoration:
                  AppStyles.decorationWithBorder(AppStrings.EMAIL_ADDRESS),
              //   , iconData, (){
              //
              // }),
              style: AppStyles.inputTextStyle(context),
            ),
          ),
        ),
      ],
    );
  }
}
