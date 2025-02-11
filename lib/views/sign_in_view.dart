import 'package:ampd/app/app.dart';
import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_constants.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/data/model/login_response_model.dart';
import 'package:ampd/utils/ToastUtil.dart';
import 'package:ampd/utils/Util.dart';
import 'package:ampd/viewmodel/login_viewmodel.dart';
import 'package:ampd/widgets/animated_gradient_button.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:ampd/widgets/otp_text_field.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:sizer/sizer.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../appresources/app_colors.dart';
import '../appresources/app_strings.dart';
import 'dart:async';
class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> with TickerProviderStateMixin {
  String initialCountry = 'US';
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  bool isValidate = false;
  bool isValidate2 = false;
  FirebaseMessaging _firebaseMessaging;
  BuildContext forgetPasswordBc;
  BuildContext otpPasswordBc;
  BuildContext passwordBc;
  BuildContext submitPhoneBc;
  LoginViewModel _loginViewModel;
  Timer _timer1;
  int _sec = 3;
  bool isForgetPasswordFlow = false;

  TextEditingController emailController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nPasswordController = new TextEditingController();
  TextEditingController cPasswordController = new TextEditingController();

  AnimationController _loginButtonController;
  AnimationController _recoverButtonController;
  AnimationController _verifyButtonController;
  AnimationController _updatePasswordButtonController;
  AnimationController _submitButtonController;

  int numberValidation = AppConstants.PHONE_VALIDATION;
  int phoneNumberValidation = AppConstants.PHONE_VALIDATION;
  int emailValidation = AppConstants.EMAIL_VALIDATION;
  int passwordValidation = AppConstants.PASSWORD_VALIDATION;
  int nPasswordValidation = AppConstants.PASSWORD_VALIDATION;
  int cPasswordValidation = AppConstants.PASSWORD_VALIDATION;

  bool _enabled = true;


  var phoneNumberFocus = FocusNode();
  var emailFocus = FocusNode();
  var passwordNode = FocusNode();
  var nPasswordNode = FocusNode();
  var cPasswordNode = FocusNode();

  String email = "";
  String password = "";
  String nPassword = "";
  String cPassword = "";
  String phoneNo = "";
  String phoneNo2 = "";
  String code = "";

  bool _isEmailValid = false;
  bool obscureText = true;
  bool nPasswordObscureText = true;
  bool cPasswordObscureText = true;

  IconData checkIconData = Icons.check;
  IconData iconData = Icons.visibility_off;
  IconData iconData1 = Icons.visibility_off;
  IconData iconData2 = Icons.visibility_off;
  bool flag = true;

