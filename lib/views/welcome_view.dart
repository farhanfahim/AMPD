import 'dart:async';

import 'package:ampd/app/app.dart';
import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_constants.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/data/model/register_response_model.dart';
import 'package:ampd/utils/ToastUtil.dart';
import 'package:ampd/utils/Util.dart';
import 'package:ampd/viewmodel/register_viewmodel.dart';
import 'package:ampd/widgets/animated_gradient_button.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:ampd/widgets/otp_text_field.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:toast/toast.dart';
import 'package:open_appstore/open_appstore.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart' as gcl;
import 'package:sizer/sizer.dart';
import 'package:ampd/utils/LocationPermissionHandler.dart';
import 'package:ampd/utils/loader.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:app_settings/app_settings.dart';
import 'package:location_permissions/location_permissions.dart'    as locationPermission;
class WelcomeView extends StatefulWidget {
  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView>
    with TickerProviderStateMixin  , WidgetsBindingObserver {

  String initialCountry = 'US';
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  bool isValidate = false;
  TextEditingController numberController = new TextEditingController();
  int numberValidation = AppConstants.PHONE_VALIDATION;
  String phoneNo = "";
  String code = "";
  bool _enabled = true;
  bool _isInternetAvailable = true;
  String _loginPlatform;
  bool _openSetting = false;
  BuildContext otpPasswordBc;
  BuildContext submitPhoneBc;
  AnimationController _submitButtonController;
  AnimationController _verifyButtonController;

  bool flag = true;
  RegisterViewModel _registerViewModel;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      LocationPermissionHandler.checkLocationPermission().then((permission) {
        if (permission == locationPermission.PermissionStatus.granted) {

          _openSetting = true;
        }
      });
    });
  }

  bool getCurrentLocation() {
    LocationPermissionHandler.checkLocationPermission().then((permission) {
      if (permission == locationPermission.PermissionStatus.granted) {
        _openSetting = true;
      } else if (permission == locationPermission.PermissionStatus.unknown ||
          permission == locationPermission.PermissionStatus.denied ||
          permission == locationPermission.PermissionStatus.restricted) {
        try {
          LocationPermissionHandler.requestPermissoin().then((value) {
            if (permission == locationPermission.PermissionStatus.granted) {
              _openSetting = true;
            } else {
              _openSetting = false;
            }
          });
        } on PlatformException catch (err) {
          print(err);
        } catch (err) {
          print(err);
        }
      } else {
        _openSetting = false;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          toolbarHeight: 0.0,
        ),
        backgroundColor: AppColors.WHITE_COLOR,
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 25.0.h,
                  margin: EdgeInsets.fromLTRB(0.0, 7.0.h, 0, 0),
                  child: Center(
                    child: SvgPicture.asset(
                      AppImages.MAIN_LOGO,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  AppStrings.GET_STARTED,
                  style: AppStyles.blackWithBoldFontTextStyle(context, 20.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          child: Text(
                        AppStrings.CREATE_AN_ACCOUNT_OR,
                        style: AppStyles.detailWithSmallTextSizeTextStyle(),
                        textAlign: TextAlign.center,
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                GradientButton(
                  onTap: () {
                    numberController.clear();
                    showPhoneNoBottomSheet(context);
                  },
                  text: AppStrings.CREATE_AN_ACCOUNT,
                ),
                SizedBox(
                  height: 15.0,
                ),
                ButtonBorder(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.SIGN_IN_VIEW);
                  },
                  text: AppStrings.SIGN_IN,
                ),
                SizedBox(
                  height: 15.0,
                ),
                ButtonBorder(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.DASHBOARD_VIEW, (route) => false,
                        arguments: {
                          'isGuestLogin': true,
                          'tab_index': 1,
                          'show_tutorial': true
                        });
                  },
                  text: AppStrings.GUEST_LOGIN,
                ),
                SizedBox(
                  height: 70.0,
                )
              ],
            ),
          ),
        ));
  }

  @override
  void initState() {
    //throw Exception("This is a crash!");
    Timer(Duration(seconds: 2),
            () => getCurrentLocation());

    WidgetsBinding.instance.addObserver(this);
    _submitButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _verifyButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);

    _registerViewModel = RegisterViewModel(App());
    subscribeToViewModel();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _verifyButtonController.dispose();
    _submitButtonController.dispose();

    super.dispose();
  }

  showPhoneNoBottomSheet(BuildContext context) {
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

                      if (isValidate) {
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
                      ToastUtil.showToast(
                          context, "Please enter phone number ");
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
        null, (bc) {
      submitPhoneBc = bc;
    }, AppStrings.SUBMIT, false);
  }

  showOtpBottomSheet(BuildContext context) {
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
                  callVerifyOtpApi();
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

  void subscribeToViewModel() {
    _registerViewModel
        .getCompleteRegisterRepository()
        .getRepositoryResponse()
        .listen((response) async {
      if (mounted) {
        setState(() {
          flag = true;
          _enabled = true;
        });
      }

      if (response.msg == "Verified") {
        ToastUtil.showToast(context, response.msg);
        _stopVerifyBtnAnimation();
        if (otpPasswordBc != null) {
          Navigator.pop(otpPasswordBc);
        }
        Navigator.pushNamed(context, AppRoutes.CREATE_AN_ACCOUNT_VIEW,
            arguments: {
              'phone': phoneNo,
            });
      } else if (response.msg == "Code has been sent to your phone number") {
        ToastUtil.showToast(context, response.msg);
        _stopSubmitBtnAnimation();
        if (submitPhoneBc != null) {
          Navigator.pop(submitPhoneBc);
        }

        code = "";
        showOtpBottomSheet(context);
      } else if (response.data is DioError) {
        if (response.statusCode == 401) {
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.WELCOME_VIEW, (Route<dynamic> route) => false);
        }else{
          _isInternetAvailable = Util.showErrorMsg(context, response.data);
        }
      } else {
        ToastUtil.showToast(context, response.msg);
        _stopVerifyBtnAnimation();
        _stopSubmitBtnAnimation();
      }
    });
  }

  Future<void> callRegisterViaPhoneApi() async {
    _playSubmitBtnAnimation();

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
        _registerViewModel.registerViaPhone(map);
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
          _isInternetAvailable = true;
        });

        var map = Map();
        map['phone'] = phoneNo;
        map['code'] = code;
        _registerViewModel.verifyOtp(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
          ToastUtil.showToast(context, "No internet");
        });
      }
    });
  }

  bool validate() {
    Util.hideKeyBoard(context);

    flag = false;
    return true;
  }

  Future<Null> _playVerifyBtnAnimation() async {
    try {
      await _verifyButtonController.forward();
    } on TickerCanceled {}
  }

  Future<Null> _playSubmitBtnAnimation() async {
    try {
      await _submitButtonController.forward();
    } on TickerCanceled {}
  }

  Future<Null> _stopVerifyBtnAnimation() async {
    try {
      await _verifyButtonController.reverse();
    } on TickerCanceled {}
  }

  Future<Null> _stopSubmitBtnAnimation() async {
    try {
      await _submitButtonController.reverse();
    } on TickerCanceled {}
  }
}
