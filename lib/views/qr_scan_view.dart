import 'dart:async';
import 'dart:math';

import 'package:intl/intl.dart';
import 'package:ampd/app/app.dart';
import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_constants.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/data/model/SubmitReviewModel.dart';
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
import 'package:ampd/utils/timer_utils.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class QrScanView extends StatefulWidget {
  Map<String, dynamic> map;
  QrScanView(this.map);

  @override
  _QrScanState createState() => _QrScanState();
}

class _QrScanState extends State<QrScanView> with TickerProviderStateMixin {
  double offerRating = 0.0;
  AnimationController _buttonController;
  QrScanViewModel _qrScanViewModel;
  bool _enabled = true;
  bool _isInternetAvailable = true;
  BuildContext customDialogBoxContext;
  String reviewMessage = "";
  Timer _timer1;
  int _sec = 30;
  int _secc = 3;
  ScrollController controller = ScrollController();
  Timer _timer;
  String _time = "2022-4-15 09:00:00";
  String _days = "00";
  String _hours = "00";
  String _newHours = "00";
  String _min = "00";
  String _secs = "00";

  int _hoursDays = 0;

  @override
  void initState() {
    super.initState();

   /* var today = new DateTime.now();
    var updatedDate = today.add(new Duration(hours: widget.map['availTime']));
    _time = DateFormat('yyyy-MM-dd HH:mm:ss').format(updatedDate);


    startTimer();
    if (!TimerUtils.isAheadOrBefore(_time)) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (!TimerUtils.isAheadOrBefore(_time)) {
          if (mounted) {
            setState(() {
              _days = TimerUtils.getDays(_time, 'days');
              int dayHour = int.parse(_days)*24;
              _hours = TimerUtils.getDays(_time, 'hours');
              _hoursDays = (int.parse(_hours)+dayHour);
              if(_hoursDays>9){
                _newHours ="$_hoursDays";
              }else{
                _newHours ="0$_hoursDays";
              }
              _min = TimerUtils.getDays(_time, 'min');
              _secs = TimerUtils.getDays(_time, 'sec');
            });
          }
        } else {
          _timer.cancel();
          if (mounted) {
            setState(() {
              _days = "10";
              _hours = "00";
              _min = "00";
              _secs = "00";
            });
          }
        }
      });
    }*/

    var date = TimerUtils.formatUTCTime1(widget.map['redeem_at']);
    List<String> split1String = date.split(" ");
    List<String> split2String = split1String[0].split("-");
    List<String> split3String = split1String[1].split(":");
    DateTime offerDate = DateTime.utc(int.parse(split2String[0]),int.parse(split2String[1]),int.parse(split2String[2]),int.parse(split3String[0]),int.parse(split3String[1]),int.parse(split3String[2]) );
    var local = offerDate.toLocal();

    var updatedDate = local.add(new Duration(hours: widget.map['availTime']));
    _time = DateFormat('yyyy-MM-dd HH:mm:ss').format(updatedDate);
    print(local);
    print(updatedDate);
    print(split2String);
    print(split3String);
    if (!TimerUtils.isAheadOrBefore(_time)) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (!TimerUtils.isAheadOrBefore(_time)) {
          if (mounted) {
            setState(() {
              _days = TimerUtils.getDays(_time, 'days');
              int dayHour = int.parse(_days)*24;
              _hours = TimerUtils.getDays(_time, 'hours');
              _hoursDays = (int.parse(_hours)+dayHour);
              if(_hoursDays>9){
                _newHours ="$_hoursDays";
              }else{
                _newHours ="0$_hoursDays";
              }
              _min = TimerUtils.getDays(_time, 'min');
              _secs = TimerUtils.getDays(_time, 'sec');
            });
          }
        } else {
          _timer.cancel();
          if (mounted) {
            setState(() {
              _days = "10";
              _hours = "00";
              _min = "00";
              _secs = "00";
            });
          }
        }
      });
    }
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
              timer.cancel();
              Navigator.pop(context);
            }
          });

          print(_sec);

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Text(
                      AppStrings.SCAN_QR_CODE,
                      style: AppStyles.blackWithBoldFontTextStyle(context, 15.0.sp),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,

                      child: Center(
                        child: Image.network(
                          widget.map['qrImage'] != null ? widget.map['qrImage']:"",
                          fit: BoxFit.cover,
                        )
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
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
                                    context, 12.0.sp),
                                textAlign: TextAlign.center,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 35),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: ShapeDecoration(
                          color:AppColors.colorLightGrey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(
                                  width: 0.5, color: AppColors.COLOR_BLACK))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Column(
                            children: [

                              Text(
                                _newHours.toString(),
                                style: AppStyles.blackWithBoldFontTextStyle(context, 30.0).copyWith(color: AppColors.WHITE_COLOR)
                                ,
                              ),
                              Text(
                                //widget.data.recurrenceTime > 1? 'Hours' : 'Hour',
                                int.parse(_newHours) > 1 ? 'Hours' : 'Hour',
                                style: AppStyles.poppinsTextStyle(
                                    fontSize: 10.0.sp,
                                    weight: FontWeight.w300).copyWith(color:AppColors.WHITE_COLOR),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [

                                Text(
                                  ":",
                                  style: AppStyles.blackWithBoldFontTextStyle(context, 30.0).copyWith(color: AppColors.WHITE_COLOR)
                                  ,
                                ),
                                Text(
                                  //widget.data.recurrenceTime > 1? 'Hours' : 'Hour',
                                  ":",
                                  style: AppStyles.poppinsTextStyle(
                                      fontSize: 10.0.sp,
                                      weight: FontWeight.w300).copyWith(color:AppColors.WHITE_COLOR),
                                ),
                              ],
                            ),
                          ),

                          Column(
                            children: [


                              Text(
                                _min,
                                style: AppStyles.blackWithBoldFontTextStyle(context, 30.0).copyWith(color: AppColors.WHITE_COLOR)
                                ,
                              ),
                              Text(
                                'Mins',
                                style: AppStyles.poppinsTextStyle(
                                    fontSize: 10.0.sp,
                                    weight: FontWeight.w300).copyWith(color:AppColors.WHITE_COLOR),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [

                                Text(
                                  ":",
                                  style: AppStyles.blackWithBoldFontTextStyle(context, 30.0).copyWith(color: AppColors.WHITE_COLOR)
                                  ,
                                ),
                                Text(
                                  //widget.data.recurrenceTime > 1? 'Hours' : 'Hour',
                                  ":",
                                  style: AppStyles.poppinsTextStyle(
                                      fontSize: 10.0.sp,
                                      weight: FontWeight.w300).copyWith(color:AppColors.WHITE_COLOR),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [

                              Text(
                                _secs,
                                style: AppStyles.blackWithBoldFontTextStyle(context, 30.0).copyWith(color: AppColors.WHITE_COLOR)
                                ,
                              ),
                              Text(
                                'Secs',
                                style: AppStyles.poppinsTextStyle(
                                    fontSize: 10.0.sp,
                                    weight: FontWeight.w300).copyWith(color:AppColors.WHITE_COLOR),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    GradientButton(
                      onTap: () {

                          _timer.cancel();
                          Navigator.pop(context);

                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context1) {
                              customDialogBoxContext = context1;
                              return CustomRatingDialog(
                                contex: context,
                                subTitle: "How was ${widget.map['storeName']}?",
                                title: "Help other AMPD users by leaving a store review",
                                ratingBar: RatingBarWidget(onRatingChange: (onRatingChanged){
                                  offerRating = onRatingChanged;
                                },),
                                buttonText1: AppStrings.SUBMIT,
                                onPressed1: (message) {
                                  reviewMessage = message;
                                },
                                onPressed2: () {
                                  if (widget.map['fromSavedCoupon']) {
                                    Navigator.pop(customDialogBoxContext);
                                    Navigator.pushNamedAndRemoveUntil(
                                        customDialogBoxContext, AppRoutes.DASHBOARD_VIEW, (
                                        route) => false, arguments: {
                                      'isGuestLogin': false,
                                      'tab_index': 0,
                                      'show_tutorial': false
                                    });
                                  } else {
                                    Navigator.pop(customDialogBoxContext);
                                  }
                                },
                                btnWidget:AnimatedGradientButton(
                                  onAnimationTap: () {
                                    if(offerRating > 0.0) {
                                      if(reviewMessage.isNotEmpty) {
                                        callOfferReview(
                                            widget.map['offer_id'], reviewMessage,
                                            offerRating.toString());
                                      }else{
                                        Util.hideKeyBoard(customDialogBoxContext);
                                        ToastUtil.showToast(customDialogBoxContext, "Please write a review");
                                      }
                                    }else{
                                      Util.hideKeyBoard(customDialogBoxContext);
                                      ToastUtil.showToast(customDialogBoxContext, "Please rate this store");
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
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .08),
                      padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
                      child: Text(
                        "Offer will vanish if page is closed.",
                        style:
                        AppStyles.blackWithSemiBoldFontTextStyle(context, 13.0.sp).copyWith(fontWeight: FontWeight.w400),textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
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

      if (response.success) {
        if (response.msg == "Review created successfully!") {
          ToastUtil.showToast(customDialogBoxContext, response.msg);
          if (widget.map['fromSavedCoupon']) {
            Navigator.pop(customDialogBoxContext);
            Navigator.pushNamedAndRemoveUntil(
                customDialogBoxContext, AppRoutes.DASHBOARD_VIEW, (
                route) => false, arguments: {
              'isGuestLogin': false,
              'tab_index': 0,
              'show_tutorial': false
            });
          } else {
            Navigator.pop(customDialogBoxContext);
          }
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
  final ValueChanged<double> onRatingChange;
  const RatingBarWidget({Key key,this.onRatingChange}) : super(key: key);

  @override
  _RatingBarWidgetState createState() => _RatingBarWidgetState();
}

class _RatingBarWidgetState extends State<RatingBarWidget> {
  @override
  Widget build(BuildContext context) {

    return RatingBar(
      onRatingUpdate: (rating) {
        setState(() {
          widget.onRatingChange(rating);
        });

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
      initialRating: 0.0,
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
