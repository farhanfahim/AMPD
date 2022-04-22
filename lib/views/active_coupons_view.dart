import 'dart:math';

import 'package:ampd/app/app.dart';
import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart' as gcl;
import 'package:location_permissions/location_permissions.dart';
import 'package:ampd/data/model/UserLocation.dart';
import 'package:location_permissions/location_permissions.dart'
as locationPermission;
import 'package:ampd/utils/LocationPermissionHandler.dart';
import 'dart:async';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/data/model/RedeemOfferModel.dart';
import 'package:ampd/data/model/SavedCouponModel.dart';
import 'package:ampd/utils/ToastUtil.dart';
import 'package:ampd/utils/Util.dart';
import 'package:ampd/utils/loader.dart';
import 'package:ampd/utils/timer_utils.dart';
import 'package:ampd/viewmodel/active_coupon_viewmodel.dart';
import 'package:ampd/widgets/NoRecordFound.dart';
import 'package:ampd/widgets/animated_gradient_button.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:ampd/widgets/dialog_view.dart';
import 'package:ampd/widgets/flat_button.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import 'package:ampd/data/database/app_preferences.dart';
class ActiveCouponsView extends StatefulWidget {


  ActiveCouponsView(Key key): super(key: key);
  @override
  ActiveCouponsState createState() => ActiveCouponsState();
}

