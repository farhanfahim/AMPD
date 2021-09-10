import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ampd/app/app.dart';
import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_constants.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/data/database/app_preferences.dart';
import 'package:ampd/data/model/login_response_model.dart';
import 'package:ampd/data/model/verificationCodeToEmailModel.dart';
import 'package:ampd/utils/MediaPermissionHandler.dart';
import 'package:ampd/utils/ToastUtil.dart';
import 'package:ampd/utils/Util.dart';
import 'package:ampd/utils/loader.dart';
import 'package:ampd/viewmodel/edit_profile_viewmodel.dart';
import 'package:ampd/widgets/animated_gradient_button.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:ampd/widgets/custom_text_form.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:ampd/widgets/otp_text_field.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:app_settings/app_settings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

// import 'package:images_picker/images_picker.dart';
import 'package:sizer/sizer.dart';

import '../appresources/app_colors.dart';
import '../appresources/app_colors.dart';
import '../appresources/app_strings.dart';

class EditProfileView extends StatefulWidget {
  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> with TickerProviderStateMixin {
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
  bool _isInAsyncCall = false;
  bool _isInternetAvailable = true;

  bool _emailChanged = false;
  bool _phoneChanged = false;
  bool _imageChanged = false;

  var firstNameFocus = FocusNode();
  var lastNameFocus = FocusNode();
  var emailFocus = FocusNode();
  var email2Focus = FocusNode();
  var addressFocus = FocusNode();
  var phoneNoFocus = FocusNode();

  final _picker = ImagePicker();

  String firstName = "";
  String lastName = "";
  String email = "";
  String address = "";
  String phoneNo = "";
  String imageUrl = "";

  bool _isEmailValid = false;
  IconData checkIconData = Icons.check;

  File _image = null;

  AppPreferences _appPreferences = new AppPreferences();

  String _fullName = "";

  EditProfileViewModel _editProfileViewModel;

  AnimationController _codeToEmailButtonController;
  AnimationController _codeToPhoneButtonController;
  AnimationController _phoneOtpButtonController;
  AnimationController _emailOtpButtonController;
  AnimationController _changeEmailButtonController;
  AnimationController _changePhoneButtonController;
  AnimationController _updateProfileButtonController;

  String code = "";

  LoginResponseModel userDetails;
  @override
  void initState() {
    super.initState();

    _codeToEmailButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _codeToPhoneButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _phoneOtpButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _emailOtpButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _changeEmailButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _changePhoneButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _updateProfileButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    
    _appPreferences.isPreferenceReady;
    _appPreferences.getUserDetails().then((userData) {
      print(userData.toJson());

      userDetails = userData;
      setState(() {
        emailController.text = userData.data.email;
        numberController.text = userData.data.phone;
        firstNameController.text = userData.data.firstName;
        lastNameController.text = userData.data.lastName;
        imageUrl = userData.data.imageUrl;
        _fullName = "${userData.data.firstName} ${userData.data.lastName}";
      });
    });

    _editProfileViewModel = EditProfileViewModel(App());
    subscribeToViewModel();

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
  void dispose() {
    _codeToEmailButtonController.dispose();
    _codeToPhoneButtonController.dispose();
    _phoneOtpButtonController.dispose();
    _emailOtpButtonController.dispose();
    _changeEmailButtonController.dispose();
    _changePhoneButtonController.dispose();
    _updateProfileButtonController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // call this method here to hide soft keyboard
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: ModalProgressHUD(
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
                                child: imageUrl.isNotEmpty? ClipRRect(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(80.0)),
                                    child: circularNetworkCacheImageWithShimmerWithHeightWidth(
                                        imagePath: imageUrl,
                                      radius: 120.0,
                                      boxFit: BoxFit.cover
                                    )
                                  ) : _image != null
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
                                          "assets/images/user.png",
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
                        _fullName,
                        style:
                            AppStyles.blackWithBoldFontTextStyle(context, 30.0).copyWith(fontWeight: FontWeight.bold),
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
                      AnimatedGradientButton(
                        onAnimationTap: () {
                          callUpdateProfileApi();
                        },
                        buttonController: _updateProfileButtonController,
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
      ),
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
            imageUrl = "";
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
              style: AppStyles.inputTextStyle(context).copyWith(color: Colors.black,),
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
              style: AppStyles.inputTextStyle(context).copyWith(color: Colors.black,),
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
              enableInteractiveSelection: false,
              enabled: false,
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
//
              enabled: _enabled,
              focusNode: emailFocus,
              cursorColor: AppColors.ACCENT_COLOR,
              onChanged: (String newVal) {
                if (newVal.length <= emailValidation) {
                  email = newVal;
                }
                else {
                  editableEmailController.value = new TextEditingValue(
                      text: email,
                      selection: new TextSelection(
                          baseOffset: emailValidation,
                          extentOffset: emailValidation,
                          affinity: TextAffinity.downstream,
                          isDirectional: false),
                      composing: new TextRange(start: 0, end: emailValidation));
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
              keyboardType: TextInputType.phone,
              inputFormatters: [
                LengthLimitingTextInputFormatter(numberValidation),
              ],

              onFieldSubmitted: (texttt) {
                numberController.text = texttt;
              },
              textInputAction: TextInputAction.done,
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
    showBottomSheetWidgetWithAnimatedBtn(
        context, AppStrings.REQUEST_TO_PHONE_NUMBER_TITLE,
        AppStrings.PHONE_NUMBER_DESC,
        // phoneNoWidget(context),
        editableCustomPhoneNoWidget(context),
        AnimatedGradientButton(
          onAnimationTap: () {
            if (validatePhone()) {
              callVerificationCodeToPhoneApi();
            }
          },
          buttonController: _codeToPhoneButtonController,
          text: AppStrings.CHANGE,
        ),
            null,(bc1) {
//          Navigator.pop(bc1);
//          showPhoneOtpBottomSheet(context);
        }, AppStrings.SEND, false);
  }

  showPhoneOtpBottomSheet(BuildContext context) {
    showBottomSheetWidgetWithAnimatedBtn(context, AppStrings.ENTER_OTP_DIGIT,
        AppStrings.OTP_DESC_PHONE, OtpTextField(onOtpCodeChanged: (otp) {
          code = otp;
        }),
        AnimatedGradientButton(
          onAnimationTap: () {
            if (validatePhone()) {
              callVerifyPhoneOtpApi();
            }
          },
          buttonController: _phoneOtpButtonController,
          text: AppStrings.VERIFY_NOW,
        ),
          () { callVerificationCodeToPhoneApi();},(bc2) {
//          Navigator.pop(bc2);
//          showUpdatePhoneNoBottomSheet(context);
        }, AppStrings.VERIFY_NOW, true,);
  }

  showUpdatePhoneNoBottomSheet(BuildContext context) {
    showBottomSheetWidgetWithAnimatedBtn(context, AppStrings.ENTER_NEW_PHONE,
        "", editableCustomPhoneNoWidget(context),
        AnimatedGradientButton(
          onAnimationTap: () {
            if (validatePhone()) {
              callChangePhoneApi();
            }
          },
          buttonController: _changePhoneButtonController,
          text: AppStrings.UPDATE,
        ),
            null,(bc3) {
//          Navigator.pop(bc3);
        }, AppStrings.CHANGE, false,);
  }

  showEmailOtpBottomSheet(BuildContextcontext) {
    showBottomSheetWidgetWithAnimatedBtn(
        context,
        AppStrings.ENTER_OTP_DIGIT,
        AppStrings.OTP_DESC_EMAIL,
        OtpTextField(onOtpCodeChanged: (otp) {
          code = otp;
        }),
        AnimatedGradientButton(
          onAnimationTap: () {
            if (validateEmail()) {
              callVerifyEmailOtpApi();
            }
          },
          buttonController: _emailOtpButtonController,
          text: AppStrings.VERIFY_NOW,
        ),() {callVerificationCodeToEmailApi();},
        (bc4) {
//          Navigator.pop(bc4);
//          showUpdateEmailBottomSheet(context);
        },
        AppStrings.VERIFY_NOW,
        true,
    );
  }
  
  showEmailBottomSheet(BuildContext context) {
    showBottomSheetWidgetWithAnimatedBtn(
        context,
        AppStrings.REQUEST_TO_EMAIL_TITLE,
        AppStrings.EMAIL_DESC,
        // emailWidget(context),
        customEditableEmailWidget(editableEmailController),
        AnimatedGradientButton(
          onAnimationTap: () {
            if (validateEmail()) {
              callVerificationCodeToEmailApi();
            }
          },
          buttonController: _codeToEmailButtonController,
          text: AppStrings.CHANGE,
        ),
           null, (bc5) {
          // Navigator.pop(bc5);
          // showEmailOtpBottomSheet(context);
//          callVerificationCodeToEmailApi();
        },
        AppStrings.CHANGE,
        false,);
  }

  showUpdateEmailBottomSheet(BuildContext context) {
    showBottomSheetWidgetWithAnimatedBtn(
        context,
        AppStrings.ENTER_NEW_EMAIL,
        "",
        customEditableEmailWidget(editableEmailController),
        AnimatedGradientButton(
          onAnimationTap: () {
            if (validateEditableEmail()) {
              callChangeEmailApi();
            }
          },
          buttonController: _changeEmailButtonController,
          text: AppStrings.UPDATE,
        ),
            null,(bc6) {
//          Navigator.pop(bc6);

        },
        AppStrings.CHANGE,
        false,);
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

  Future<void> callVerificationCodeToEmailApi() async {
    _playCodeToEmailBtnAnimation();

    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
//          _isInAsyncCall = true;
        });

        print('email ${editableEmailController.text}');

        var map = Map<String, dynamic>();
        map['email'] = editableEmailController.text.trim().toString();
        _editProfileViewModel.verificationCodeToEmail(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
          ToastUtil.showToast(context, "No internet");
        });
      }
    });
  }

  Future<void> callVerificationCodeToPhoneApi() async {
    _playCodeToPhoneBtnAnimation();

    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
//          _isInAsyncCall = true;
        });

        print('number ${editableNumberController.text}');

        var map = Map<String, dynamic>();
        map['phone'] = editableNumberController.text.trim().toString();
        _editProfileViewModel.verificationCodeToPhone(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
          ToastUtil.showToast(context, "No internet");
        });
      }
    });
  }

  Future<void> callChangeEmailApi() async {
    _playChangeEmailBtnAnimation();

    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
          _emailChanged = true;
//          _isInAsyncCall = true;
        });

        print('email ${editableEmailController.text}');

        var map = Map<String, dynamic>();
        map['email'] = editableEmailController.text.trim().toString();
        _editProfileViewModel.changeEmail(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
          ToastUtil.showToast(context, "No internet");
        });
      }
    });
  }

  Future<void> callChangePhoneApi() async {
    _playChangePhoneBtnAnimation();

    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
          _phoneChanged = true;
//          _isInAsyncCall = true;
        });

        print('number ${editableNumberController.text}');

        var map = Map<String, dynamic>();
        map['phone'] = editableNumberController.text.trim().toString();
        _editProfileViewModel.changePhone(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
          ToastUtil.showToast(context, "No internet");
        });
      }
    });
  }

  Future<void> callVerifyEmailOtpApi() async {
    _playEmailOtpBtnAnimation();

    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
//          _isInAsyncCall = true;
        });

        print('email ${editableEmailController.text}');

        var map = Map<String, dynamic>();
        map['email'] = editableEmailController.text.trim().toString();
        map['code'] = code;
        _editProfileViewModel.verifyEmailOtp(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
          ToastUtil.showToast(context, "No internet");
        });
      }
    });
  }

  Future<void> callVerifyPhoneOtpApi() async {
    _playPhoneOtpBtnAnimation();

    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
//          _isInAsyncCall = true;
        });

        print('number ${editableNumberController.text}');

        var map = Map<String, dynamic>();
        map['phone'] = editableNumberController.text.trim().toString();
        map['code'] = code;
        _editProfileViewModel.verifyPhoneOtp(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
          ToastUtil.showToast(context, "No internet");
        });
      }
    });
  }

  Future<void> callUpdateProfileApi() async {
    _playUpdateProfileBtnAnimation();

    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
          _imageChanged = true;
//          _isInAsyncCall = true;
        });

        var map = Map<String, dynamic>();
        map['image'] = _image;
        map['first_name'] = firstNameController.text.trim();
        map['last_name'] = lastNameController.text.trim();
        _editProfileViewModel.updateProfile(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
          ToastUtil.showToast(context, "No internet");
        });
      }
    });
  }

  void subscribeToViewModel() {
    _editProfileViewModel
        .getEditProfileRepository()
        .getRepositoryResponse()
        .listen((response) async {
          _stopAnimation();
      if (mounted) {
        setState(() {
          _enabled = true;
          _isInAsyncCall = false;
        });
      }

      if (response.success) {
        if (response.data is VerficationCodeToEmailModel) {
          VerficationCodeToEmailModel model = response.data;

          //        print('field ${model.data[0].field}');
          ToastUtil.showToast(context, response.msg);
           Navigator.pop(context);
           Future.delayed(Duration(seconds: 1), () {
             showEmailOtpBottomSheet(context);
           });
        } else if (response.data is LoginResponseModel) {  //update profile response
          ToastUtil.showToast(context, response.msg);
          print('response ${response.data}');
          LoginResponseModel newDetails = response.data;
          print('response ${newDetails.data.imageUrl}');
          _appPreferences.setUserDetails(data: jsonEncode(newDetails));
          Navigator.pop(context);
        } else if (response.data == 1) {  //verfication code to phone response
          ToastUtil.showToast(context, response.msg);
          Navigator.pop(context);
          Future.delayed(Duration(seconds: 1), () {
            showPhoneOtpBottomSheet(context);
          });
        } else if (response.data == 2) {  //verify phone otp response
          ToastUtil.showToast(context, response.msg);
          Navigator.pop(context);
          Future.delayed(Duration(seconds: 1), () {
            showUpdatePhoneNoBottomSheet(context);
          });
        }  else if (response.data == 0) { //email/phone updated response

          ToastUtil.showToast(context, response.msg);

          if(_emailChanged) {
            print('response ${editableEmailController.text.trim()}');

            userDetails.data.email = editableEmailController.text.trim();
            emailController.text = editableEmailController.text.trim();
          } else if(_phoneChanged) {
            print('response ${editableNumberController.text.trim()}');

            userDetails.data.phone = editableNumberController.text.trim();
            numberController.text = editableNumberController.text.trim();
          }
          _appPreferences.setUserDetails(data: jsonEncode(userDetails));
          Navigator.pop(context);
        } else if (response.data == null) {
          Navigator.pop(context);
          ToastUtil.showToast(context, response.msg);
          Future.delayed(Duration(seconds: 1), () {
            showUpdateEmailBottomSheet(context);
          });
        }
      } else if (response.data is DioError) {
        if (response.statusCode == 401) {
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.WELCOME_VIEW, (Route<dynamic> route) => false);
        }else{
          _isInternetAvailable = Util.showErrorMsg(context, response.data);
        }
      } else {
        ToastUtil.showToast(context, response.msg);
      }
    });
  }

  bool validateEmail() {
    Util.hideKeyBoard(context);

    var emailRegex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    var email = emailController.text.trim().toString();

    if(email.isEmpty || email == "") {
      ToastUtil.showToast(context, AppStrings.EMAIL_VALIDATION);
      return false;
    }

    if(!emailRegex.hasMatch(email)) {
      ToastUtil.showToast(context, AppStrings.EMAIL_VALIDATION);
      return false;
    }
    
    return true;    
  }

  bool validateEditableEmail() {
    Util.hideKeyBoard(context);

    var emailRegex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    var email = editableEmailController.text.trim().toString();

    if(email.isEmpty || email == "") {
      ToastUtil.showToast(context, AppStrings.EMAIL_VALIDATION);
      return false;
    }

    if(!emailRegex.hasMatch(email)) {
      ToastUtil.showToast(context, AppStrings.EMAIL_VALIDATION);
      return false;
    }

    return true;
  }

  bool validatePhone() {
    Util.hideKeyBoard(context);

    var phone = editableNumberController.text.trim();

    if (phone.isEmpty || phone == "") {

      ToastUtil.showToast(context, "Please provide your phone number");
      return false;
    }else if(phone.length < 11){
      ToastUtil.showToast(
          context, "Phone number is too short ");
      return false;

    }
      else if(phone.length > 16){
        ToastUtil.showToast(
            context, "Phone number is too long ");
        return false;

      }else{
        return true;
      }
  }

  Future<Null> _playCodeToPhoneBtnAnimation() async {
    try {
      await _codeToPhoneButtonController.forward();
    } on TickerCanceled {}
  }

  Future<Null> _stopAnimation() async {
    try {
      await _codeToPhoneButtonController.reverse();
      await _codeToEmailButtonController.reverse();
      await _emailOtpButtonController.reverse();
      await _phoneOtpButtonController.reverse();
      await _changeEmailButtonController.reverse();
      await _changePhoneButtonController.reverse();
      await _updateProfileButtonController.reverse();
    } on TickerCanceled {}
  }

  Future<Null> _playCodeToEmailBtnAnimation() async {
    try {
      await _codeToEmailButtonController.forward();
    } on TickerCanceled {}
  }

  Future<Null> _playEmailOtpBtnAnimation() async {
    try {
      await _emailOtpButtonController.forward();
    } on TickerCanceled {}
  }

  Future<Null> _playPhoneOtpBtnAnimation() async {
    try {
      await _phoneOtpButtonController.forward();
    } on TickerCanceled {}
  }

  Future<Null> _playChangeEmailBtnAnimation() async {
    try {
      await _changeEmailButtonController.forward();
    } on TickerCanceled {}
  }

  Future<Null> _playChangePhoneBtnAnimation() async {
    try {
      await _changePhoneButtonController.forward();
    } on TickerCanceled {}
  }

  Future<Null> _playUpdateProfileBtnAnimation() async {
    try {
      await _updateProfileButtonController.forward();
    } on TickerCanceled {}
  }
}