  String _loginPlatform;
  bool _isInternetAvailable = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // call this method here to hide soft keyboard
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
          backgroundColor: AppColors.WHITE_COLOR,
          body: KeyboardActions(
              tapOutsideToDismiss: true,

              config: KeyboardActionsConfig(
                keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
                keyboardBarColor: Colors.grey[500],
                nextFocus: false,
                actions: [
                  KeyboardActionsItem(
                    focusNode: phoneNumberFocus,
                  ),


                  // KeyboardActionsItem(
                  //   focusNode: handicapIndexNode,
                  // ),
                ],
              ),
              child: SafeArea(
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
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25.0),
                      decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                  width: 0.5, color: AppColors.LIGHT_GREY_ARROW_COLOR))),
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          print(number.phoneNumber);
                          phoneNo2 = number.phoneNumber;
                        },
                        onInputValidated: (bool value) {
                          print(value);
                          setState(() {
                            isValidate = value;
                          });
                        },
                        selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          showFlags: false
                        ),
                        formatInput: false,
                        initialValue: number,
                        ignoreBlank: false,
                        selectorTextStyle: TextStyle(
                            fontSize: 12.0,
                            color: AppColors.COLOR_BLACK,
                            fontFamily: AppFonts.POPPINS_MEDIUM,
                            fontWeight: FontWeight.w400),
                        autoValidateMode: AutovalidateMode.disabled,
                        textFieldController: phoneNumberController,
                        inputDecoration:
                        AppStyles.decorationWithoutBorder("Phone Number"),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    customPasswordTextField(context),
                    SizedBox(
                      height: 20.0,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25.0,
                          ),
                          child: Container(
                            color: AppColors.WHITE_COLOR,
                            padding: const EdgeInsets.fromLTRB(0.0,5.0,0.0,5.0),
                            child: GestureDetector(
                              onTap: () {
                                numberController.clear();
                                showForgetBottomSheet(context);
                                setState(() {
                                  isForgetPasswordFlow = true;
                                });
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
                          ),
                        )),
                    SizedBox(
                      height: 20.0,
                    ),
                    AnimatedGradientButton(
                      onAnimationTap: () {
                        if (flag) {
                          if (validate()) {
                            Util.check().then((value) {
                              if (value != null && value) {
                                // Internet Present Case
                                setState(() {
                                  flag = true;
                                  _isInternetAvailable = true;
                                });
                                if (phoneNo2.isNotEmpty) {
                                  if (isValidate) {
                                    if (password.isNotEmpty) {
                                      if (password.length > 7) {
                                        callLoginApi();
                                      } else {
                                        setState(() {
                                          flag = true;
                                        });
                                        ToastUtil.showToast(
                                            context, "Password is too short");
                                      }
                                    } else {
                                      setState(() {
                                        flag = true;
                                      });
                                      ToastUtil.showToast(
                                          context, "Please enter your password");
                                    }
                                  } else {
                                    setState(() {
                                      flag = true;
                                    });
                                    ToastUtil.showToast(context, "Invalid phone number");
                                  }

                                } else {
                                  setState(() {
                                    flag = true;
                                  });
                                  ToastUtil.showToast(
                                      context, "Please enter phone number");
                                }
                              } else {
                                setState(() {
                                  flag = true;
                                  _isInternetAvailable = false;
                                  ToastUtil.showToast(context, "No internet");
                                });
                              }
                            });
                          }
                        }
                      },
                      buttonController: _loginButtonController,
                      text: AppStrings.LOGIN_TO_MY_ACCOUNT,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    ButtonBorder(
                      onTap: () {
                        numberController.clear();
                        showPhoneNoBottomSheet(context);
                        setState(() {
                          isForgetPasswordFlow = false;
                        });
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
    ),);
  }

  @override
  void initState() {
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _recoverButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _verifyButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _updatePasswordButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _submitButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);

    _firebaseMessaging = FirebaseMessaging();
    _loginViewModel = LoginViewModel(App());
    subscribeToViewModel();
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    _recoverButtonController.dispose();
    _verifyButtonController.dispose();
    _updatePasswordButtonController.dispose();
    _submitButtonController.dispose();

    super.dispose();
  }

  showForgetBottomSheet(BuildContext context) {

    setState(() {
      phoneNo = "";
      isValidate = false;
      isValidate2 = false;
    });
    showBottomSheetWidgetWithAnimatedBtn(
      context,
      "Forgot Password",
      AppStrings.FORGET_PASSWORD_DESC,
      Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                    width: 0.5, color: AppColors.LIGHT_GREY_ARROW_COLOR))),
        child: InternationalPhoneNumberInput(
          onInputChanged: (PhoneNumber number) {
            print(number.phoneNumber);
            phoneNo = number.phoneNumber;
          },
          onInputValidated: (bool value) {
            print(value);
            setState(() {
              isValidate2 = value;
            });
          },
          selectorConfig: SelectorConfig(
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            showFlags: false
          ),
          formatInput: false,
          initialValue: number,
          ignoreBlank: false,
          selectorTextStyle: TextStyle(
              fontSize: 12.0,
              color: AppColors.COLOR_BLACK,
              fontFamily: AppFonts.POPPINS_MEDIUM,
              fontWeight: FontWeight.w400),
          autoValidateMode: AutovalidateMode.disabled,
          textFieldController: numberController,
          inputDecoration:
          AppStyles.decorationWithoutBorder("Phone Number"),
        ),
      ),
      AnimatedGradientButton(
        onAnimationTap: () {
          if (flag) {
            if (validate()) {
              Util.check().then((value) {
                if (value != null && value) {
                  // Internet Present Case
                  setState(() {
                    flag = true;
                    _isInternetAvailable = true;
                  });
                  if (phoneNo.isNotEmpty) {
                    if (isValidate2) {
                      callForgetPasswordApi();
                    }else{
                      setState(() {
                        flag = true;
                      });
                      ToastUtil.showToast(context, "Invalid phone number");
                    }

                  } else {
                    setState(() {
                      flag = true;
                    });
                    ToastUtil.showToast(context, "Please enter phone number");
                  }
                } else {
                  setState(() {
                    flag = true;
                    _isInternetAvailable = false;
                    ToastUtil.showToast(context, "No internet");
                  });
                }
              });
            }
          }
        },
        buttonController: _recoverButtonController,
        text: AppStrings.RECOVER_NOW,
      ),
      null,
      (bc) {
        forgetPasswordBc = bc;
      },
      AppStrings.RECOVER_NOW,
      false,
    );
  }

  showResetPasswordBottomSheet(BuildContext context) {
    showBottomSheetWidgetWithAnimatedBtn(
        context,
        AppStrings.PASSWORD_RESET_TITLE,
        AppStrings.PASSWORD_DESC,
        Column(
          children: [
            newPasswordTextField(context),
            SizedBox(
              height: 20.0,
            ),
            confirmPasswordTextField(context),
          ],
        ),
        AnimatedGradientButton(
          onAnimationTap: () {
            if (flag) {
              if (validate()) {
                Util.check().then((value) {
                  if (value != null && value) {
                    // Internet Present Case
                    setState(() {
                      flag = true;
                      _isInternetAvailable = true;
                    });
                    if (nPassword.isNotEmpty) {
                      if (nPassword.length > 7) {
                        if (cPassword.isNotEmpty) {
                          if (cPassword.length > 7) {
                            if(nPassword == cPassword){
                              callResetPasswordApi();
                            }else{
                              setState(() {
                                flag = true;
                              });
                              ToastUtil.showToast(
                                  context, "Password and password confirmation values don't match");
                            }

                          } else {
                            setState(() {
                              flag = true;
                            });
                            ToastUtil.showToast(
                                context, "Confirm password is too short");
                          }
                        } else {
                          setState(() {
                            flag = true;
                          });
                          ToastUtil.showToast(
                              context, "Please enter confirm password");
                        }
                      } else {
                        setState(() {
                          flag = true;
                        });
                        ToastUtil.showToast(
                            context, "New password is too short");
                      }
                    } else {
                      setState(() {
                        flag = true;
                      });
                      ToastUtil.showToast(context, "Please enter new password");
                    }
                  } else {
                    setState(() {
                      flag = true;
                      _isInternetAvailable = false;
                      ToastUtil.showToast(context, "No internet");
                    });
                  }
                });
              }
            }
          },
          buttonController: _updatePasswordButtonController,
          text: AppStrings.UPDATE_PASSWORD,
        ),
        null, (bc2) {
      passwordBc = bc2;
    }, AppStrings.UPDATE_PASSWORD, false);
  }

  showPhoneNoBottomSheet(BuildContext context) {
    setState(() {
      phoneNo = "";
      isValidate = false;
      isValidate2 = false;
    });
    showBottomSheetWidgetWithAnimatedBtn(
        context,
        AppStrings.PHONE_NUMBER_TITLE,
        AppStrings.PHONE_NUMBER_DESC,

        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.0),
          decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                      width: 0.5, color: AppColors.LIGHT_GREY_ARROW_COLOR))),
          child: InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              print(number.phoneNumber);
              phoneNo = number.phoneNumber;
            },
            onInputValidated: (bool value) {
              print(value);
              setState(() {
                isValidate2 = value;
              });
            },
            selectorConfig: SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              showFlags: false
            ),
            formatInput: false,
            initialValue: number,
            ignoreBlank: false,
            selectorTextStyle: TextStyle(
                fontSize: 12.0,
                color: AppColors.COLOR_BLACK,
                fontFamily: AppFonts.POPPINS_MEDIUM,
                fontWeight: FontWeight.w400),
            autoValidateMode: AutovalidateMode.disabled,
            textFieldController: numberController,
            inputDecoration:
            AppStyles.decorationWithoutBorder("Phone Number"),
          ),
        ),

        AnimatedGradientButton(
          onAnimationTap: () {
            if (flag) {
              if (validate()) {
                Util.check().then((value) {
                  if (value != null && value) {
                    // Internet Present Case
                    setState(() {
                      flag = true;
                      _isInternetAvailable = true;
                    });
                    if (phoneNo.isNotEmpty) {

                      if (isValidate2) {
                        callRegisterViaPhoneApi();
                      } else {
                        setState(() {
                          flag = true;
                        });
                        Util.hideKeyBoard(context);
                        ToastUtil.showToast(context, "Invalid phone number");
                      }

                    } else {
                      setState(() {
                        flag = true;
                      });
                      ToastUtil.showToast(context, "Please enter phone number");
                    }
                  } else {
                    setState(() {
                      flag = true;
                      _isInternetAvailable = false;
                      ToastUtil.showToast(context, "No internet");
                    });
                  }
                });
              }
            }
          },
          buttonController: _submitButtonController,
          text: AppStrings.SUBMIT,
        ),
        null, (bc3) {
      submitPhoneBc = bc3;
    }, AppStrings.SUBMIT, false);
  }

  showOtpBottomSheet(BuildContext context) {
    setState(() {
      code = "";
    });
    isForgetPasswordFlow
        ? showBottomSheetWidget(
            context, AppStrings.ENTER_OTP_DIGIT, AppStrings.OTP_DESC,
            OtpTextField(onOtpCodeChanged: (otp) {
            code = otp;
          }), () {
            if (validate()) {
              Util.check().then((value) {
                if (value != null && value) {
                  // Internet Present Case
                  setState(() {
                    flag = true;
                    _isInternetAvailable = true;
                  });
                  callForgetPasswordApi();

                } else {
                  setState(() {
                    flag = true;
                    _isInternetAvailable = false;
                    ToastUtil.showToast(context, "No internet");
                  });
                }
              });
            }
          }, (bc1) {

            if (code.isNotEmpty) {
              if (code.length == 4) {
                Navigator.pop(bc1);
                nPasswordController.clear();
                cPasswordController.clear();
                showResetPasswordBottomSheet(context);
              } else {
                setState(() {
                  flag = true;
                });
                Util.hideKeyBoard(context);
                ToastUtil.showToast(context, "Please enter valid otp code");
              }
            } else {
              setState(() {
                flag = true;
              });
              Util.hideKeyBoard(context);
              ToastUtil.showToast(context, "Please enter otp code");
            }
          }, AppStrings.VERIFY_NOW, true)


        :

    showBottomSheetWidgetWithAnimatedBtn(
            context,
            AppStrings.ENTER_OTP_DIGIT,
            AppStrings.OTP_DESC,
            OtpTextField(onOtpCodeChanged: (otp) {
              code = otp;
            }),
            AnimatedGradientButton(
              onAnimationTap: () {
                if (flag) {
                  if (validate()) {
                    Util.check().then((value) {
                      if (value != null && value) {
                        // Internet Present Case
                        setState(() {
                          flag = true;
                          _isInternetAvailable = true;
                        });
                        if (code.isNotEmpty) {
                          if (code.length == 4) {
                            callVerifyOtpApi();
                          } else {
                            setState(() {
                              flag = true;
                            });
                            Util.hideKeyBoard(context);
                            ToastUtil.showToast(context, "Please enter valid otp code");
                          }
                        } else {
                          setState(() {
                            flag = true;
                          });
                          Util.hideKeyBoard(context);
                          ToastUtil.showToast(context, "Please enter otp code");
                        }

                      } else {
                        setState(() {
                          flag = true;
                          _isInternetAvailable = false;
                          ToastUtil.showToast(context, "No internet");
                        });
                      }
                    });
                  }
                }
              },
              buttonController: _verifyButtonController,
              text: AppStrings.VERIFY_NOW,
            ),
            () {
              if (validate()) {
                Util.check().then((value) {
                  if (value != null && value) {
                    // Internet Present Case
                    setState(() {
                      flag = true;
                      _isInternetAvailable = true;
                    });
                    callRegisterViaPhoneApi();
                  } else {
                    setState(() {
                      flag = true;
                      _isInternetAvailable = false;
                      ToastUtil.showToast(context, "No internet");
                    });
                  }
                });
              }
            },
            (bc1) {
              otpPasswordBc = bc1;
            },
            AppStrings.VERIFY_NOW,
            true,
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
              toolbarOptions: ToolbarOptions(
                copy: true,
                cut: true,
                paste: false,
                selectAll: false,
              ),
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
              keyboardType: TextInputType.emailAddress,
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
                  setState(() {
                    _isEmailValid = true;
                  });
                } else {
                  setState(() {
                    _isEmailValid = false;
                  });
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
              toolbarOptions: ToolbarOptions(
                copy: true,
                cut: true,
                paste: false,
                selectAll: false,
              ),
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
              onEditingComplete: () => FocusScope.of(context).unfocus(),
                          onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
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
              enableInteractiveSelection: false,
              enabled: _enabled,
              cursorColor: AppColors.ACCENT_COLOR,
              toolbarOptions: ToolbarOptions(
                copy: true,
                cut: true,
                paste: false,
                selectAll: false,
              ),
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
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
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

  Stack phoneNoWidget(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.0),
          child: Focus(
            onFocusChange: (value) {
              if (value) {
                phoneNumberController.selection = TextSelection.fromPosition(
                    TextPosition(offset: phoneNumberController.text.length));
              }
            },
            child: TextFormField(
              focusNode: phoneNumberFocus,
              enableInteractiveSelection: false,
              enabled: _enabled,
              cursorColor: AppColors.ACCENT_COLOR,
              toolbarOptions: ToolbarOptions(
                copy: true,
                cut: true,
                paste: false,
                selectAll: false,
              ),
              onChanged: (String newVal) {
                if (newVal.length <= phoneNumberValidation) {
                  phoneNo2 = newVal;
                } else {
                  phoneNumberController.value = new TextEditingValue(
                      text: phoneNo2,
                      selection: new TextSelection(
                          baseOffset: phoneNumberValidation,
                          extentOffset: phoneNumberValidation,
                          affinity: TextAffinity.downstream,
                          isDirectional: false),
                      composing:
                          new TextRange(start: 0, end: phoneNumberValidation));
                  //  _emailController.text = text;
                }
              },
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(phoneNumberValidation),
              ],
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(passwordNode),

              onFieldSubmitted: (texttt) {
                Focus.of(context).requestFocus(passwordNode);
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
                  enabled: _enabled,
                  focusNode: nPasswordNode,
                  cursorColor: AppColors.ACCENT_COLOR,
                  toolbarOptions: ToolbarOptions(
                    copy: true,
                    cut: true,
                    paste: false,
                    selectAll: false,
                  ),
                  onChanged: (String newVal) {
                    if (newVal.length <= nPasswordValidation) {
                      nPassword = newVal;
                    } else {
                      nPasswordController.value = new TextEditingValue(
                          text: nPassword,
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
                    if (_enabled) {
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
                  enabled: _enabled,
                  focusNode: cPasswordNode,
                  cursorColor: AppColors.ACCENT_COLOR,
                  toolbarOptions: ToolbarOptions(
                    copy: true,
                    cut: true,
                    paste: false,
                    selectAll: false,
                  ),
                  onChanged: (String newVal) {
                    if (newVal.length <= cPasswordValidation) {
                      cPassword = newVal;
                    } else {
                      cPasswordController.value = new TextEditingValue(
                          text: cPassword,
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
                    if (_enabled) {
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

// api calling

  Future<void> callLoginApi() async {
    _playAnimation();
    setState(() {
      _enabled = false;
      _loginPlatform = "normal";
    });

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          flag = true;
          _isInternetAvailable = true;
        });
        _firebaseMessaging.getToken().then((token) {
          print("Token : $token");

          var map = Map();

          map['phone'] = phoneNo2;
          map['password'] = password;
          map['device_type'] = Util.getDeviceType();
          map['device_token'] = token;

          _loginViewModel.login(map);
        });
      } else {
        setState(() {
          flag = true;
          _isInternetAvailable = false;
          ToastUtil.showToast(context, "No internet");
        });
      }
    });
  }

  Future<void> callRegisterViaPhoneApi() async {
    _playSubmitBtnAnimation();
    setState(() {
      _enabled = false;
      _loginPlatform = "normal";
    });

    String number = numberController.text.trim();

    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          flag = true;
          _isInternetAvailable = true;
        });

        var map = Map();
        map['phone'] = phoneNo;
        _loginViewModel.registerViaPhone(map);
      } else {
        setState(() {
          flag = true;
          _isInternetAvailable = false;
          ToastUtil.showToast(context, "No internet");
        });
      }
    });
  }

  Future<void> callVerifyOtpApi() async {
    _playVerifyBtnAnimation();
    String number = numberController.text.trim();
    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          flag = true;
          _isInternetAvailable = true;
        });
        var map = Map();
        map['phone'] = phoneNo;
        map['code'] = code;
        _loginViewModel.verifyOtp(map);
      } else {
        setState(() {
          flag = true;
          _isInternetAvailable = false;
          ToastUtil.showToast(context, "No internet");
        });
      }
    });
  }

  Future<void> callForgetPasswordApi() async {
    _playRecoverBtnAnimation();
    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          flag = true;
          _isInternetAvailable = true;
        });

        var map = Map();
        map['phone'] = phoneNo;
        _loginViewModel.forgetPassword(map);
      } else {
        setState(() {
          flag = true;
          _isInternetAvailable = false;
          ToastUtil.showToast(context, "No internet");
        });
      }
    });
  }

  Future<void> callResetPasswordApi() async {
    _playUpdatePasswordBtnAnimation();
    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          flag = true;
          _isInternetAvailable = true;
        });

        var map = Map();
        map['phone'] = phoneNo;
        map['verification_code'] = code;
        map['password'] = cPassword;
        _loginViewModel.resetPassword(map);
      } else {
        setState(() {
          flag = true;
          _isInternetAvailable = false;
          ToastUtil.showToast(context, "No internet");
        });
      }
    });
  }

  void subscribeToViewModel() {
    _loginViewModel
        .getLoginRepository()
        .getRepositoryResponse()
        .listen((response) async {
      _stopAnimation();
      _stopRecoverBtnAnimation();
      _stopUpdatePasswordBtnAnimation();
      _stopSubmitBtnAnimation();
      _stopVerifyBtnAnimation();
      if (mounted) {
        setState(() {
          flag = true;
          _enabled = true;
        });
      }

      if (response.data is LoginResponseModel) {
        LoginResponseModel responseRegister = response.data;

        if (responseRegister != null) {
          App().getAppPreferences().setIsLoggedIn(loggedIn: true);
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.LOCATION_SETTING_VIEW, (route) => false,arguments: {
            'afterLogin': responseRegister.data.isFirstLogin == 1?true:false,
          });
        } else {
          Map map = Map<String, String>();
          map['email'] = emailController.text.toString();
        }
      } else if (response.msg == "Code has been sent to your phone number") {
        ToastUtil.showToast(context, response.msg);
        if (submitPhoneBc != null) {
          Navigator.pop(submitPhoneBc);
        }

        showOtpBottomSheet(context);
      } else if (response.msg == "Verification code has been send successfully") {
        ToastUtil.showToast(context, response.msg);
        if (forgetPasswordBc != null) {
          Navigator.pop(forgetPasswordBc);
        }
        showOtpBottomSheet(context);
      } else if (response.msg == "Verified") {
        if (otpPasswordBc != null) {
          Navigator.pop(otpPasswordBc);
        }
        Navigator.pushNamed(context, AppRoutes.CREATE_AN_ACCOUNT_VIEW,
            arguments: {
              'phone': phoneNo,
            });
      } else if (response.msg == "Password Changed Successfully") {
        if (passwordBc != null) {
          Navigator.pop(passwordBc);
        }
        ToastUtil.showToast(context, response.msg);
      } else if (response.data is DioError) {
        if (response.statusCode == 401) {
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.WELCOME_VIEW, (Route<dynamic> route) => false);
        }else{
          _isInternetAvailable = Util.showErrorMsg(context, response.data);
        }

      } else {
        ToastUtil.showToast(context, response.msg);
        _stopAnimation();
        _stopRecoverBtnAnimation();
        _stopUpdatePasswordBtnAnimation();
        _stopSubmitBtnAnimation();
        _stopVerifyBtnAnimation();
      }
    });
  }

  bool validate() {
    Util.hideKeyBoard(context);

    flag = false;
    return true;
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
    } on TickerCanceled {}
  }

  Future<Null> _playRecoverBtnAnimation() async {
    try {
      await _recoverButtonController.forward();
    } on TickerCanceled {}
  }

  Future<Null> _playVerifyBtnAnimation() async {
    try {
      await _verifyButtonController.forward();
    } on TickerCanceled {}
  }

  Future<Null> _playUpdatePasswordBtnAnimation() async {
    try {
      await _updatePasswordButtonController.forward();
    } on TickerCanceled {}
  }

  Future<Null> _playSubmitBtnAnimation() async {
    try {
      await _submitButtonController.forward();
    } on TickerCanceled {}
  }

  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  Future<Null> _stopRecoverBtnAnimation() async {
    try {
      await _recoverButtonController.reverse();
    } on TickerCanceled {}
  }

  Future<Null> _stopVerifyBtnAnimation() async {
    try {
      await _verifyButtonController.reverse();
    } on TickerCanceled {}
  }

  Future<Null> _stopUpdatePasswordBtnAnimation() async {
    try {
      await _updatePasswordButtonController.reverse();
    } on TickerCanceled {}
  }

  Future<Null> _stopSubmitBtnAnimation() async {
    try {
      await _submitButtonController.reverse();
    } on TickerCanceled {}
  }

}
