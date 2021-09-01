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
import 'package:ampd/widgets/gradient_button.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

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

  ChangePasswordViewModel _changePasswordViewModel;

  bool _isInAsyncCall = false;
  bool _isInternetAvailable = true;

  @override
  void initState() {
    super.initState();

    _changePasswordViewModel = ChangePasswordViewModel(App());
    subscribeToViewModel();
  }

  @override
  void dispose() {
    passwordController.dispose();
    nPasswordController.dispose();
    cPasswordController.dispose();
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
                          Container(
                            child:
                            GestureDetector(
                              onTap: (){
                                if(validate()) {
                                  callChangePasswordApi();
                                }
                               },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                height: 50.0,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [Color(0xff174EA0), Color(0xff1E70C6), Color(0xff2490E9)],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                child: Container(
                                  constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppStrings.UPDATE_PASSWORD,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
              enabled: _enabled1,
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
              enabled: _enabled2,
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

  Future<void> callChangePasswordApi() async {
    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
          _isInAsyncCall = true;
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

  void subscribeToViewModel() {
    _changePasswordViewModel
        .getChangePasswordRepository()
        .getRepositoryResponse()
        .listen((response) async {
      if (mounted) {
        setState(() {
          _enabled = true;
          _isInAsyncCall = false;
        });
      }

      if (response.data is ChangePasswordModel) {

        ToastUtil.showToast(context, response.msg);
        Navigator.of(context).pop();

      } else if (response.data is DioError) {
        _isInternetAvailable = Util.showErrorMsg(context, response.data);
      } else {
        ToastUtil.showToast(context, response.msg);
      }
    });
  }
}