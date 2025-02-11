import 'dart:async';
import 'dart:math';

import 'package:ampd/app/app.dart';
import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/data/model/RedeemOfferModel.dart';
import 'package:ampd/data/model/SavedCouponModel.dart';
import 'package:ampd/data/model/UserLocation.dart';
import 'package:ampd/utils/LocationPermissionHandler.dart';
import 'package:ampd/utils/ToastUtil.dart';
import 'package:ampd/utils/Util.dart';
import 'package:ampd/utils/loader.dart';
import 'package:ampd/utils/timer_utils.dart';
import 'package:ampd/data/database/app_preferences.dart';
import 'package:ampd/viewmodel/saved_coupon2_viewmodel.dart';
import 'package:ampd/viewmodel/active_coupon_viewmodel.dart';
import 'package:ampd/views/setting_view.dart';
import 'package:ampd/widgets/NoRecordFound.dart';
import 'package:ampd/widgets/animated_gradient_button.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:ampd/widgets/flat_button.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:ampd/widgets/dialog_view.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart' as gcl;
import 'package:location_permissions/location_permissions.dart'
    as locationPermission;

class SavedCoupons2View extends StatefulWidget {
  final Map<String, dynamic> map;

  SavedCoupons2View(this.map);

  @override
  _SavedCoupons2ViewState createState() => _SavedCoupons2ViewState();
}

