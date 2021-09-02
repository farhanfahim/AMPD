import 'dart:async';
import 'dart:math';

import 'package:ampd/app/app.dart';
import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_constants.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/utils/ToastUtil.dart';
import 'package:ampd/utils/Util.dart';
import 'package:ampd/viewmodel/qr_scan_viewmodel.dart';
import 'package:ampd/widgets/animated_gradient_button.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:ampd/widgets/otp_text_field.dart';
import 'package:ampd/widgets/rating_dialog_view.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

double offerRating = 4.0;

class QrScanView extends StatefulWidget {
  Map<String, dynamic> map;
  QrScanView(this.map);

  @override
  _QrScanState createState() => _QrScanState();
}

class _QrScanState extends State<QrScanView> with TickerProviderStateMixin {
  AnimationController _buttonController;
  QrScanViewModel _qrScanViewModel;
  bool _enabled = true;
  bool _isInternetAvailable = true;
  BuildContext customDialogBoxContext;
  String reviewMessage = "";
  Timer _timer1;
  int _sec = 30;
  int _secc = 3;

  @override
  void initState() {
    super.initState();

    startTimer();
    _buttonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);

    _qrScanViewModel = QrScanViewModel(App());
    subscribeToViewModel();

  }


  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer1 = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_sec == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _sec--;
            if(_sec == 29){
              _secc = 2;
            }
            else if(_sec == 19){
              _secc = 1;
            }
            else if(_sec == 9){
              _secc = 0;
            }
            else if(_sec == 0){
              _sec = 0;
              _secc = 0;
              Navigator.pop(context);
            }
          });

          print(_sec);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
            title: "",
            onBackClick: () {
              Navigator.of(context).pop();
            },
            iconColor: AppColors.WHITE_COLOR),
        backgroundColor: AppColors.BLUE_COLOR,
        body: SafeArea(
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              constraints:
              BoxConstraints(maxWidth: double.maxFinite, minHeight: 50.0),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side:
                      BorderSide(width: 0.5, color: AppColors.BLUE_COLOR))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 40.0,
                    ),
                    Text(
                      AppStrings.SCAN_QR_CODE,
                      style: AppStyles.blackWithBoldFontTextStyle(context, 20.0),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      height: 30.0.h,
                      margin: EdgeInsets.fromLTRB(0.0, 30.0, 0, 0),
                      child: Center(
                        child: SvgPicture.asset(
                          AppImages.QR_IMAGE,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .14),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                              child: Text(
                                AppStrings.TIME_REMAINING_TO_SCAN,
                                style: AppStyles.blackWithBoldFontTextStyle(
                                    context, 16.0),
                                textAlign: TextAlign.center,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CountDownWidget(counter: _secc.toString()),
                        SizedBox(
                          width: 8.0,

                        ),
                        CountDownWidget(counter: _sec > 9?_sec.toString().substring(1):_sec.toString().substring(0)),
                      ],
                    ),

                    SizedBox(
                      height: 30.0,
                    ),
                    Text(AppStrings.SECONDS,
                        style: AppStyles.detailWithSmallTextSizeTextStyle()),
                    SizedBox(
                      height: 20.0,
                    ),
                    GradientButton(
                      onTap: () {
                        if (!widget.map['fromSavedCoupon']) {
                          Navigator.pop(context);
                        }
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context1) {
                              customDialogBoxContext = context1;
                              return CustomRatingDialog(
                                contex: context,
                                subTitle: "How was Starbucks?",
                                title: "Your feedback will help us improve our services.",
                                ratingBar: RatingBarWidget(),
                                buttonText1: AppStrings.SUBMIT,
                                onPressed1: (message) {
                                  reviewMessage = message;
                                },
                                btnWidget:AnimatedGradientButton(
                                  onAnimationTap: () {
                                    if(reviewMessage.isNotEmpty) {
                                      callOfferReview(
                                          widget.map['offer_id'], reviewMessage,
                                          offerRating.toString());
                                    }else{
                                      ToastUtil.showToast(customDialogBoxContext, "Your review is empty");
                                    }
                                  },
                                  buttonController: _buttonController,
                                  text: AppStrings.SUBMIT,
                                ),
                                showImage: false,
                              );
                            });

                      },
                      text: AppStrings.DONE,
                    ),
                    SizedBox(
                      height: 40.0,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> callOfferReview(int offerId,String review,String rating) async {
    _playAnimation();
    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        if (mounted) {
          setState(() {
            _isInternetAvailable = true;
          });
        }


        var map = Map();
        map['offer_id'] = offerId;
        map['review'] = review;
        map['rating'] = rating;
        _qrScanViewModel.offerReview(map);
      } else {
        if (mounted) {
          setState(() {
            _isInternetAvailable = false;
            ToastUtil.showToast(context, "No internet");
          });
        }

      }
    });
  }

 /* @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }*/

  void subscribeToViewModel() {

    _qrScanViewModel
        .getQrScanRepository()
        .getRepositoryResponse()
        .listen((response) async {

      _stopAnimation();

      if (mounted) {
        setState(() {
          _enabled = true;
        });
      }

      if (response.msg == "Review created successfully!") {
        ToastUtil.showToast(customDialogBoxContext, response.msg);
        if(widget.map['fromSavedCoupon']){
          Navigator.pop( customDialogBoxContext);
          Navigator.pushNamedAndRemoveUntil(customDialogBoxContext, AppRoutes.DASHBOARD_VIEW, (route) => false, arguments: {
            'isGuestLogin' : false,
            'tab_index' : 0,
            'show_tutorial' : false
          });
        }else{
          Navigator.pop( customDialogBoxContext);
        }

      } else if (response.data is DioError) {
        _isInternetAvailable = Util.showErrorMsg(context, response.data);
      } else {
        ToastUtil.showToast(context, response.msg);
      }
    });
  }

  Future<Null> _playAnimation() async {
    try {
      await _buttonController.forward();
    } on TickerCanceled {}
  }
  Future<Null> _stopAnimation() async {
    try {
      await _buttonController.reverse();
    } on TickerCanceled {}
  }
}



