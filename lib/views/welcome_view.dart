import 'package:ampd/app/app.dart';
import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_constants.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/data/model/register_response_model.dart';
import 'package:ampd/utils/ToastUtil.dart';
import 'package:ampd/utils/Util.dart';
import 'package:ampd/viewmodel/register_viewmodel.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:ampd/widgets/otp_text_field.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class WelcomeView extends StatefulWidget {

  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  TextEditingController numberController = new TextEditingController();
  int numberValidation = AppConstants.PHONE_VALIDATION;
  String phoneNo = "";
  String code = "";
  bool _enabled = true;
  bool _isInternetAvailable = true;
  String _loginPlatform;

  RegisterViewModel _registerViewModel;

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
    _registerViewModel = RegisterViewModel(App());
    subscribeToViewModel();
  }

  showPhoneNoBottomSheet(BuildContext context) {
    showBottomSheetWidget(context, AppStrings.PHONE_NUMBER_TITLE,
        AppStrings.PHONE_NUMBER_DESC, customWidget(context), (bc) {
      Navigator.pop(bc);
      callRegisterViaPhoneApi();
    }, AppStrings.SUBMIT, false);
  }

  showOtpBottomSheet(BuildContext context) {
    showBottomSheetWidget(context, AppStrings.ENTER_OTP_DIGIT,
        AppStrings.OTP_DESC, OtpTextField(
            onOtpCodeChanged: (otp){
              code = otp;
        }),
            (bc1) {
      Navigator.pop(bc1);
      callVerifyOtpApi();
    }, AppStrings.VERIFY_NOW, true);
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

  void subscribeToViewModel() {
    _registerViewModel
        .getCompleteRegisterRepository()
        .getRepositoryResponse()
        .listen((response) async {
      if (mounted) {
        setState(() {
          _enabled = true;
        });
      }

      if (response.msg == "Verified") {
        Navigator.pushNamed(context, AppRoutes.CREATE_AN_ACCOUNT_VIEW,arguments: {
          'phone' : phoneNo,
        });

      }
      else if(response.msg == "Code has been sent to your phone number") {
        ToastUtil.showToast(context, response.msg);
        showOtpBottomSheet(context);
      }
      else if (response.data is DioError) {
        _isInternetAvailable = Util.showErrorMsg(context, response.data);
      }
      else {
        ToastUtil.showToast(context, response.msg);
      }
    });


  }

  Future<void> callRegisterViaPhoneApi() async {
    setState(() {
      _enabled = false;
      _loginPlatform = "normal";
    });

    String number = numberController.text.trim();

    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
        });

        var map = Map();
        map['phone'] = number;
        _registerViewModel.registerViaPhone(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
        });
      }
    });
  }

  Future<void> callVerifyOtpApi() async {

    String number = numberController.text.trim();

    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
        });

        var map = Map();
        map['phone'] = number;
        map['code'] = code;
        _registerViewModel.verifyOtp(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
        });
      }
    });
  }

}
