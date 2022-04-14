import 'dart:math';

import 'package:ampd/app/app.dart';
import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/data/model/SavedCouponModel.dart';
import 'package:ampd/utils/ToastUtil.dart';
import 'package:ampd/utils/Util.dart';
import 'package:ampd/utils/loader.dart';
import 'package:ampd/utils/timer_utils.dart';
import 'package:ampd/viewmodel/active_coupon_viewmodel.dart';
import 'package:ampd/viewmodel/expired_coupon_viewmodel.dart';
import 'package:ampd/widgets/NoRecordFound.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:ampd/widgets/flat_button.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart' as gcl;
import 'package:location_permissions/location_permissions.dart';
import 'package:ampd/data/model/UserLocation.dart';
import 'package:location_permissions/location_permissions.dart'
as locationPermission;
import 'package:ampd/utils/LocationPermissionHandler.dart';
import 'package:ampd/data/database/app_preferences.dart';
class ExpireCouponsView extends StatefulWidget {

  ExpireCouponsView(Key key): super(key: key);
  @override
  ExpireCouponsState createState() => ExpireCouponsState();
}

class ExpireCouponsState extends State<ExpireCouponsView> with TickerProviderStateMixin  {
  double minPrice = 0.0;
  double maxPrice = 0.0;
  int _totalPages = 0;
  int _currentPage = 1;
  int _selectedIndex = 0;
  final PagingController<int, DataClass> _pagingController1 =  PagingController(firstPageKey: 1);
  double radius = 0.0;
  List<DataClass> dataList = List<DataClass>();
  AppPreferences _appPreferences = new AppPreferences();
  bool _enabled = true;
  bool _isPaginationLoading = false;
  bool _isInternetAvailable = false;

  bool _openSetting = false;
  UserLocation userLocation = UserLocation();
  gcl.Position position;
  ExpiredCouponViewModel _expiredCouponViewModel;


  @override
  void initState()  {

    _pagingController1.addPageRequestListener((pageKey) {
      print(pageKey);
      _fetchPage(pageKey);
    });

    _expiredCouponViewModel = ExpiredCouponViewModel(App());
    subscribeToViewModel();
    super.initState();

    _appPreferences.getUserDetails().then((userData) {
      setState(() {

        print("radius: ${userData.data.radius.toDouble()}");
        radius = userData.data.radius.toDouble();
      });
    });

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

                return SavedCouponExpiredTileView(item);
              },
              noItemsFoundIndicatorBuilder: (context) => Center(
                  child: NoRecordFound(
                      "No Expired Coupon Found", AppImages.IC_COUPONS)),
              firstPageProgressIndicatorBuilder: (context) => Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Center(
                  child: Container(
                    height: 60.0,
                    child: Loader(
                        isLoading: true,
                        color: AppColors.ACCENT_COLOR
                    ),
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


  bool checkExpiry(String expiry){
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime.parse(expiry);
    if(dateTime.isAfter(now)){
      return false;
    }else{
      return true;
    }
  }


  Widget SavedCouponExpiredTileView(DataClass data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,

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
                child: data.imageUrl.isNotEmpty?cacheImageVIewWithCustomSize(
                    url: data.imageUrl,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.productName,
                        style:
                        AppStyles.blackWithBoldFontTextStyle(context, 16.0)
                            .copyWith(color: AppColors.COLOR_BLACK)
                            .copyWith(fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 2.0,
                    ),

                    Text(
                      TimerUtils.formatUTCTimeForSavedOffers(data.expireAt),
                      style: AppStyles.blackWithDifferentFontTextStyle(
                          context, 11.0)
                          .copyWith(
                          color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                    ),

                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButtonWidget(
                  onTap: () {}, text: AppStrings.EXPIRED,color: AppColors.RED_COLOR2,),
              ),
            ],
          ),

        ),

        divider(),
      ],
    );
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
        map['is_expired'] = 1;
        map['min_amount'] = minPrice;
        if(maxPrice!= 0.0)map['max_amount'] = maxPrice;
        map['radius'] = radius;
        print(map);
        _expiredCouponViewModel.savedCoupons(map);


      } else {
        setState(() {
          _isInternetAvailable = false;
        });
      }
    });
  }
  void subscribeToViewModel() {
    _expiredCouponViewModel
        .getSavedCouponRepository()
        .getRepositoryResponse()
        .listen((response) async {

      if(mounted) {
        setState(() {
          _enabled = true;
          _isPaginationLoading = false;
        });
      }
      if(_pagingController1.itemList != null){
        _pagingController1.itemList.clear();
      }
      if(response.data is SavedCouponModel) {
        _isPaginationLoading = false;

        _totalPages = response.data.lastPage;
        // SavedCouponModel responseRegister = responseRegister;
        dataList.clear();
        dataList.addAll(response.data.dataClass);

        final isNotLastPage = _currentPage + 1 <= _totalPages;
        print('_currentPage $_currentPage');
        print('isNotLastPage $isNotLastPage');

        if (!isNotLastPage) {
          // 3
          _pagingController1.appendLastPage(dataList);

        } else {
          final nextPageKey = _currentPage + 1;
          _currentPage = _currentPage + 1;

            _pagingController1.appendPage(dataList, nextPageKey);
        }
      }
      else if(response.data is DioError){
        if (response.statusCode == 401) {
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.WELCOME_VIEW, (Route<dynamic> route) => false);
        }else{
          _isInternetAvailable = Util.showErrorMsg(context, response.data);
        }
      }
      else {
        ToastUtil.showToast(context, response.msg);
      }
    });



  }

}


