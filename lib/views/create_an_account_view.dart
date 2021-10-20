import 'dart:async';
import 'package:ampd/app/app.dart';
import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_constants.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/widgets/animated_gradient_button.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ampd/data/model/register_response_model.dart';
import 'package:ampd/utils/ToastUtil.dart';
import 'package:ampd/utils/Util.dart';
import 'package:ampd/viewmodel/register_viewmodel.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '../appresources/app_colors.dart';
import '../appresources/app_strings.dart';

class CreateAnAccountView extends StatefulWidget {
  Map<String, dynamic> map;

  CreateAnAccountView(this.map);
  @override
  _CreateAnAccountViewState createState() => _CreateAnAccountViewState();
}

class _CreateAnAccountViewState extends State<CreateAnAccountView> with TickerProviderStateMixin {
  FirebaseMessaging _firebaseMessaging;
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController cPasswordController = new TextEditingController();
  AnimationController _loginButtonController;
  int firstNameValidation = AppConstants.NAME_VALIDATION;
  int lastNameValidation = AppConstants.NAME_VALIDATION;
  int emailValidation = AppConstants.EMAIL_VALIDATION;
  int passwordValidation = AppConstants.PASSWORD_VALIDATION;
  int cPasswordValidation = AppConstants.PASSWORD_VALIDATION;

  bool _enabled = true;
  bool flag = true;
  var firstNameFocus = FocusNode();
  var lastNameFocus = FocusNode();
  var emailFocus = FocusNode();
  var passwordNode = FocusNode();
  var cPasswordNode = FocusNode();


  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String cPassword = "";
  String _loginPlatform;

  bool _isEmailValid = false;
  bool obscureText = true;
  bool cPasswordObscureText = true;
  bool _isInternetAvailable = true;


  IconData checkIconData = Icons.check;
  IconData iconData = Icons.visibility_off;
  IconData iconData1 = Icons.visibility_off;
  IconData iconData2 = Icons.visibility_off;

