import 'dart:async';
import 'dart:io';

import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_constants.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/utils/MediaPermissionHandler.dart';
import 'package:ampd/utils/Util.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:ampd/widgets/custom_text_form.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:ampd/widgets/otp_text_field.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:images_picker/images_picker.dart';
import 'package:sizer/sizer.dart';

import '../appresources/app_colors.dart';
import '../appresources/app_colors.dart';
import '../appresources/app_strings.dart';

class EditProfileView extends StatefulWidget {
  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  TextEditingController addressController = new TextEditingController();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController editableEmailController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  TextEditingController editableNumberController = new TextEditingController();

  int firstNameValidation = AppConstants.NAME_VALIDATION;
  int lastNameValidation = AppConstants.NAME_VALIDATION;
  int emailValidation = AppConstants.EMAIL_VALIDATION;
  int addressValidation = AppConstants.ADDRESS_VALIDATION;
  int numberValidation = AppConstants.PHONE_VALIDATION;

  bool _enabled = true;
  bool _enabled2 = true;

  var firstNameFocus = FocusNode();
  var lastNameFocus = FocusNode();
  var emailFocus = FocusNode();
  var addressFocus = FocusNode();
  var phoneNoFocus = FocusNode();

  final _picker = ImagePicker();

  String firstName = "";
  String lastName = "";
  String email = "";
  String address = "";
  String phoneNo = "";
  String phoneNo2 = "";

  bool _isEmailValid = false;
  IconData checkIconData = Icons.check;

  File _image = null;

