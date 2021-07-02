import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_constants.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:ampd/widgets/custom_text_form.dart';
import 'package:ampd/widgets/dialog_view.dart';
import 'package:ampd/widgets/rating_dialog_view.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:ampd/widgets/otp_text_field.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart';
import 'package:sizer/sizer.dart';

import '../appresources/app_colors.dart';
import '../appresources/app_colors.dart';
import '../appresources/app_strings.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nPasswordController = new TextEditingController();
  TextEditingController cPasswordController = new TextEditingController();

  int numberValidation = AppConstants.PHONE_VALIDATION;
  int emailValidation = AppConstants.EMAIL_VALIDATION;
  int passwordValidation = AppConstants.PASSWORD_VALIDATION;
  int nPasswordValidation = AppConstants.PASSWORD_VALIDATION;
  int cPasswordValidation = AppConstants.PASSWORD_VALIDATION;

  bool _enabled = true;
  bool _enabled1 = true;
  bool _enabled2 = true;

  var emailFocus = FocusNode();
  var passwordNode = FocusNode();
  var nPasswordNode = FocusNode();
  var cPasswordNode = FocusNode();

  String email = "";
  String password = "";
  String nPassword = "";
  String cPassword = "";
  String phoneNo = "";

  bool _isEmailValid = false;
  bool obscureText = true;
  bool nPasswordObscureText = true;
  bool cPasswordObscureText = true;

  IconData checkIconData = Icons.check;
  IconData iconData = Icons.visibility_off;
  IconData iconData1 = Icons.visibility_off;
  IconData iconData2 = Icons.visibility_off;

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
                      AppStrings.SIGN_IN,
                      style:
                          AppStyles.blackWithBoldFontTextStyle(context, 20.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                              child: Text(
                            AppStrings.ALREADY_HAVE_AN_ACCOUNT,
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
                              showForgetBottomSheet(context);
                            },
                            child: Text(
                              AppStrings.FORGET_PASSWORD,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: AppColors.COLOR_BLACK,
                                  fontFamily: AppFonts.POPPINS_MEDIUM,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 25.0,
                    ),
                    GradientButton(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.DASHBOARD_VIEW, (route) => false, arguments: false);
                        /*  showDialog(
                            context: context,
                            builder: (BuildContext context1) {
                              return CustomRatingDialog(
                                contex: context,
                                subTitle: "How was Starbucks?",
                                //title: "Your feedback will help us improve our services.",
                                buttonText1: AppStrings.SUBMIT,
                                onPressed1: () {
                                  Navigator.pop(context1);
                                },
                                showImage: false,
                              );
                            });*/
                      },
                      text: AppStrings.LOGIN_TO_MY_ACCOUNT,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    ButtonBorder(
                      onTap: () {
                        showPhoneNoBottomSheet(context);
                      },
                      text: AppStrings.CREATE_AN_ACCOUNT,
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  showForgetBottomSheet(BuildContext context) {
    showBottomSheetWidget(context, "Forgot password",
        AppStrings.PHONE_NUMBER_DESC, customWidget(context), (bc) {
      Navigator.pop(bc);
      showOtp2BottomSheet(context);
    }, AppStrings.RECOVER_NOW, false);
  }

  showOtp2BottomSheet(BuildContext context) {
    showBottomSheetWidget(context, AppStrings.ENTER_OTP_DIGIT,
        AppStrings.OTP_DESC, OtpTextField(), (bc1) {
      Navigator.pop(bc1);
      showResetPasswordBottomSheet(context);
    }, AppStrings.VERIFY_NOW, true);
  }

  showResetPasswordBottomSheet(BuildContext context) {
    showBottomSheetWidget(
        context,
        AppStrings.PASSWORD_RESET_TITLE,
        AppStrings.OTP_DESC,
        Column(
          children: [
            newPasswordTextField(context),
            SizedBox(
              height: 20.0,
            ),
            confirmPasswordTextField(context),
          ],
        ), (bc2) {
      Navigator.pop(bc2);
      print("submit");
    }, AppStrings.UPDATE_PASSWORD, false);
  }

  showPhoneNoBottomSheet(BuildContext context) {
    showBottomSheetWidget(context, AppStrings.PHONE_NUMBER_TITLE,
        AppStrings.PHONE_NUMBER_DESC, customWidget(context), (bc3) {
      Navigator.pop(bc3);
      showOtpBottomSheet(context);
    }, AppStrings.SUBMIT, false);
  }

  showOtpBottomSheet(BuildContext context) {
    showBottomSheetWidget(context, AppStrings.ENTER_OTP_DIGIT,
        AppStrings.OTP_DESC, OtpTextField(), (bc4) {
      Navigator.pop(bc4);
      Navigator.pushNamed(context, AppRoutes.CREATE_AN_ACCOUNT_VIEW);
    }, AppStrings.VERIFY_NOW, true);
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
              textInputAction: TextInputAction.done,
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
                color: AppColors.LIGHT_GREY_TEXT_COLOR,
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
                  phoneNo = newVal;
                } else {
                  numberController.value = new TextEditingValue(
                      text: phoneNo,
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
              keyboardType: TextInputType.number,
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
                  AppStyles.decorationWithBorder(AppStrings.PHONE_NUMBER),
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

  Widget newPasswordTextField(BuildContext context) {
    return StatefulBuilder(
      builder: (ctx, setStates) {
        return Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              child: Focus(
                onFocusChange: (value) {
                  if (value) {
                    nPasswordController.selection = TextSelection.fromPosition(
                        TextPosition(offset: cPasswordController.text.length));
                  }
                },
                child: TextFormField(
//                                enableInteractiveSelection: false,
                  enabled: _enabled1,
                  focusNode: nPasswordNode,
                  cursorColor: AppColors.ACCENT_COLOR,
                  onChanged: (String newVal) {
                    if (newVal.length <= nPasswordValidation) {
                      password = newVal;
                    } else {
                      nPasswordController.value = new TextEditingValue(
                          text: password,
                          selection: new TextSelection(
                              baseOffset: nPasswordValidation,
                              extentOffset: nPasswordValidation,
                              affinity: TextAffinity.downstream,
                              isDirectional: false),
                          composing: new TextRange(
                              start: 0, end: nPasswordValidation));
                      //  _emailController.text = text;
                    }
                  },
                  controller: nPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(nPasswordValidation),
                  ],
                  onEditingComplete: () =>
                      FocusScope.of(context).requestFocus(cPasswordNode),
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(cPasswordNode),
                  obscureText: nPasswordObscureText,
                  textInputAction: TextInputAction.next,
                  decoration:
                      AppStyles.decorationWithBorder(AppStrings.NEW_PASSWORD),
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
                    iconData1,
                    color: AppColors.LIGHT_GREY_TEXT_COLOR,
                  ),
                  onPressed: () {
                    if (_enabled1) {
                      setStates(() {
                        if (nPasswordObscureText) {
                          nPasswordObscureText = false;
                          iconData1 = Icons.visibility;
                        } else {
                          nPasswordObscureText = true;
                          iconData1 = Icons.visibility_off;
                        }
                      });
                    }
                  }),
            ),
          ],
        );
      },
    );
  }

  Widget confirmPasswordTextField(BuildContext context) {
    return StatefulBuilder(
      builder: (ctx, setStates) {
        return Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              child: Focus(
                onFocusChange: (value) {
                  if (value) {
                    cPasswordController.selection = TextSelection.fromPosition(
                        TextPosition(offset: cPasswordController.text.length));
                  }
                },
                child: TextFormField(
//                                enableInteractiveSelection: false,
                  enabled: _enabled2,
                  focusNode: cPasswordNode,
                  cursorColor: AppColors.ACCENT_COLOR,
                  onChanged: (String newVal) {
                    if (newVal.length <= cPasswordValidation) {
                      password = newVal;
                    } else {
                      cPasswordController.value = new TextEditingValue(
                          text: password,
                          selection: new TextSelection(
                              baseOffset: cPasswordValidation,
                              extentOffset: cPasswordValidation,
                              affinity: TextAffinity.downstream,
                              isDirectional: false),
                          composing: new TextRange(
                              start: 0, end: cPasswordValidation));
                      //  _emailController.text = text;
                    }
                  },
                  controller: cPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(cPasswordValidation),
                  ],
                  /*onEditingComplete: () => FocusScope.of(context).requestFocus(cPasswordNode),
                          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(cPasswordNode),*/
                  obscureText: cPasswordObscureText,
                  textInputAction: TextInputAction.next,
                  decoration: AppStyles.decorationWithBorder(
                      AppStrings.RE_ENTER_PASSWORD),
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
                    iconData2,
                    color: AppColors.LIGHT_GREY_TEXT_COLOR,
                  ),
                  onPressed: () {
                    if (_enabled2) {
                      setStates(() {
                        if (cPasswordObscureText) {
                          cPasswordObscureText = false;
                          iconData2 = Icons.visibility;
                        } else {
                          cPasswordObscureText = true;
                          iconData2 = Icons.visibility_off;
                        }
                      });
                    }
                  }),
            ),
          ],
        );
      },
    );
  }
}
