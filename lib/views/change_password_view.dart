import 'dart:math';

import 'package:ampd/app/app.dart';
import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_constants.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/data/model/changePasswordModel.dart';
import 'package:ampd/utils/ToastUtil.dart';
import 'package:ampd/utils/Util.dart';
import 'package:ampd/utils/loader.dart';
import 'package:ampd/viewmodel/change_password_viewmodel.dart';
import 'package:ampd/views/setting_view.dart';
import 'package:ampd/widgets/animated_gradient_button.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:ampd/widgets/otp_text_field.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordView> with TickerProviderStateMixin {

  TextEditingController passwordController = new TextEditingController();
  TextEditingController nPasswordController = new TextEditingController();
  TextEditingController nPasswordController1 = new TextEditingController();
  TextEditingController cPasswordController = new TextEditingController();
  TextEditingController cPasswordController1 = new TextEditingController();

  TextEditingController numberController = new TextEditingController();
  int passwordValidation = AppConstants.PASSWORD_VALIDATION;
  int nPasswordValidation = AppConstants.PASSWORD_VALIDATION;
  int cPasswordValidation = AppConstants.PASSWORD_VALIDATION;

  bool _enabled = true;


  var passwordNode = FocusNode();
  var nPasswordNode = FocusNode();
  var nPasswordNode1 = FocusNode();
  var cPasswordNode = FocusNode();
  var cPasswordNode1 = FocusNode();

  String password = "";
  String password1 = "";
  String nPassword1 = "";
  String nPassword = "";
  String cPassword1 = "";
  String cPassword = "";

  bool obscureText = true;
  bool nPasswordObscureText = true;
  bool nPasswordObscureText1 = true;
  bool cPasswordObscureText = true;
  bool cPasswordObscureText1 = true;

  IconData iconData = Icons.visibility_off;
  IconData iconData1 = Icons.visibility_off;
  IconData iconData2 = Icons.visibility_off;
  IconData iconData3 = Icons.visibility_off;
  IconData iconData4 = Icons.visibility_off;


  String initialCountry = 'US';
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  BuildContext forgetPasswordBc;
  String phoneNo = "";
  bool isValidate2 = false;
  bool flag = true;
  String code = "";
  AnimationController _recoverButtonController;
  ChangePasswordViewModel _changePasswordViewModel;
  BuildContext passwordBc;
  bool _isInAsyncCall = false;
  bool _isInternetAvailable = true;

  AnimationController _updatePasswordButtonController;
  AnimationController _updatePasswordController;

  @override
  void initState() {
    super.initState();

    _recoverButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);

    _updatePasswordController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);

    _updatePasswordButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);

    _changePasswordViewModel = ChangePasswordViewModel(App());
    subscribeToViewModel();
  }

  @override
  void dispose() {
    passwordController.dispose();
    nPasswordController.dispose();
    cPasswordController.dispose();
    _recoverButtonController.dispose();
    _updatePasswordButtonController.dispose();
    _updatePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool pushNotificationSwitch = false;


    return ModalProgressHUD(
      inAsyncCall: _isInAsyncCall,
      progressIndicator:  Padding(
        padding: EdgeInsets.all(5),
        child: Loader(
          isLoading: _isInAsyncCall,
//                   isLoading: _swipeItems.length > 0 ? false:true,
          color: AppColors.APP_PRIMARY_COLOR,
        ),
      ),
      child: Scaffold(
          appBar: appBar(title:"",
              showCloseIcon: false,
              onBackClick: (){
            Navigator.of(context).pop();
          },iconColor:AppColors.COLOR_BLACK),
          backgroundColor: AppColors.WHITE_COLOR,
          body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Header(heading1:AppStrings.CHANGE_PASSWORD,heading2:AppStrings.UPDATE_YOUR_PASSWORD),

                      SizedBox(
                        height: 20.0,
                      ),
                      Column(
                        children: [
                          customPasswordTextField(context),

                          SizedBox(
                            height: 20.0,
                          ),
                          newPasswordTextField(context),
                          SizedBox(
                            height: 20.0,
                          ),

                          confirmPasswordTextField(context),
                          SizedBox(
                            height: 20.0,
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    numberController.clear();
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
                            height: 50.0,
                          ),
                          AnimatedGradientButton(
                            onAnimationTap: () {
                              if (validate()) {
                                callChangePasswordApi();
                              }
                            },
                            buttonController: _updatePasswordController,
                            text: AppStrings.UPDATE_PASSWORD,
                          ),
                        ],
                      ),
                    ],

                  ),

                ),

            ),
          )),
    );
  }


  showForgetBottomSheet(BuildContext context) {
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
            if (validate1()) {
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
                      isValidate2 = false;
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
            newPasswordTextField1(context),
            SizedBox(
              height: 20.0,
            ),
            confirmPasswordTextField1(context),
          ],
        ),
        AnimatedGradientButton(
          onAnimationTap: () {
            if (flag) {
              if (validate1()) {
                Util.check().then((value) {
                  if (value != null && value) {
                    // Internet Present Case
                    setState(() {
                      flag = true;
                      _isInternetAvailable = true;
                    });
                    if (nPassword1.isNotEmpty) {
                      if (nPassword1.length > 7) {
                        if (cPassword1.isNotEmpty) {
                          if (cPassword1.length > 7) {

                            if(nPassword1 == cPassword1){
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
  showOtpBottomSheet(BuildContext context) {
    showBottomSheetWidget(
        context, AppStrings.ENTER_OTP_DIGIT, AppStrings.OTP_DESC,
        OtpTextField(onOtpCodeChanged: (otp) {
          code = otp;
        }), () {
      if (validate1()) {
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
      Navigator.pop(bc1);
      if (code.isNotEmpty) {
        if (code.length == 4) {

          showResetPasswordBottomSheet(context);
        } else {
          setState(() {
            flag = true;
          });
          ToastUtil.showToast(context, "Please enter valid otp code");
        }
      } else {
        setState(() {
          flag = true;
        });
        ToastUtil.showToast(context, "Please enter otp code");
      }
    }, AppStrings.VERIFY_NOW, true);
  }


  Stack customPasswordTextField(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
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
              onEditingComplete: () => FocusScope.of(context).requestFocus(nPasswordNode),
                          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(nPasswordNode),
              obscureText: obscureText,
              textInputAction: TextInputAction.next,
              decoration: AppStyles.decorationWithBorder(AppStrings.CURRENT_PASSWORD),
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

  Stack newPasswordTextField(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
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
                      composing:
                      new TextRange(start: 0, end: nPasswordValidation));
                  //  _emailController.text = text;
                }
              },
              controller: nPasswordController,
              keyboardType: TextInputType.visiblePassword,
              inputFormatters: [
                LengthLimitingTextInputFormatter(nPasswordValidation),
              ],
              onEditingComplete: () => FocusScope.of(context).requestFocus(cPasswordNode),
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(cPasswordNode),
              obscureText: nPasswordObscureText,
              textInputAction: TextInputAction.next,
              decoration: AppStyles.decorationWithBorder(AppStrings.NEW_PASSWORD),
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
                  setState(() {
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
  }

  Stack confirmPasswordTextField(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
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
                  password = newVal;
                } else {
                  cPasswordController.value = new TextEditingValue(
                      text: password,
                      selection: new TextSelection(
                          baseOffset: cPasswordValidation,
                          extentOffset: cPasswordValidation,
                          affinity: TextAffinity.downstream,
                          isDirectional: false),
                      composing:
                      new TextRange(start: 0, end: cPasswordValidation));
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
              textInputAction: TextInputAction.done,
              decoration: AppStyles.decorationWithBorder(AppStrings.RE_ENTER_PASSWORD),
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
                  setState(() {
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
  }


  Widget newPasswordTextField1(BuildContext context) {
    return StatefulBuilder(
      builder: (ctx, setStates) {
        return Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Focus(
                onFocusChange: (value) {
                  if (value) {
                    nPasswordController1.selection = TextSelection.fromPosition(
                        TextPosition(offset: cPasswordController1.text.length));
                  }
                },
                child: TextFormField(
//                                enableInteractiveSelection: false,
                  enabled: _enabled,
                  focusNode: nPasswordNode1,
                  cursorColor: AppColors.ACCENT_COLOR,
                  toolbarOptions: ToolbarOptions(
                    copy: true,
                    cut: true,
                    paste: false,
                    selectAll: false,
                  ),
                  onChanged: (String newVal) {
                    if (newVal.length <= nPasswordValidation) {
                      nPassword1 = newVal;
                    } else {
                      nPasswordController1.value = new TextEditingValue(
                          text: nPassword1,
                          selection: new TextSelection(
                              baseOffset: nPasswordValidation,
                              extentOffset: nPasswordValidation,
                              affinity: TextAffinity.downstream,
                              isDirectional: false),
                          composing:
                          new TextRange(start: 0, end: nPasswordValidation));
                      //  _emailController.text = text;
                    }
                  },
                  controller: nPasswordController1,
                  keyboardType: TextInputType.visiblePassword,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(nPasswordValidation),
                  ],
                  onEditingComplete: () => FocusScope.of(context).requestFocus(cPasswordNode1),
                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(cPasswordNode1),
                  obscureText: nPasswordObscureText1,
                  textInputAction: TextInputAction.next,
                  decoration: AppStyles.decorationWithBorder(AppStrings.NEW_PASSWORD),
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
                    iconData3,
                    color: AppColors.LIGHT_GREY_TEXT_COLOR,
                  ),
                  onPressed: () {
                    if (_enabled) {
                      setStates(() {
                        if (nPasswordObscureText1) {
                          nPasswordObscureText1 = false;
                          iconData3 = Icons.visibility;
                        } else {
                          nPasswordObscureText1 = true;
                          iconData3 = Icons.visibility_off;
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

  Widget confirmPasswordTextField1(BuildContext context) {
    return StatefulBuilder(
      builder: (ctx, setStates) {
        return Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Focus(
                onFocusChange: (value) {
                  if (value) {
                    cPasswordController1.selection = TextSelection.fromPosition(
                        TextPosition(offset: cPasswordController1.text.length));
                  }
                },
                child: TextFormField(
//                                enableInteractiveSelection: false,
                  enabled: _enabled,
                  focusNode: cPasswordNode1,
                  cursorColor: AppColors.ACCENT_COLOR,
                  toolbarOptions: ToolbarOptions(
                    copy: true,
                    cut: true,
                    paste: false,
                    selectAll: false,
                  ),
                  onChanged: (String newVal) {
                    if (newVal.length <= cPasswordValidation) {
                      cPassword1 = newVal;
                    } else {
                      cPasswordController1.value = new TextEditingValue(
                          text: cPassword1,
                          selection: new TextSelection(
                              baseOffset: cPasswordValidation,
                              extentOffset: cPasswordValidation,
                              affinity: TextAffinity.downstream,
                              isDirectional: false),
                          composing:
                          new TextRange(start: 0, end: cPasswordValidation));
                      //  _emailController.text = text;
                    }
                  },
                  controller: cPasswordController1,
                  keyboardType: TextInputType.visiblePassword,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(cPasswordValidation),
                  ],
                  /*onEditingComplete: () => FocusScope.of(context).requestFocus(cPasswordNode),
                          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(cPasswordNode),*/
                  obscureText: cPasswordObscureText1,
                  textInputAction: TextInputAction.done,
                  decoration: AppStyles.decorationWithBorder(AppStrings.RE_ENTER_PASSWORD),
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
                    iconData4,
                    color: AppColors.LIGHT_GREY_TEXT_COLOR,
                  ),
                  onPressed: () {
                    if (_enabled) {
                      setStates(() {
                        if (cPasswordObscureText1) {
                          cPasswordObscureText1 = false;
                          iconData4 = Icons.visibility;
                        } else {
                          cPasswordObscureText1 = true;
                          iconData4 = Icons.visibility_off;
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


  bool validate() {
    Util.hideKeyBoard(context);

    var currentPassword = passwordController.text.trim().toString();
    var newPassword = nPasswordController.text.trim().toString();
    var passwordConfirmation = cPasswordController.text.trim().toString();

    if(currentPassword.isEmpty || currentPassword == "") {
      ToastUtil.showToast(context, "Please provide your current password");
      return false;
    }

    // if(currentPassword.length < 6) {
    //   ToastUtil.showToast(context, "Current Password is really short please enter atleast 6 characters.");
    //   return false;
    // }

    if(newPassword.isEmpty || newPassword == "") {
      ToastUtil.showToast(context, "Please provide your new password");
      return false;
    }

    if(newPassword.length < 6) {
      ToastUtil.showToast(context, "Your password must be 6 characters or more");
      return false;
    }

    // if(!Util.isPasswordCompliant(context, newPassword, "Password")){
    //   return false;
    // }

    if(passwordConfirmation.isEmpty || passwordConfirmation == "") {
      ToastUtil.showToast(context, "Please provide your confirm password");
      return false;
    }

    // if(passwordConfirmation.length < 6) {
    //   ToastUtil.showToast(context, "Please provide");
    //   return false;
    // }

    if(newPassword != passwordConfirmation){
      ToastUtil.showToast(context, "Password and password confirmation values don't match");
      return false;
    }

    return true;
  }

  bool validate1() {
    Util.hideKeyBoard(context);

    flag = false;
    return true;
  }

  Future<void> callChangePasswordApi() async {
    _playAnimation();

    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
//          _isInAsyncCall = true;
        });

        var map = Map<String, dynamic>();
        map['current_password'] = passwordController.text.trim().toString();
        map['password'] = nPasswordController.text.trim().toString();
        _changePasswordViewModel.changePassword(map);
      } else {
        setState(() {
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
        _changePasswordViewModel.forgetPassword(map);
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
        map['password'] = cPassword1;
        _changePasswordViewModel.resetPassword(map);
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
    _changePasswordViewModel
        .getChangePasswordRepository()
        .getRepositoryResponse()
        .listen((response) async {
      _stopAnimation();
      _stopRecoverBtnAnimation();
      _stopUpdatePasswordBtnAnimation();
      if (mounted) {
        setState(() {
          _enabled = true;
          _isInAsyncCall = false;
        });
      }

      if (response.data is ChangePasswordModel) {

        ToastUtil.showToast(context, response.msg);
        Navigator.of(context).pop();

      } else if (response.msg == "Verification code has been send successfully") {
        ToastUtil.showToast(context, response.msg);
        if (forgetPasswordBc != null) {
          Navigator.pop(forgetPasswordBc);
        }
        showOtpBottomSheet(context);
      }else if (response.msg == "Password Changed Successfully") {
        if (passwordBc != null) {
          Navigator.pop(passwordBc);
        }
        ToastUtil.showToast(context, response.msg);
      }
      else if (response.data is DioError) {
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
      }
    });
  }

  Future<Null> _playAnimation() async {
    try {
      await _updatePasswordController.forward();
    } on TickerCanceled {}
  }

  Future<Null> _stopAnimation() async {
    try {
      await _updatePasswordController.reverse();
    } on TickerCanceled {}
  }

  Future<Null> _playRecoverBtnAnimation() async {
    try {
      await _recoverButtonController.forward();
    } on TickerCanceled {}
  }

  Future<Null> _stopRecoverBtnAnimation() async {
    try {
      await _recoverButtonController.reverse();
    } on TickerCanceled {}
  }

  Future<Null> _playUpdatePasswordBtnAnimation() async {
    try {
      await _updatePasswordButtonController.forward();
    } on TickerCanceled {}
  }


  Future<Null> _stopUpdatePasswordBtnAnimation() async {
    try {
      await _updatePasswordButtonController.reverse();
    } on TickerCanceled {}
  }


}