  @override
  void initState() {
    super.initState();
    emailController.text = "YusufNahass@email.com";
    numberController.text = "(800) 362-9239";

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
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // call this method here to hide soft keyboard
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
          appBar: appBar(
              title: "",
              onBackClick: () {
                Navigator.of(context).pop();
              },
              iconColor: AppColors.COLOR_BLACK),
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
                      height: 20.0,
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Container(
                            decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80.0),
                                    side: BorderSide(
                                        width: 10,
                                        color: AppColors.AVATAR_BORDER_COLOR))),
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundColor: AppColors.WHITE_COLOR,
                              child: _image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                      child: Image.file(
                                        _image,
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(80.0)),
                                      child: Image.asset(
                                        "assets/images/profile.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          right: 5,
                          bottom: 20,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                                width: 40,
                                height: 40,
                                child: FloatingActionButton(
                                  heroTag: "tag",
                                  backgroundColor: AppColors.BLUE_COLOR,
                                  // backgroundColor:
                                  // AppColors.PRIMARY_COLORTWO,
                                  elevation: 2,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                  onPressed: () {
                                    profilePictureOptionsBottomSheet();
                                    // showBottomSheet(context);
                                  },
                                  // onPressed: widget.addClickListner
                                )),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Yusuf Nahass",
                      style:
                          AppStyles.blackWithBoldFontTextStyle(context, 30.0).copyWith(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .09),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                              child: Text(
                            "Bucharest Romania",
                            style: AppStyles.detailWithSmallTextSizeTextStyle(),
                            textAlign: TextAlign.center,
                          )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25.0),
                      child: new Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Flexible(
                            child: firstNameTextField(context),
                            flex: 1,
                          ),
                          SizedBox(
                            width: 17.0,
                          ),
                          Flexible(
                            child: lastNameTextField(context),
                            flex: 1,
                          ),
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
                    customPhoneNoWidget(context),
                    SizedBox(
                      height: 25.0,
                    ),
                    GradientButton(
                      onTap: () {
//                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      text: AppStrings.UPDATE_PROFILE,
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

  getImage(String type) async {
    var permissionResult = (type == 'camera')
        ? await MediaPermissionHandler.checkCameraPermission()
        : await MediaPermissionHandler.checkGalleryPermission();
    print(permissionResult);
    if (permissionResult) {
      final PickedFile pickedFile = await _picker.getImage(
          source: type == 'camera' ? ImageSource.camera : ImageSource.gallery);

      File rotatedImage =
      await FlutterExifRotation.rotateImage(path: pickedFile.path);

      setState(() {
        if (rotatedImage != null) {
          setState(() {
            _image = null;
          });
          _image = File(rotatedImage.path);
        } else {
          print('No image selected.');
        }
      });
    } else {
      Platform.isIOS
          ? AppSettings.openLocationSettings()
          : AppSettings.openAppSettings();
    }
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
//                      composing:
//                          new TextRange(start: 0, end: firstNameValidation));
//                  //  _emailController.text = text;
//                }
//              },
              controller: firstNameController,
              keyboardType: TextInputType.name,
              inputFormatters: [
                LengthLimitingTextInputFormatter(firstNameValidation),
              ],
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(lastNameFocus),

              onFieldSubmitted: (texttt) {
                FocusScope.of(context).requestFocus(lastNameFocus);
              },
              textInputAction: TextInputAction.next,
              decoration: AppStyles.decorationWithBorder(AppStrings.FIRST_NAME),
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
//                      composing:
//                          new TextRange(start: 0, end: lastNameValidation));
//                  //  _emailController.text = text;
//                }
//              },
              controller: lastNameController,
              keyboardType: TextInputType.name,
              inputFormatters: [
                LengthLimitingTextInputFormatter(lastNameValidation),
              ],
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(emailFocus),

              onFieldSubmitted: (texttt) {
                FocusScope.of(context).requestFocus(emailFocus);
              },
              textInputAction: TextInputAction.next,
              decoration: AppStyles.decorationWithBorder(AppStrings.LAST_NAME),
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
              enabled: false,
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
              keyboardType: TextInputType.emailAddress,
              inputFormatters: [
                LengthLimitingTextInputFormatter(emailValidation),
              ],
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(phoneNoFocus),

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
                FocusScope.of(context).requestFocus(phoneNoFocus);
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
        Positioned(
                top: 20.0,
                bottom: 0.0,
                right: 40.0,
                child: GestureDetector(
                  onTap: (){

                    showEmailBottomSheet(context);
                  },
                  child: Text(
                    "Change",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 12.0,
                        color: AppColors.BLUE_COLOR,
                        fontFamily: AppFonts.POPPINS_MEDIUM,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
      ],
    );
  }

  Stack customPhoneNoWidget(BuildContext context) {
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
              enabled: false,
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

              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(addressFocus),

              onFieldSubmitted: (texttt) {
                FocusScope.of(context).requestFocus(addressFocus);
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
        Positioned(
          top: 20.0,
          bottom: 0.0,
          right: 40.0,
          child: GestureDetector(
            onTap: (){

              showPhoneNoBottomSheet(context);
            },
            child: Text(
              "Change",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 12.0,
                  color: AppColors.BLUE_COLOR,
                  fontFamily: AppFonts.POPPINS_MEDIUM,
                  fontWeight: FontWeight.w400),
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
                numberController.selection = TextSelection.fromPosition(
                    TextPosition(offset: numberController.text.length));
              }
            },
            child: TextFormField(
//                                enableInteractiveSelection: false,
              enabled: false,
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

  Stack emailWidget(BuildContext context) {
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
              enabled: false,
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
              keyboardType: TextInputType.emailAddress,
              inputFormatters: [
                LengthLimitingTextInputFormatter(emailValidation),
              ],
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

  Stack editableCustomEmailTextField(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.0),
          child: Focus(
            onFocusChange: (value) {
              if (value) {
                editableEmailController.selection = TextSelection.fromPosition(
                    TextPosition(offset: editableEmailController.text.length));
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
                  editableEmailController.value = new TextEditingValue(
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
              controller: editableEmailController,
              keyboardType: TextInputType.emailAddress,
              inputFormatters: [
                LengthLimitingTextInputFormatter(emailValidation),
              ],


              onFieldSubmitted: (texttt) {
                bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(email);
                if (emailValid) {
                  setState(() {
                    _isEmailValid = true;
                    emailController.text = texttt;
                  });
                } else {
                  setState(() {
                    _isEmailValid = false;
                  });
                }
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

  Stack editableCustomPhoneNoWidget(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.0),
          child: Focus(
            onFocusChange: (value) {
              if (value) {
                editableNumberController.selection = TextSelection.fromPosition(
                    TextPosition(offset: editableNumberController.text.length));
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
                  editableNumberController.value = new TextEditingValue(
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
              controller: editableNumberController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(numberValidation),
              ],

              onFieldSubmitted: (texttt) {
                numberController.text = texttt;
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

  showPhoneNoBottomSheet(BuildContext context) {
    showBottomSheetWidget(context, AppStrings.REQUEST_TO_PHONE_NUMBER_TITLE,

        AppStrings.PHONE_NUMBER_DESC, phoneNoWidget(context), (bc3) {
          Navigator.pop(bc3);
          showPhoneOtpBottomSheet(context);
        }, AppStrings.SEND, false);
  }

  showPhoneOtpBottomSheet(BuildContext context) {
    showBottomSheetWidget(context, AppStrings.ENTER_OTP_DIGIT,
        AppStrings.OTP_DESC, OtpTextField(), (bc4) {
          Navigator.pop(bc4);
          showUpdatePhoneNoBottomSheet(context);
        }, AppStrings.VERIFY_NOW, true);
  }

  showUpdatePhoneNoBottomSheet(BuildContext context) {
    showBottomSheetWidget(context, AppStrings.ENTER_NEW_PHONE,
        "", editableCustomPhoneNoWidget(context), (bc3) {
          Navigator.pop(bc3);
        }, AppStrings.CHANGE, false);
  }

  showEmailOtpBottomSheet(BuildContext context) {
    showBottomSheetWidget(context, AppStrings.ENTER_OTP_DIGIT,
        AppStrings.OTP_DESC, OtpTextField(), (bc4) {
          Navigator.pop(bc4);
          showUpdateEmailBottomSheet(context);
        }, AppStrings.VERIFY_NOW, true);
  }

  showEmailBottomSheet(BuildContext context) {
    showBottomSheetWidget(context, AppStrings.REQUEST_TO_EMAIL_TITLE,
        AppStrings.EMAIL_DESC, emailWidget(context), (bc3) {
          Navigator.pop(bc3);
          showEmailOtpBottomSheet(context);
        }, AppStrings.CHANGE, false);
  }

  showUpdateEmailBottomSheet(BuildContext context) {
    showBottomSheetWidget(context, AppStrings.ENTER_NEW_EMAIL,
        "", editableCustomEmailTextField(context), (bc3) {
          Navigator.pop(bc3);

        }, AppStrings.CHANGE, false);
  }

  profilePictureOptionsBottomSheet() {
    showModalBottomSheet(
        backgroundColor: AppColors.WHITE_COLOR,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(30.0),topLeft: Radius.circular(30.0)),
        ),
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: 220.0,
              margin: EdgeInsets.only(left: 50, right: 50, bottom: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  SvgPicture.asset(
                    AppImages.BOTTOM_SHEET,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Profile Photo",
                    style: AppStyles.blackWithBoldFontTextStyle(context, 20.0),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _image = null;
                          });
                          Navigator.pop(bc);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.BLUE_COLOR,
                              radius: 30,
                              child: Icon(
                                Icons.delete_outline_outlined,
                                color: Colors.white,
                                size: 24.0,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Remove",
                              style:
                              AppStyles.detailWithSmallTextSizeTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(bc);

                          getImage('gallery');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.BLUE_COLOR,
                              radius: 30,
                              child: Icon(
                                Icons.image,
                                color: Colors.white,
                                size: 24.0,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Gallery",
                              style:
                              AppStyles.detailWithSmallTextSizeTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(bc);

                          getImage('camera');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.BLUE_COLOR,
                              radius: 30,
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                                size: 24.0,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Camera",
                              style:
                              AppStyles.detailWithSmallTextSizeTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }


}