class customEditableEmailWidget extends StatefulWidget {

  TextEditingController editableEmailController;

  customEditableEmailWidget(this.editableEmailController);

  @override
  _customEditableEmailWidgetState createState() => _customEditableEmailWidgetState();
}

class _customEditableEmailWidgetState extends State<customEditableEmailWidget> {

  var email2Focus = FocusNode();
  int emailValidation = AppConstants.EMAIL_VALIDATION;
  TextEditingController editableEmailController = new TextEditingController();
  bool _isEmailValid = false;
  IconData checkIconData = Icons.check;
  String email = "";
  bool _enabled = true;

  @override
  void initState() {
    super.initState();
    editableEmailController = widget.editableEmailController;
  }
  @override
  Widget build(BuildContext context) {
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
              focusNode: email2Focus,
              cursorColor: AppColors.ACCENT_COLOR,

              toolbarOptions: ToolbarOptions(
                copy: true,
                cut: true,
                paste: false,
                selectAll: false,
              ),
              onChanged: (String newVal) {
                bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(newVal);
                if (emailValid) {

                  setState(() {
                    _isEmailValid = true;
                    editableEmailController.text = newVal;
                  });
                } else {
                  setState(() {
                    _isEmailValid = false;
                  });
                }

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
                }
              },
              controller: editableEmailController,
              keyboardType: TextInputType.emailAddress,
              inputFormatters: [
                LengthLimitingTextInputFormatter(emailValidation),
              ],

              textInputAction: TextInputAction.done,
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
}