class RatingBarWidget extends StatefulWidget {
  const RatingBarWidget({Key key}) : super(key: key);

  @override
  _RatingBarWidgetState createState() => _RatingBarWidgetState();
}

class _RatingBarWidgetState extends State<RatingBarWidget> {
  @override
  Widget build(BuildContext context) {
    return RatingBar(
      onRatingUpdate: (rating) {
        offerRating = rating;
      },
      ratingWidget: RatingWidget(
          full: Icon(
            FontAwesomeIcons.solidStar,
            color: AppColors.GREEN_BRIGHT_COLOR,
          ),
          half: Icon(
            FontAwesomeIcons.starHalfAlt,
            color: AppColors.GREEN_BRIGHT_COLOR,
          ),
          empty: Icon(
            FontAwesomeIcons.star,
//                                    color: AppColors.PALE_YELLOW_COLOR,
            color: AppColors.GREY_COLOR,
          )
      ),
      itemSize: 22.0,
      initialRating: offerRating,
      allowHalfRating: true,
      glow: false,
      itemPadding: EdgeInsets.only(left: 5.0),
    );
  }
}


class CountDownWidget extends StatefulWidget {
  final String counter;
  const CountDownWidget({Key key,this.counter}) : super(key: key);

  @override
  _CountDownWidgetState createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                constraints: BoxConstraints(
                    maxWidth: 38.0, minHeight: 70.0),
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                    color: AppColors.COUNTDOWN_COLOR_LIGHT1,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10.0),
                        side: BorderSide(
                            width: 0.5,
                            color: AppColors.COUNTDOWN_COLOR_LIGHT1))),
              ),
              Container(
                constraints: BoxConstraints(
                    maxWidth: 38.0, minHeight: 32.0),
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                    color: AppColors.COUNTDOWN_COLOR_LIGHT2,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10.0),
                        side: BorderSide(
                            width: 0.5,
                            color: AppColors.COUNTDOWN_COLOR_LIGHT2))),
              ),

              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.counter,
                    style: AppStyles.blackWithBoldFontTextStyle(context, 30.0).copyWith(color: AppColors.WHITE_COLOR)
                    ,
                  ),
                ),
              ),

            ],
          )
        ],
      ),
    );
  }
}
