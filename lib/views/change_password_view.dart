import 'dart:math';

import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_constants.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/views/setting_view.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordView> {

  TextEditingController passwordController = new TextEditingController();
  TextEditingController nPasswordController = new TextEditingController();
  TextEditingController cPasswordController = new TextEditingController();

  int passwordValidation = AppConstants.PASSWORD_VALIDATION;
  int nPasswordValidation = AppConstants.PASSWORD_VALIDATION;
  int cPasswordValidation = AppConstants.PASSWORD_VALIDATION;

  bool _enabled = true;
  bool _enabled1 = true;
  bool _enabled2 = true;

  var passwordNode = FocusNode();
  var nPasswordNode = FocusNode();
  var cPasswordNode = FocusNode();

  String password = "";
  String nPassword = "";
  String cPassword = "";

  bool obscureText = true;
  bool nPasswordObscureText = true;
  bool cPasswordObscureText = true;

  IconData iconData = Icons.visibility_off;
  IconData iconData1 = Icons.visibility_off;
  IconData iconData2 = Icons.visibility_off;


  @override
  Widget build(BuildContext context) {
    bool pushNotificationSwitch = false;


    return Scaffold(
        appBar: appBar(title:"",onBackClick: (){
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
                          height: 50.0,
                        ),
                        GradientButton(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          text: AppStrings.UPDATE_PASSWORD,
                        ),
                      ],
                    ),


                  ],

                ),

              ),

          ),
        ));
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
                if (_enabled1) {
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
              textInputAction: TextInputAction.next,
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
                if (_enabled2) {
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
}