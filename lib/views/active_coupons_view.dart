import 'dart:math';

import 'package:ampd/app/app.dart';
import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';

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

class ActiveCouponsView extends StatefulWidget {
  @override
  _ActiveCouponsState createState() => _ActiveCouponsState();
}

class _ActiveCouponsState extends State<ActiveCouponsView>
    with TickerProviderStateMixin {

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

  @override
  void initState() {

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
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      callSavedCouponApi();

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
          child: PagedListView<int, DataClass>(
            pagingController: _pagingController1,
            builderDelegate: PagedChildBuilderDelegate<DataClass>(
              itemBuilder: (context, item, index) {
                return checkExpiry(item.expireAt)
                    ? Container()
                    : SavedCouponActiveTileView(item, index);
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

  Widget SavedCouponActiveTileView(DataClass data, int pos) {
    return SwipeActionCell(
      controller: controller,
      index: pos,
      key: ValueKey(data),
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
                    dialogContext1 = context3;
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
                        onAnimationTap: () {

                          setState(() {
                            deletedItem = pos;
                            _pagingController1.itemList.removeAt(deletedItem);
                          });
                          Navigator.pop(dialogContext1);
                          ToastUtil.showToast(context, "Saved offer has been removed successfully!");

                        },
                        buttonController: _buttonController1,
                        text: AppStrings.YES,
                      ),
                      onPressed3:(){
                        Navigator.pop(context3);
                        _pagingController1.refresh();
                      },
                      buttonText2: AppStrings.NO,
                      onPressed2: () {
                        _pagingController1.refresh();
                        Navigator.pop(context3);
                      },
                      showImage: true,
                    );
                  });
             /* showDialog(
                  context: context,
                  builder: (BuildContext context1) {
                    return CustomDialog(
                      showAnimatedBtn: false,
                      contex: dialogContext1,
                      subTitle: "Are you sure you want to remove this offer?",
                      child: SvgPicture.asset(
                        AppImages.DELETE_ICON,
                        width: 80.0,
                        height: 80.0,
                      ),
                      //title: "Your feedback will help us improve our services.",
                      buttonText1: AppStrings.YES,
                      buttonText2: AppStrings.NO,
                      onPressed1: () {
                        deleteOffersApi(data.userOffers[0].id);
                        setState(() {
                          deletedItem = pos;
                        });
                        Navigator.pop(context1);

                      },
                      onPressed3:(){

                        _pagingController1.refresh();

                        Navigator.pop(context1);

                      },
                      onPressed2: () {

                        _pagingController1.refresh();
                        Navigator.pop(context1);

                      },
                      showImage: true,
                    );
                  });*/


            }),
      ],
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.REDEEM_NOW, arguments: {
            'offer_id': data.id,
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
                    Container(
                      width: 70.0,
                      height: 70.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: Image.asset(
                          data.imageUrl,
                          fit: BoxFit.cover,
                        ),

                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.productName,
                              style: AppStyles.blackWithBoldFontTextStyle(
                                      context, 16.0)
                                  .copyWith(color: AppColors.COLOR_BLACK)
                                  .copyWith(fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 3.0,
                          ),
                          Text(
                            TimerUtils.formatUTCTime(data.expireAt),
                            style: AppStyles.blackWithDifferentFontTextStyle(
                                    context, 11.0)
                                .copyWith(
                                    color: AppColors
                                        .APP__DETAILS_TEXT_COLOR_LIGHT),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Time to Avail:(${data.availTime} hour)",
                                style:
                                    AppStyles.blackWithDifferentFontTextStyle(
                                            context, 12.0)
                                        .copyWith(
                                            color: AppColors
                                                .APP__DETAILS_TEXT_COLOR_LIGHT),
                              ),
                              FlatButtonWidget(
                                onTap: () {
                                  setState(() {
                                    singleOfferModel = data;
                                  });
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context3) {
                                        dialogContext = context3;
                                        return CustomDialog(
                                          showAnimatedBtn: true,
                                          contex: context,
                                          subTitle: "Are you sure?",
                                          title: "Only redeem offers at checkout.",

                                          btnWidget: AnimatedGradientButton(
                                            onAnimationTap: () {
                                              redeemOffersApi(data.id);

                                            },
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

  Future<void> callSavedCouponApi() async {
    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
        });

        var map = Map<String, dynamic>();
        map['status'] = 10;
        map['offset'] = _currentPage;
        _activeCouponViewModel.savedCoupons(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
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
        Navigator.pop(dialogContext);
        Navigator.pushNamed(
            context,
            singleOfferModel.qrUrl != null
                ? AppRoutes.QR_SCAN_VIEW
                : AppRoutes.REDEEM_MESSAGE_VIEW,
            arguments: {
              'fromSavedCoupon': true,
              'qrImage': singleOfferModel.qrUrl,
              'redeemMessage': singleOfferModel.redeemMessage,
              'offer_id': response.data.offerId,
            });
      }else if (response.msg == "You have already availed this offer!") {
        ToastUtil.showToast(context, response.msg);
        Navigator.pop(dialogContext);
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
        setState(() {
          _pagingController1.itemList.removeAt(deletedItem);
        });
        Navigator.pop(dialogContext1);
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