class ActiveCouponsState extends State<ActiveCouponsView>
    with TickerProviderStateMixin {

  double minPrice = 0.0;
  double maxPrice = 0.0;

  bool _openSetting = false;
  UserLocation userLocation = UserLocation();
  gcl.Position position;
  BuildContext dialogContext;
  BuildContext dialogContext1;
  AnimationController _buttonController;
  AnimationController _buttonController1;
  int deletedItem;
  int _totalPages = 0;
  int _currentPage = 1;
  int _selectedIndex = 0;
  final PagingController<int, DataClass> _pagingController1 =
      PagingController(firstPageKey: 1);
  DataClass singleOfferModel;
  bool _enabled = true;
  bool _isPaginationLoading = false;
  bool _isInternetAvailable = false;
  SwipeActionController controller;
  ActiveCouponViewModel _activeCouponViewModel;

  double radius = 0.0;
  AppPreferences _appPreferences = new AppPreferences();
  @override
  void initState() {

    super.initState();


    _appPreferences.getUserDetails().then((userData) {
        setState(() {

          print("radius: ${userData.data.radius.toDouble()}");
          radius = userData.data.radius.toDouble();
        });
    });
    controller = SwipeActionController(selectedIndexPathsChangeCallback:
        (changedIndexPaths, selected, currentCount) {});

    _pagingController1.addPageRequestListener((pageKey) {
      print(pageKey);
      _fetchPage(pageKey);
    });


    _buttonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _buttonController1 = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);

    _activeCouponViewModel = ActiveCouponViewModel(App());
    subscribeToViewModel();
  }

  void applyFilter(Map<String, dynamic> map){

    setState(() {
      minPrice = map['minPrice'];
      maxPrice = map['maxPrice'];
      radius = map['minRadius'];
      print(map);
      _pagingController1.itemList.clear();
      setState(() {
        _isPaginationLoading = true;
      });
      getCurrentLocation();
    });
  }
  Future<void> _fetchPage(int pageKey) async {
    try {
      getCurrentLocation();

    } catch (error) {
      _pagingController1.error = error;
    }
  }

  @override
  void dispose() {
    _buttonController.dispose();
    _buttonController1.dispose();
    _pagingController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: AppColors.WHITE_COLOR,
        body: SafeArea(
          child: _isPaginationLoading?Container(
            height: MediaQuery.of(context).size.height ,
            child: Center(
              child: Container(
                height: 60.0,
                child: Loader(
                    isLoading: true,
                    color: AppColors.ACCENT_COLOR
                ),
              ),
            ),
          ):PagedListView<int, DataClass>(
            pagingController: _pagingController1,
            builderDelegate: PagedChildBuilderDelegate<DataClass>(
              itemBuilder: (context, item, index) {
                return SavedCouponActiveTileView(data:item, pos:index,pagingController1: _pagingController1,redeemOffer: (v){
                  setState(() {
                    singleOfferModel = item;
                  });

                  redeemOffersApi(item.id);
                },
                deleteOffer: (v){
                  deleteOffersApi(item.userOffers[0].id);
                  setState(() {
                    deletedItem = index;
                    _pagingController1.itemList.removeAt(deletedItem);
                  });
                },);
              },
              noItemsFoundIndicatorBuilder: (context) => Center(
                  child: NoRecordFound(
                      "No Active Coupon Found", AppImages.IC_COUPONS)),
              firstPageProgressIndicatorBuilder: (context) => Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Center(
                  child: Container(
                    height: 60.0,
                    child:
                        Loader(isLoading: true, color: AppColors.ACCENT_COLOR),
                  ),
                ),
              ),
              newPageProgressIndicatorBuilder: (context) => Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                  height: 30.0,
                  child: Loader(
                    isLoading: true,
                    color: AppColors.APP_PRIMARY_COLOR,
                  ),
                ),
              ),
            ),
          ),
        ));
  }


  bool checkExpiry(String expiry) {
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime.parse(expiry);
    if (dateTime.isAfter(now)) {
      return false;
    } else {
      return true;
    }
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

  Future<Null> _playAnimation1() async {
    try {
      await _buttonController1.forward();
    } on TickerCanceled {}
  }

  Future<Null> _stopAnimation1() async {
    try {
      await _buttonController1.reverse();
    } on TickerCanceled {}
  }

  Future<void> callSavedCouponApi(double lat,double lng) async {
    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
        });


          var map = Map<String, dynamic>();
          map['status'] = 10;
          map['offset'] = _currentPage;
          map['latitude'] = lat;
          map['longitude'] = lng;
          map['is_expired'] = 0;
          map['min_amount'] = minPrice;
          if(maxPrice!= 0.0)map['max_amount'] = maxPrice;
          map['radius'] = radius;
          print(map);
          _activeCouponViewModel.savedCoupons(map);


      } else {
        setState(() {
          _isInternetAvailable = false;
        });
      }
    });
  }

  bool getCurrentLocation() {
    LocationPermissionHandler.checkLocationPermission().then((permission) {
      if (permission == locationPermission.PermissionStatus.granted) {
        setState(() {
          _openSetting = true;
          gcl.Geolocator.getCurrentPosition(
              desiredAccuracy: gcl.LocationAccuracy.medium)
              .then((value) {
            position = value;


            callSavedCouponApi(position.latitude,position.longitude);
            return true;
          });
        });
      } else if (permission == locationPermission.PermissionStatus.unknown ||
          permission == locationPermission.PermissionStatus.denied ||
          permission == locationPermission.PermissionStatus.restricted) {
        try {
          LocationPermissionHandler.requestPermissoin().then((value) {
            if (permission == locationPermission.PermissionStatus.granted) {
              setState(() {
                _openSetting = true;
                gcl.Geolocator.getCurrentPosition(
                    desiredAccuracy: gcl.LocationAccuracy.medium)
                    .then((value) {
                  position = value;

                  callSavedCouponApi(position.latitude,position.longitude);
                  return true;
                });
              });
            } else {
              setState(() {
                _openSetting = false;
              });
            }
          });
        } on PlatformException catch (err) {
          print(err);
        } catch (err) {
          print(err);
        }
      } else {
        setState(() {
          _openSetting = false;
        });
      }
    });
  }

  Future<void> redeemOffersApi(int offerId) async {
    _playAnimation();
    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
        });

        var map = Map<String, dynamic>();
        map['offer_id'] = offerId;
        _activeCouponViewModel.redeemOffer(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
          ToastUtil.showToast(context, "No internet");
        });
      }
    });
  }

  Future<void> deleteOffersApi(int offerId) async {
    _playAnimation1();
    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
        });

        var map = Map<String, dynamic>();
        map['offer_id'] = offerId;
        _activeCouponViewModel.deleteOffer(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
          ToastUtil.showToast(context, "No internet");
        });
      }
    });
  }

  void subscribeToViewModel() {
    _activeCouponViewModel
        .getActiveCouponRepository()
        .getRepositoryResponse()
        .listen((response) async {
      _stopAnimation();
      _stopAnimation1();
      if (mounted) {
        setState(() {
          _enabled = true;
          _isPaginationLoading = false;
        });
      }

      if (response.data is RedeemOfferModel) {



        ToastUtil.showToast(context, response.msg);
        Navigator.pushNamed(
            context,
            singleOfferModel.qrUrl != null
                ? AppRoutes.QR_SCAN_VIEW
                : AppRoutes.REDEEM_MESSAGE_VIEW,
            arguments: {
              'fromSavedCoupon': true,
              'qrImage': singleOfferModel.qrUrl,
              'availTime': int.parse(singleOfferModel.availTime.toString()),
              'storeName': singleOfferModel.store.name,
              'redeemMessage': singleOfferModel.redeemMessage,
              'offer_id': response.data.offerId,
            });
      }else if (response.msg == "You have already availed this offer!") {
        ToastUtil.showToast(context, response.msg);
      }

      if (response.data is SavedCouponModel) {
        _isPaginationLoading = false;

        _totalPages = response.data.lastPage;

        print('Last Page: $_totalPages');

        final isNotLastPage = _currentPage + 1 <= _totalPages;
        print('_currentPage $_currentPage');
        print('isNotLastPage $isNotLastPage');

        if (!isNotLastPage) {
          // 3
          _pagingController1.appendLastPage(response.data.dataClass);
        } else {
          final nextPageKey = _currentPage + 1;
          _currentPage = _currentPage + 1;

          print('New Page: $_totalPages');

          _pagingController1.appendPage(response.data.dataClass, nextPageKey);

        }
      }
      else if (response.msg == "Saved offer has been removed successfully!") {

        ToastUtil.showToast(context, response.msg);
      }  else if (response.data is DioError) {
        if (response.statusCode == 401) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.WELCOME_VIEW, (Route<dynamic> route) => false);
        } else {
          _isInternetAvailable = Util.showErrorMsg(context, response.data);
        }
      } else {
        ToastUtil.showToast(context, response.msg);
      }
    });
  }
}

