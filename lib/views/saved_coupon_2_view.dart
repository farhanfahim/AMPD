import 'dart:async';
import 'dart:math';

import 'package:ampd/app/app.dart';
import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/data/model/SavedCouponModel.dart';
import 'package:ampd/data/model/UserLocation.dart';
import 'package:ampd/utils/LocationPermissionHandler.dart';
import 'package:ampd/utils/ToastUtil.dart';
import 'package:ampd/utils/Util.dart';
import 'package:ampd/utils/loader.dart';
import 'package:ampd/viewmodel/saved_coupon2_viewmodel.dart';
import 'package:ampd/viewmodel/active_coupon_viewmodel.dart';
import 'package:ampd/views/setting_view.dart';
import 'package:ampd/widgets/NoRecordFound.dart';
import 'package:ampd/widgets/flat_button.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart' as gcl;
import 'package:location_permissions/location_permissions.dart' as locationPermission;

class SavedCoupons2View extends StatefulWidget {

  final Map<String, dynamic> map;
  SavedCoupons2View(this.map);

  @override
  _SavedCoupons2ViewState createState() => _SavedCoupons2ViewState();
}

class _SavedCoupons2ViewState extends State<SavedCoupons2View> {

  gcl.Position position;
  int pagekey = 0;
  int _totalPages = 0;
  int resultCount = 0;
  int _currentPage = 1;
  int _selectedIndex = 0;
  final PagingController<int, DataClass> _pagingController1 =  PagingController(firstPageKey: 1);

  List<DataClass> dataList = List<DataClass>();

  bool _openSetting = false;
  UserLocation userLocation = UserLocation();
  bool isSearching = false;
  bool _enabled = true;
  bool _isPaginationLoading = false;
  bool _isInternetAvailable = false;

  SavedCoupon2ViewModel _savedCoupon2ViewModel;

  TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search_rounded, color: AppColors.APP__DETAILS_TEXT_COLOR,);
  Widget _appBarTitle = new Text( '' );


  _SavedCoupons2ViewState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
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

            userLocation.latitude = position.latitude;
            userLocation.longitude = position.longitude;

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

                  UserLocation(
                      latitude: position.latitude,
                      longitude: position.longitude);
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
  @override
  void initState()  {

    getCurrentLocation();
    this._searchIcon = new Icon(Icons.close,color: AppColors.APP__DETAILS_TEXT_COLOR,);
    this._appBarTitle = new TextFormField(
      autofocus: true,

      onFieldSubmitted: (value){
        setState(() {
          _filter.text = value;
          isSearching = true;
        });
        _fetchPage(pagekey,value);
      },
      cursorColor: AppColors.APP__DETAILS_TEXT_COLOR,
      keyboardType: TextInputType.text,
      decoration: new InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: "Search..."),
    );


    if(_filter.text.isNotEmpty) {
      _pagingController1.addPageRequestListener((pageKey) {
        print(pageKey);
        pagekey = pageKey;
      });
    }
    _savedCoupon2ViewModel = SavedCoupon2ViewModel(App());
    subscribeToViewModel();
    super.initState();
  }
  Future<void> _fetchPage(int pageKey,String query) async {
    try {

      widget.map['isFromFilterScreen']?callFilterSavedCouponApi(query):callSavedCouponApi(query);
    } catch (error) {
      _pagingController1.error = error;
    }
  }
  @override
  void dispose() {

    _pagingController1.dispose();
    super.dispose();
  }


  static String formatUTCTime(String time) {
    DateTime tempDate = new DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").parse(
        time);
    return DateFormat("MMM dd, yyyy - HH:mm").format(tempDate);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: searchAppBar(context),
        backgroundColor: AppColors.WHITE_COLOR,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 15.0,
                ),
                Header(
                    heading1: AppStrings.SAVED_COUPONS,
                    heading2: AppStrings.SAVED_COUPONS_RESULT +": (0)"),
                SizedBox(
                  height: 30.0,
                ),
                isSearching?Container(
                  child: Expanded(
                    child: PagedListView<int, DataClass>(
                      pagingController: _pagingController1,
                      builderDelegate: PagedChildBuilderDelegate<DataClass>(
                        itemBuilder: (context, item, index) {

                          print('Item index: $index');

                          return SavedCouponTileView(item);
                        },
                        noItemsFoundIndicatorBuilder: (context) => Center(
                            child: NoRecordFound(
                                "No Result Found", AppImages.NO_TEETIMES_IMAGE)),
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
                  ),
                ):NoRecordFound(
                    "No Result Found", AppImages.NO_TEETIMES_IMAGE),
              ],
            ),
          ),
        ));
  }

  Widget SavedCouponTileView(DataClass data) {
    return Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        InkWell(
          onTap: (){

          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                Container(
                  width: 70.0,
                  height: 70.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: Image.network(
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
                          style:
                              AppStyles.blackWithBoldFontTextStyle(context, 16.0)
                                  .copyWith(color: AppColors.COLOR_BLACK)
                                  .copyWith(fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text(
                        formatUTCTime(data.expireAt),
                        style: AppStyles.blackWithDifferentFontTextStyle(
                                context, 11.0)
                            .copyWith(
                                color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Time to Avail:(${data.availTime } hour)",
                            style: AppStyles.blackWithDifferentFontTextStyle(
                                    context, 12.0)
                                .copyWith(
                                    color:
                                        AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                          ),
                          FlatButtonWidget(
                              onTap: () {}, text: AppStrings.REDEEM_BTN,color: AppColors.BLUE_COLOR,),
                        ],
                      ),


                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        divider(),
      ],
    );
  }

  Widget searchAppBar(BuildContext context) {
    return new AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: _appBarTitle,
      actions: <Widget>[
        IconButton(
          icon: _searchIcon,
          onPressed: _searchPressed,

        ),

        Container(
          margin: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            child: SvgPicture.asset(
              AppImages.FILTER,
            ),
            onTap: (){
              Navigator.pushNamed(context, AppRoutes.FILTER_VIEW);
            },
          ),
        ),
      ],
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close,color: AppColors.APP__DETAILS_TEXT_COLOR,);
        this._appBarTitle = new TextFormField(
          autofocus: true,
          onFieldSubmitted: (value){
            setState(() {
              _filter.text = value;
              isSearching = true;
            });
            _fetchPage(pagekey,value);
          },
          cursorColor: AppColors.APP__DETAILS_TEXT_COLOR,
          keyboardType: TextInputType.text,
          decoration: new InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: "Search..."),
        );

      } else {
        this._searchIcon = new Icon(Icons.search ,color: AppColors.APP__DETAILS_TEXT_COLOR,);
        this._appBarTitle = new Text(
          '',
          style: AppStyles.blackWithDifferentFontTextStyle(
              context, 15.0)
              .copyWith(
              color: AppColors.APP__DETAILS_TEXT_COLOR),
        );
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  Future<void> callSavedCouponApi(String query) async {

    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
        });

        var map = Map<String, dynamic>();
        map['status'] = 10;
        map['query'] = query;
        map['latitude'] = userLocation.latitude;
        map['longitude'] = userLocation.longitude;
        map['offset'] = _currentPage;
        _savedCoupon2ViewModel.savedCoupons(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
        });
      }
    });
  }
  Future<void> callFilterSavedCouponApi(String query) async {

    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
        });

        var map = Map<String, dynamic>();
        map['status'] = 10;
        map['query'] = query;
        map['latitude'] = userLocation.latitude;
        map['longitude'] = userLocation.longitude;
        map['offset'] = _currentPage;
        map['min_amount'] = widget.map['minPrice'];
        map['max_amount'] = widget.map['maxPrice'];
        map['start_at'] = widget.map['startDate'];
        map['end_at'] = widget.map['endDate'];
        map['radius'] = widget.map['maxRadius'];
        _savedCoupon2ViewModel.savedCoupons(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
        });
      }
    });
  }

  void subscribeToViewModel() {
    _savedCoupon2ViewModel
        .getSavedCoupon2Repository()
        .getRepositoryResponse()
        .listen((response) async {

      if(mounted) {
        setState(() {
          _enabled = true;
          _isPaginationLoading = false;
        });
      }

      if(response.data is SavedCouponModel) {
        _isPaginationLoading = false;

        _pagingController1.itemList = [];

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
      else if(response.data is DioError){
        _isInternetAvailable = Util.showErrorMsg(context, response.data);
      }
      else {
        ToastUtil.showToast(context, response.msg);
      }
    });



  }

}