class _SavedCoupons2ViewState extends State<SavedCoupons2View>
    with TickerProviderStateMixin {
  BuildContext dialogContext;
  AnimationController _buttonController;
  DataClass singleOfferModel;
  gcl.Position position;
  int pagekey = 0;
  int _totalPages = 0;
  int resultCount = 0;
  int _currentPage = 1;
  int _selectedIndex = 0;
  final PagingController<int, DataClass> _pagingController1 =
      PagingController(firstPageKey: 1);

  BuildContext ctx2;
  List<DataClass> dataList = List<DataClass>();

  bool _openSetting = false;
  UserLocation userLocation = UserLocation();
  bool isSearching = false;
  bool _enabled = false;
  bool _isPaginationLoading = false;
  bool _isInternetAvailable = false;

  SavedCoupon2ViewModel _savedCoupon2ViewModel;

  TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(
    Icons.search_rounded,
    color: AppColors.APP__DETAILS_TEXT_COLOR,
  );
  Widget _appBarTitle = new Text('');

  AppPreferences _appPreferences = new AppPreferences();
  _SavedCoupons2ViewState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          dataList.clear();
          _pagingController1.refresh();
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

  bool getCurrentLocation(String query) {
    LocationPermissionHandler.checkLocationPermission().then((permission) {
      if (permission == locationPermission.PermissionStatus.granted) {
        setState(() {
          _openSetting = true;
          gcl.Geolocator.getCurrentPosition(
                  desiredAccuracy: gcl.LocationAccuracy.medium)
              .then((value) {
            position = value;
            widget.map['isFromFilterScreen']
                ? callFilterSavedCouponApi(query,position.latitude,position.longitude)
                : callSavedCouponApi(query,position.latitude,position.longitude);

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
  void initState() {
    _buttonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);

    this._searchIcon = new Icon(
      Icons.close,
      color: AppColors.APP__DETAILS_TEXT_COLOR,
    );
    this._appBarTitle = new TextFormField(
      autofocus: true,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
      ],
      onFieldSubmitted: (value) {
        setState(() {
          _filter.text = value;
          isSearching = true;
        });
        _fetchPage(pagekey, value);
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

    if (_filter.text.isNotEmpty) {
      _pagingController1.addPageRequestListener((pageKey) {
        print(pageKey);
        pagekey = pageKey;
      });
    }
    _savedCoupon2ViewModel = SavedCoupon2ViewModel(App());
    subscribeToViewModel();
    super.initState();
  }

  Future<void> _fetchPage(int pageKey, String query) async {
    try {
      getCurrentLocation(query);


    } catch (error) {
      _pagingController1.error = error;
    }
  }

  @override
  void dispose() {
    _buttonController.dispose();
    _pagingController1.dispose();
    super.dispose();
  }

  Future<bool> _onBackPressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop:_onBackPressed,
      child: Scaffold(
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
                      heading2: AppStrings.SAVED_COUPONS_RESULT +
                          ": (${dataList != null ? dataList.length : 0})"),
                  SizedBox(
                    height: 30.0,
                  ),
                  isSearching
                      ? Container(
                          child: Expanded(
                            child: PagedListView<int, DataClass>(
                              pagingController: _pagingController1,
                              builderDelegate:
                                  PagedChildBuilderDelegate<DataClass>(
                                    itemBuilder: (context, item, index) {
                                      return SavedCouponActiveTileView(data:item, pos:index,pagingController1: _pagingController1,redeemOffer: (v){
                                        setState(() {
                                          ctx2 = v;
                                        });
                                        setState(() {
                                          singleOfferModel = item;
                                        });

                                        redeemOffersApi(item.id);
                                      },buttonController1: _buttonController);

                                    },
                                noItemsFoundIndicatorBuilder: (context) => Center(
                                    child: NoRecordFound(
                                        "No Result Found", AppImages.IC_COUPONS)),
                                firstPageProgressIndicatorBuilder: (context) =>
                                    Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  child: Center(
                                    child: Container(
                                      height: 60.0,
                                      child: Loader(
                                          isLoading: true,
                                          color: AppColors.ACCENT_COLOR),
                                    ),
                                  ),
                                ),
                                newPageProgressIndicatorBuilder: (context) =>
                                    Padding(
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
                        )
                      : Container( height:
                  MediaQuery.of(context).size.height * 0.4,child: Center(child: NoRecordFound("Search Coupons", AppImages.IC_COUPONS))),
                ],
              ),
            ),
          )),
    );
  }

  Widget SavedCouponTileView(DataClass data) {
    return Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.REDEEM_NOW, arguments: {
              'offer_id': data.id,
            });
          },
          child: Container(
            color: AppColors.WHITE_COLOR,
            child: Padding(
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
                          TimerUtils.formatUTCTimeForSavedOffers(data.expireAt),
                          style: AppStyles.blackWithDifferentFontTextStyle(
                                  context, 11.0)
                              .copyWith(
                                  color:
                                      AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Time to Avail:(${data.availTime} hour)",
                              style: AppStyles.blackWithDifferentFontTextStyle(
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
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Transform.rotate(
          angle: 180 * pi / 180,
          child: Icon(
            Icons.arrow_right_alt,
            size: 32.0,
            // add custom icons also
          ),
        ),
      ),
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
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, AppRoutes.FILTER_VIEW,arguments: {
                'isFromSearch': true,
              });
            },
          ),
        ),
      ],
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(
          Icons.close,
          color: AppColors.APP__DETAILS_TEXT_COLOR,
        );
        this._appBarTitle = new TextFormField(
          autofocus: true,
          onFieldSubmitted: (value) {
            setState(() {
              _filter.text = value;
              isSearching = true;
            });
            _fetchPage(pagekey, value);
          },
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
          ],
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
        this._searchIcon = new Icon(
          Icons.search,
          color: AppColors.APP__DETAILS_TEXT_COLOR,
        );
        this._appBarTitle = new Text(
          '',
          style: AppStyles.blackWithDifferentFontTextStyle(context, 15.0)
              .copyWith(color: AppColors.APP__DETAILS_TEXT_COLOR),
        );
        filteredNames = names;
        _filter.clear();
        isSearching = false;
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
        _savedCoupon2ViewModel.redeemOffer(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
          ToastUtil.showToast(context, "No internet");
        });
      }
    });
  }

  Future<void> callSavedCouponApi(String query,double lat,double lng) async {
    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
        });

        var map = Map<String, dynamic>();
        map['status'] = 10;
        map['query'] = query;
        map['latitude'] = lat;
        map['longitude'] = lng;
        map['offset'] = _currentPage;
        _savedCoupon2ViewModel.savedCoupons(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
        });
      }
    });
  }

  Future<void> callFilterSavedCouponApi(String query,double lat,double lng) async {
    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
        });

        var map = Map<String, dynamic>();

        map['status'] = 10;
        map['query'] = query;
        map['latitude'] = lat;
        map['longitude'] = lng;
        map['offset'] = _currentPage;
        map['min_amount'] = widget.map['minPrice'];
        map['max_amount'] = widget.map['maxPrice'];
        map['radius'] = widget.map['minRadius'];
        print(map);
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
      _stopAnimation();
      if (mounted) {
        setState(() {
          _enabled = true;
          _isPaginationLoading = false;
        });
      }
      if (response.data is RedeemOfferModel) {

        RedeemOfferModel model = response.data;
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
              'availTime':int.parse(singleOfferModel.availTime.toString()),
              'storeName': singleOfferModel.store.name,
              'redeemMessage': singleOfferModel.redeemMessage,
              'offer_id': response.data.offerId,
              'created_at': model.createdAt,
            });
      }
      else if (response.msg == "You have already availed this offer!") {
        Navigator.pop(ctx2);
        ToastUtil.showToast(context, response.msg);
        Navigator.pop(dialogContext);
      } else if(response.data is SavedCouponModel) {
        _isPaginationLoading = false;

        _totalPages = response.data.lastPage;
        // SavedCouponModel responseRegister = responseRegister;
        setState(() {
          dataList.clear();
          dataList.addAll(response.data.dataClass);
          _pagingController1.refresh();
        });


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
      } else if (response.data is DioError) {
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


class SavedCouponActiveTileView extends StatefulWidget {
  final PagingController<int, DataClass> pagingController1;
  final DataClass data;
  final int pos;
  final ValueChanged<BuildContext> redeemOffer;
  final AnimationController buttonController1;
  SavedCouponActiveTileView({Key key,this.data,this.pos,this.pagingController1,this.redeemOffer,this.buttonController1}) : super(key: key);

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
  AnimationController _buttonController;
  AnimationController _buttonController1;
  int deletedItem;

  void initState() {

    super.initState();
    var date1 = widget.data.userOffers[0].createdAt;
    List<String> split1String = date1.split(" ");
    List<String> split2String = split1String[0].split("-");
    List<String> split3String = split1String[1].split(":");
    DateTime offerDate = DateTime.utc(int.parse(split2String[0]),int.parse(split2String[1]),int.parse(split2String[2]),int.parse(split3String[0]),int.parse(split3String[1]),int.parse(split3String[2]) );
    var local = offerDate.toLocal();

    var updatedDate = local.add(new Duration(hours: int.parse(widget.data.availTime.toString())));
    _time = DateFormat('yyyy-MM-dd HH:mm:ss').format(updatedDate);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _days = TimerUtils.getDays(_time, 'days');
          _hours = TimerUtils.getDays(_time, 'hours');
          _min = TimerUtils.getDays(_time, 'min');
          _secs = TimerUtils.getDays(_time, 'sec');
          int dayHour = int.parse(_days)*24;
          _hoursDays = (int.parse(_hours) + dayHour);

          if(_days == "00" && _newHours == "0" && _min == "00" && _secs == "00"){
            print(_days);
            print(_hoursDays);
            print(_min);
            print(_secs);
            _timer.cancel();
            setState(() {
              _days = "00";
              _hours = "00";
              _min = "00";
              _secs = "00";
            });
          }

        });
      }

    });
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

    return Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.REDEEM_NOW, arguments: {
              'offer_id': widget.data.id,
            });
          },
          child: Container(
            color: AppColors.WHITE_COLOR,
            child: Padding(
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
                              color:
                              AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _hoursDays>=1?Expanded(
                              child: Container(
                                padding: EdgeInsets.only(right: 5),
                                child: Text(
                                  "Time to Avail: More than an hour",
                                  style:
                                  AppStyles.blackWithDifferentFontTextStyle(
                                      context, 12.0)
                                      .copyWith(
                                      color: AppColors
                                          .APP__DETAILS_TEXT_COLOR_LIGHT),
                                ),
                              ),
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
                                        contex: context3,
                                        subTitle: "Are you sure?",
                                        title: "Only redeem offers at checkout.",

                                        btnWidget: AnimatedGradientButton(
                                          onAnimationTap: (){
                                            widget.redeemOffer(context3);},
                                          buttonController: widget.buttonController1,
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
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        divider(),
      ],
    );
  }
}