class SavedCouponActiveTileView extends StatefulWidget {
  final PagingController<int, DataClass> pagingController1;
  final DataClass data;
  final int pos;
  final ValueChanged<BuildContext> redeemOffer;
  final ValueChanged<BuildContext> deleteOffer;
  SavedCouponActiveTileView({Key key,this.data,this.pos,this.pagingController1,this.deleteOffer,this.redeemOffer}) : super(key: key);

  @override
  _SavedCouponActiveTileViewState createState() => _SavedCouponActiveTileViewState();
}

class _SavedCouponActiveTileViewState extends State<SavedCouponActiveTileView> with TickerProviderStateMixin{
  String _time = "2022-4-15 09:00:00";
  String _days = "00";
  String _hours = "00";
  String _newHours = "00";
  String _min = "00";
  String _secs = "00";

  int _hoursDays = 0;
  Timer _timer;
  SwipeActionController controller;
  AnimationController _buttonController;
  AnimationController _buttonController1;
  int deletedItem;

  void initState() {

    super.initState();
    var date = widget.data.userOffers[0].createdAt;
    List<String> split1String = date.split(" ");
    List<String> split2String = split1String[0].split("-");
    List<String> split3String = split1String[1].split(":");
    DateTime offerDate = DateTime.utc(int.parse(split2String[0]),int.parse(split2String[1]),int.parse(split2String[2]),int.parse(split3String[0]),int.parse(split3String[1]),int.parse(split3String[2]) );
    var local = offerDate.toLocal();
    print(local);
    var updatedDate = local.add(new Duration(hours: int.parse(widget.data.availTime.toString()),minutes: int.parse(split3String[1])));
    _time = DateFormat('yyyy-MM-dd HH:mm:ss').format(updatedDate);

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

    controller = SwipeActionController(selectedIndexPathsChangeCallback:
        (changedIndexPaths, selected, currentCount) {});


    _buttonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _buttonController1 = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);

  }


  @override
  void dispose() {
    _buttonController.dispose();
    _buttonController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
      controller: controller,
      index: widget.pos,
      key: ValueKey(widget.data),
      performsFirstActionWithFullSwipe: true,
      trailingActions: [
        SwipeAction(
            icon: Center(
              child: SvgPicture.asset(
                AppImages.IC_DELETE,
                width: 20.0,
                height: 20.0,
                color: Colors.white,
                matchTextDirection: true,
              ),
            ),
            onTap: (handler) async {
              await handler(true);

              showDialog(
                  context: context,
                  builder: (BuildContext context3) {

                    return CustomDialog(
                      showAnimatedBtn: true,
                      contex: context,
                      subTitle: "Are you sure you want to remove this offer?",
                      //title: "Your feedback will help us improve our services.",
                      child: SvgPicture.asset(
                        AppImages.DELETE_ICON,
                        width: 80.0,
                        height: 80.0,
                      ),
                      btnWidget: AnimatedGradientButton(
                        onAnimationTap:(){widget.deleteOffer(context3);Navigator.pop(context3);},
                        buttonController: _buttonController1,
                        text: AppStrings.YES,
                      ),
                      onPressed3:(){
                        Navigator.pop(context3);
                        widget.pagingController1.refresh();
                      },
                      buttonText2: AppStrings.NO,
                      onPressed2: () {
                        widget.pagingController1.refresh();
                        Navigator.pop(context3);
                      },
                      showImage: true,
                    );
                  });



            }),
      ],
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.REDEEM_NOW, arguments: {
            'offer_id': widget.data.id,
          });
        },
        child: Container(
          color: AppColors.WHITE_COLOR,
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    CircleAvatar(
                        radius: 30.0,
                        backgroundColor: AppColors.WHITE_COLOR,
                        child: widget.data.imageUrl.isNotEmpty?cacheImageVIewWithCustomSize(
                            url: widget.data.imageUrl,
                            context: context,
                            width: 60,
                            height: 60,
                            radius: 80.0):ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.asset(
                            "assets/images/user.png",
                            fit: BoxFit.fill,
                          ),
                        )

                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.data.productName,
                              style: AppStyles.blackWithBoldFontTextStyle(
                                  context, 16.0)
                                  .copyWith(color: AppColors.COLOR_BLACK)
                                  .copyWith(fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 3.0,
                          ),
                          Text(
                            TimerUtils.formatUTCTimeForSavedOffers(widget.data.expireAt),
                            style: AppStyles.blackWithDifferentFontTextStyle(
                                context, 11.0)
                                .copyWith(
                                color: AppColors
                                    .APP__DETAILS_TEXT_COLOR_LIGHT),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              int.parse(_newHours)>1?Text(
                                "Time to Avail: More than an hour",
                                style:
                                AppStyles.blackWithDifferentFontTextStyle(
                                    context, 12.0)
                                    .copyWith(
                                    color: AppColors
                                        .APP__DETAILS_TEXT_COLOR_LIGHT),
                              ):Text(
                                "Time to Avail: $_min : $_secs ",
                                style:
                                AppStyles.blackWithDifferentFontTextStyle(
                                    context, 12.0)
                                    .copyWith(
                                    color: AppColors
                                        .APP__DETAILS_TEXT_COLOR_LIGHT),
                              ),
                              FlatButtonWidget(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context3) {
                                        return CustomDialog(
                                          showAnimatedBtn: true,
                                          contex: context,
                                          subTitle: "Are you sure?",
                                          title: "Only redeem offers at checkout.",

                                          btnWidget: AnimatedGradientButton(
                                            onAnimationTap: (){widget.redeemOffer(context3);Navigator.pop(context3);},
                                            buttonController: _buttonController,
                                            text: AppStrings.YES,
                                          ),
                                          buttonText2: AppStrings.NO,
                                          onPressed2: () {
                                            Navigator.pop(context3);
                                          },
                                          onPressed3:(){
                                            Navigator.pop(context3);
                                          },
                                          showImage: false,
                                        );
                                      });
                                },
                                text: AppStrings.REDEEM_BTN,
                                color: AppColors.BLUE_COLOR,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              divider(),
            ],
          ),
        ),
      ),
    );
  }
}