  RegisterViewModel _registerViewModel;


  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);

    _firebaseMessaging = FirebaseMessaging();
    firstNameController.addListener(() {
      if (firstNameController.text.length <= firstNameValidation) {
        firstName = firstNameController.text;
      } else {
        firstNameController.value = new TextEditingValue(
            text: firstName,
            selection: new TextSelection(
                baseOffset: firstNameValidation,
                extentOffset: firstNameValidation,
                affinity: TextAffinity.downstream,
                isDirectional: true),
            composing: new TextRange(start: 0, end: firstNameValidation)
        );
      }
    });

    lastNameController.addListener(() {
      if (lastNameController.text.length <= lastNameValidation) {
        lastName = lastNameController.text;
      } else {
        lastNameController.value = new TextEditingValue(
            text: lastName,
            selection: new TextSelection(
                baseOffset: lastNameValidation,
                extentOffset: lastNameValidation,
                affinity: TextAffinity.downstream,
                isDirectional: true),
            composing: new TextRange(start: 0, end: lastNameValidation)
        );
      }
    });
    _registerViewModel = RegisterViewModel(App());
    subscribeToViewModel();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // call this method here to hide soft keyboard
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
          appBar: appBar(title:"",
              showCloseIcon: false,
              onBackClick: (){
                Navigator.of(context).pop();
              },iconColor:AppColors.COLOR_BLACK),
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
                      height: 25.0.h,
                      margin: EdgeInsets.fromLTRB(0.0, 40.0, 0, 0),
                      child: Center(
                        child: SvgPicture.asset(
                          AppImages.MAIN_LOGO,
                        ),
                      ),
                    ),
                    Text(
                      AppStrings.CREATE_AN_ACCOUNT,
                      style:
                          AppStyles.blackWithBoldFontTextStyle(context, 20.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .09),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                              child: Text(
                            AppStrings.CREATE_AN_ACCOUNT_AND,
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
                      child: new Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Flexible(child: firstNameTextField(context),flex: 1,),
                          SizedBox(
                            width: 17.0,
                          ),
                          Flexible(child: lastNameTextField(context),flex: 1,),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    customEmailTextField(context),
                    SizedBox(
                      height: 20.0,
                    ),
                    customPasswordTextField(context),
                    SizedBox(
                      height: 20.0,
                    ),
                    confirmPasswordTextField(context),
                    SizedBox(
                      height: 30.0,
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
                                  _isInternetAvailable = false;
                                });
                                if(firstName.isNotEmpty){
                                  if(lastName.isNotEmpty){
                                    if(email.isNotEmpty){
                                      if(_isEmailValid){
                                        if(password.isNotEmpty) {
                                          if(password.length > 7) {
                                            if(cPassword.isNotEmpty) {
                                              if(cPassword.length > 7) {

                                                if(password == cPassword){
                                                  callRegisterApi();
                                                }else{
                                                  setState(() {
                                                    flag = true;
                                                  });
                                                  ToastUtil.showToast(
                                                      context, "Password and password confirmation values don't match");
                                                }


                                              }else{
                                                setState(() {
                                                  flag = true;
                                                });
                                                ToastUtil.showToast(context, "Confirm password is too short");
                                              }
                                            }else{
                                              setState(() {
                                                flag = true;
                                              });
                                              ToastUtil.showToast(context, "Please enter confirm password");
                                            }

                                          }else{
                                            setState(() {
                                              flag = true;
                                            });
                                            ToastUtil.showToast(context, "Password is too short");
                                          }

                                        }else{
                                          setState(() {
                                            flag = true;
                                          });
                                          ToastUtil.showToast(context, "Please enter password");
                                        }
                                      }else{
                                        flag = true;
                                        ToastUtil.showToast(context, "Invalid email address");
                                      }
                                    }else{
                                      flag = true;
                                      ToastUtil.showToast(context, "Please enter your email address");
                                    }
                                  }else{
                                    flag = true;
                                    ToastUtil.showToast(context, "Please enter your last name");
                                  }
                                }else{
                                  flag = true;
                                  ToastUtil.showToast(context, "Please enter your first name");
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
                      text: AppStrings.CREATE,
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


  Stack firstNameTextField(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Focus(
            onFocusChange: (value) {
              if (value) {
                firstNameController.selection = TextSelection.fromPosition(
                    TextPosition(offset: firstNameController.text.length));
              }
            },
            child: TextFormField(
//                                enableInteractiveSelection: false,
              enabled: _enabled,
              focusNode: firstNameFocus,
              cursorColor: AppColors.ACCENT_COLOR,
              textCapitalization: TextCapitalization.sentences,
              toolbarOptions: ToolbarOptions(
                copy: true,
                cut: true,
                paste: false,
                selectAll: false,
              ),
//              onChanged: (String newVal) {
//                if (newVal.length <= firstNameValidation) {
//                  firstName = newVal;
//                } else {
//                  firstNameController.value = new TextEditingValue(
//                      text: firstName,
//                      selection: new TextSelection(
//                          baseOffset: firstNameValidation,
//                          extentOffset: firstNameValidation,
//                          affinity: TextAffinity.downstream,
//                          isDirectional: false),
//                      composing: new TextRange(start: 0, end: firstNameValidation));
//                  //  _emailController.text = text;
//                }
//              },
              controller: firstNameController,
              keyboardType: TextInputType.text,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                LengthLimitingTextInputFormatter(firstNameValidation),
              ],
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(lastNameFocus),

              onFieldSubmitted: (texttt) {
                FocusScope.of(context).requestFocus(lastNameFocus);
              },
              textInputAction: TextInputAction.next,
              decoration:
              AppStyles.decorationWithBorder(AppStrings.FIRST_NAME),
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

  Stack lastNameTextField(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Focus(
            onFocusChange: (value) {
              if (value) {
                lastNameController.selection = TextSelection.fromPosition(
                    TextPosition(offset: lastNameController.text.length));
              }
            },
            child: TextFormField(
//                                enableInteractiveSelection: false,
              enabled: _enabled,
              focusNode: lastNameFocus,
              cursorColor: AppColors.ACCENT_COLOR,
              textCapitalization: TextCapitalization.sentences,
              toolbarOptions: ToolbarOptions(
                copy: true,
                cut: true,
                paste: false,
                selectAll: false,
              ),
//              onChanged: (String newVal) {
//                if (newVal.length <= lastNameValidation) {
//                  lastName = newVal;
//                } else {
//                  lastNameController.value = new TextEditingValue(
//                      text: lastName,
//                      selection: new TextSelection(
//                          baseOffset: lastNameValidation,
//                          extentOffset: lastNameValidation,
//                          affinity: TextAffinity.downstream,
//                          isDirectional: false),
//                      composing: new TextRange(start: 0, end: lastNameValidation));
//                  //  _emailController.text = text;
//                }
//              },
              controller: lastNameController,
              keyboardType: TextInputType.text,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                LengthLimitingTextInputFormatter(lastNameValidation),
              ],
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(emailFocus),

              onFieldSubmitted: (texttt) {
                FocusScope.of(context).requestFocus(emailFocus);
              },
              textInputAction: TextInputAction.next,
              decoration:
              AppStyles.decorationWithBorder(AppStrings.LAST_NAME),
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
              onEditingComplete: () => FocusScope.of(context).requestFocus(cPasswordNode),
                          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(cPasswordNode),
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
              onEditingComplete: () => FocusScope.of(context).unfocus(),
              onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
              obscureText: cPasswordObscureText,
              textInputAction: TextInputAction.next,
              decoration: AppStyles.decorationWithBorder(AppStrings.CONFIRM_PASSWORD),
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

  Future<void> callRegisterApi() async {

    _playAnimation();
    setState(() {
      _enabled = false;
      _loginPlatform = "normal";
    });

    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = cPasswordController.text.toString();

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
          map['first_name'] = firstName;
          map['last_name'] = lastName;
          map['phone'] = widget.map['phone'];
          map['password'] = password;
          map['device_type'] = Util.getDeviceType();
          map['device_token'] = token;
          map['email'] = email;


          _registerViewModel.register(map);
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

  void subscribeToViewModel() {
    _stopAnimation();


    _registerViewModel
        .getCompleteRegisterRepository()
        .getRepositoryResponse()
        .listen((response) async {

      if(mounted) {
        setState(() {
          flag = true;
          _enabled = true;
        });
      }

      if(response.success) {
        ToastUtil.showToast(context, response.msg);

        RegisterResponseModel responseRegister = response.data;

        if(responseRegister != null) {

          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.SIGN_IN_VIEW, (route) => false);

        }else{
          Map map = Map<String, String>();
          map['email'] = emailController.text.toString();
        }
      } else if(response.data is DioError){
        if (response.statusCode == 401) {
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.WELCOME_VIEW, (Route<dynamic> route) => false);
        }else{
          _isInternetAvailable = Util.showErrorMsg(context, response.data);
        }
      } else {
        ToastUtil.showToast(context, response.msg);
        _stopAnimation();
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
  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }
}

