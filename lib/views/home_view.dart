import 'dart:async';
import 'dart:io';

import 'package:ampd/app/app.dart';
import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/data/model/LikeDislikeModel.dart';
import 'package:ampd/data/model/OfferDataClassModel.dart';
import 'package:ampd/data/model/OfferModel.dart';
import 'package:ampd/data/model/RedeemOfferModel.dart';
import 'package:ampd/data/model/UserLocation.dart';
import 'package:ampd/utils/ToastUtil.dart';
import 'package:ampd/utils/Util.dart';
import 'package:ampd/utils/timer_utils.dart';
import 'package:ampd/viewmodel/home_viewmodel.dart';
import 'package:ampd/widgets/NoInternetFound.dart';
import 'package:ampd/widgets/animated_gradient_button.dart';
import 'package:ampd/widgets/dialog_view.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:ampd/widgets/offer_card_widget.dart';
import 'package:ampd/widgets/offer_card_widget_2.dart';
import 'package:ampd/widgets/swipe_cards/swipe_cards.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:app_settings/app_settings.dart';
import 'package:dio/dio.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:sizer/sizer.dart';
import 'package:ampd/utils/LocationPermissionHandler.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart' as gcl;

import 'package:ampd/utils/loader.dart';
import 'package:location_permissions/location_permissions.dart'
    as locationPermission;

class HomeView extends StatefulWidget {
  bool isGuestLogin;

  HomeView(this.isGuestLogin);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin<HomeView>, TickerProviderStateMixin,  WidgetsBindingObserver {
  gcl.Position position;
  int _totalPages = 0;
  int _currentPage = 1;
  int _selectedIndex = -1;
  String qrUrl = "";

  ScrollController _controller;
  StreamController _streamController;
  AnimationController _buttonController;
  UserLocation userLocation = UserLocation();
  HomeViewModel _homeViewModel;

  bool _enabled = true;
  bool _isInAsyncCall = true;
  bool _initialCall = false;
  bool _openSetting = true;
  bool _isRefreshing = false;
  bool permissionGranted = false;
  bool _isInternetAvailable = true;
  final PagingController<int, OfferModel> _pagingController =
      PagingController(firstPageKey: 1);

  String _appBarTitle = 'Home';
  bool _stackFinished = false;
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  List<Dataclass> dataList = <Dataclass>[];
  MatchEngine _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  List<String> _times = [
    "2021-07-03 09:00:00",
    "2021-07-05 09:00:00",
    "2021-07-10 09:00:00",
    "2021-06-29 09:00:00",
    "2021-07-29 09:00:00",
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      LocationPermissionHandler.checkLocationPermission().then((permission) {
        if (permission == locationPermission.PermissionStatus.granted) {
          _openSetting = true;
          gcl.Geolocator.getCurrentPosition(
              desiredAccuracy: gcl.LocationAccuracy.medium)
              .then((value) {
            position = value;

            userLocation.latitude = position.latitude;
            userLocation.longitude = position.longitude;
            widget.isGuestLogin?callOffersApiWithoutToken():callOffersApi();
          });
        }
      });

    });
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _buttonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    getCurrentLocation();
    _homeViewModel = HomeViewModel(App());
    subscribeToViewModel();
  }

  bool getCurrentLocation() {
    LocationPermissionHandler.checkLocationPermission().then((permission) {
      if (permission == locationPermission.PermissionStatus.granted) {
        Util.check().then((value) {
          print('value $value');
          if (value != null && value) {
            setState(() {
              _openSetting = true;
              gcl.Geolocator.getCurrentPosition(
                  desiredAccuracy: gcl.LocationAccuracy.medium)
                  .then((value) {
                position = value;

                UserLocation(
                    latitude: position.latitude, longitude: position.longitude);
                callOffersApi();
                permissionGranted = true;
                return permissionGranted;
              });
            });
          } else {
            setState(() {
              _isInternetAvailable = false;
              ToastUtil.showToast(context, "No internet");
            });
          }
            userLocation.latitude = position.latitude;
            userLocation.longitude = position.longitude;
            widget.isGuestLogin?callOffersApiWithoutToken():callOffersApi();

            permissionGranted = true;
            return permissionGranted;
          });

      }else if (permission == locationPermission.PermissionStatus.unknown ||
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
                  widget.isGuestLogin?callOffersApiWithoutToken():callOffersApi();
                  permissionGranted = true;
                  return permissionGranted;
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
  void dispose() {
    _pagingController.dispose();
    _buttonController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBar1 = appBar(
        title: _appBarTitle,
        onBackClick: () {
          Navigator.of(context).pop();
        },
        iconColor: AppColors.WHITE_COLOR,
        hasLeading: false);

    final body = SafeArea(

       child: RefreshIndicator(
            onRefresh: () async {
              _isRefreshing = false;
              getCurrentLocation();
            },
        child:
        _isRefreshing ?
        _openSetting ?
        !_stackFinished ?
           Container(
//          height: 550,
//        color: Colors.yellow,
          height: double.maxFinite,
          width: double.infinity,

              child: !_isInAsyncCall || _initialCall ?
              _swipeItems.length > 0
                  ?
              SwipeCards(
                      matchEngine: _matchEngine,
                      itemBuilder: (BuildContext context, int index) {
                        if(index == _swipeItems.length - 1 && _currentPage < _totalPages) {
                          _currentPage++;

                          callOffersApi();
                        }
                        return Container(
//                height: 550.0,
//                height: double.maxFinite,
                          child: OfferCardWidget2(
                            isRedeemNow: false,
                            image: _swipeItems[index].content.image,
                            offer: _swipeItems[index].content.offer,
                            offerName: _swipeItems[index].content.offerName,
                            text: _swipeItems[index].content.text,
                            time: _swipeItems[index].content.time,
                            coord: _swipeItems[index].content.coord,
                            currentCoords: UserLocation(
                                latitude: position.latitude,
                                longitude: position.longitude),
                            locationTitle:
                                _swipeItems[index].content.locationTitle,
                            data: _swipeItems[index].content.data,
                            changeDetailTitle: (value) {
                              setState(() {
                                if (value) {
                                  _appBarTitle = 'Offer Details';
                                } else {
                                  _appBarTitle = 'Home';
                                }
                              });
                            },
                          ),
                        );
                      },
                      onStackFinished: () {
                        print('stack finished');
                        if(_currentPage < _totalPages) {
//                          _currentPage++;
//
//                          callOffersApi();
                        } else {
                          setState(() {
                            _stackFinished = true;
                            _appBarTitle = 'Home';
                          });
                        }
                      },
                    )
                  : Center(
                    child: Text(
                'No coupons available right  now',
                style: AppStyles.poppinsTextStyle(
                      fontSize: 18.0, weight: FontWeight.w500)
                      .copyWith(color: AppColors.UNSELECTED_COLOR),
                ),
                  )
                  : Padding(
                padding: EdgeInsets.all(5),
                child: Loader(
                   isLoading: _isInAsyncCall || _initialCall,
//                   isLoading: _swipeItems.length > 0 ? false:true,
                  color: AppColors.APP_PRIMARY_COLOR,
                ),
              ),
            )
           : Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Opacity(
                  opacity: 0.3,
                  child: SvgPicture.asset(
                    AppImages.IC_COUPONS,
                    width: 110.0,
                    height: 110.0,
                  )),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'No more coupons left',
                style: AppStyles.poppinsTextStyle(
                    fontSize: 18.0, weight: FontWeight.w500)
                    .copyWith(color: AppColors.UNSELECTED_COLOR),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25.0.w),
                child: GradientButton(
                  onTap: () {
                    _swipeItems.clear();
                    _currentPage = 1;
                   callOffersApi();
                   setState(() {
                     _isInAsyncCall = true;
                     _stackFinished = false;
                   });

                   _matchEngine = MatchEngine(swipeItems: _swipeItems);
////                      print('length ${_matchEngine.currentItem}');
//                    _matchEngine.rewindMatch();

                  },
                  text: "Fetch More",
                ),
              )
            ],
          ),
        ),
      )
            : Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Location permission is required to access nearby offers.',
                  style: AppStyles.poppinsTextStyle(
                      fontSize: 12.0, weight: FontWeight.w500)
                      .copyWith(color: AppColors.UNSELECTED_COLOR),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                  child: GradientButton(
                    onTap: () {
                      AppSettings.openAppSettings();
                    },
                    text: "Please enable location",
                  ),
                )
              ],
            ),
          ),
        )
             :Loader(
       isLoading: true,
         color: AppColors.APP_PRIMARY_COLOR,
       ),
       ),
    );

    return  Scaffold(
          appBar: appBar1,
          body: _isInternetAvailable
              ? body
              : NoInternetFound(context, (context) {
            setState(() {
              _isInternetAvailable = true;
            });

            if (position != null) {
              callOffersApi();
            } else {
              getCurrentLocation();
            }
          })
  );
  }



  Future<void> callOffersApi() async {
    Util.check().then((value) {
      print('value $value');
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
//          _isInAsyncCall = true;
        });

        var map = Map<String, dynamic>();
        map['status'] = 20;
        map['latitude'] = userLocation.latitude;
        map['longitude'] = userLocation.longitude;
        map['offset'] = _currentPage;
        _homeViewModel.offer(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
          ToastUtil.showToast(context, "No internet");
        });
      }
    });
  }

  Future<void> callOffersApiWithoutToken() async {
    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
        });

        var map = Map<String, dynamic>();

        _homeViewModel.offerWithoutToken(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
          ToastUtil.showToast(context, "No internet");
        });
      }
    });
  }

  Future<void> callLikeOffersApi(int offerId) async {
   Util.check().then((value) {
     if (value != null && value) {
       // Internet Present Case
       setState(() {
         _isInternetAvailable = true;
           _isInAsyncCall = true;
       });

       var map = Map<String, dynamic>();
       map['offer_id'] = offerId;
       map['status'] = 10;
       _homeViewModel.likeDislikeOffer(map);
     } else {
       setState(() {
         _isInternetAvailable = false;
         ToastUtil.showToast(context, "No internet");
       });
     }
   });
  }

  Future<void> callDisLikeOffersApi(int offerId) async {
   Util.check().then((value) {
     if (value != null && value) {
       // Internet Present Case
       setState(() {
         _isInternetAvailable = true;
           _isInAsyncCall = true;
       });

       var map = Map<String, dynamic>();
       map['offer_id'] = offerId;
       map['status'] = 20;
       _homeViewModel.likeDislikeOffer(map);
     } else {
       setState(() {
         _isInternetAvailable = false;
         ToastUtil.showToast(context, "No internet");
       });
     }
   });
  }

  Future<void> redeemOffersApi(int offerId,String qr) async {
    _playAnimation();
    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {

            qrUrl = qr;

          _isInternetAvailable = true;
        });

        var map = Map<String, dynamic>();
        map['offer_id'] = offerId;
        _homeViewModel.redeemOffer(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
          ToastUtil.showToast(context, "No internet");
        });
      }
    });
  }

  void subscribeToViewModel() {
    _homeViewModel
        .getHomeRepository()
        .getRepositoryResponse()
        .listen((response) async {
      _stopAnimation();
      if (mounted) {
        setState(() {
          _enabled = true;
          _isInAsyncCall = false;
          _initialCall = false;
          _isRefreshing = true;
        });
      }

      if (response.data is OfferModel) {
        OfferModel responseRegister = response.data;

        print('total ${responseRegister.data.lastPage}');
        _totalPages = responseRegister.data.lastPage;

        dataList.clear();
//        dataList.addAll(responseRegister.data.dataclass);
        dataList.addAll(responseRegister.data.dataclass.where((a) => dataList.every((b) => a.id != b.id)));


        if (dataList.isNotEmpty) {
          for (int i = 0; i < dataList.length; i++) {
            print("index $i, length ${dataList.length}");
            _swipeItems.add(SwipeItem(
              content: Content(
                  text: dataList[i].value.toString(),
                  offer: dataList[i].imageUrl,
                  offerName: dataList[i].productName,
                  time: TimerUtils.formatUTCTime(dataList[i].expireAt),
                  image: dataList[i].imageUrl,
                  coord: dataList[i].user.latitude != null ?Coords(double.parse(dataList[i].user.latitude),
                      double.parse(dataList[i].user.longitude)):Coords(0.0,0.0),
                  locationTitle: dataList[i].store != null?dataList[i].store.name:"-",
                 data: dataList[i]),
              likeAction: () {
                if (!widget.isGuestLogin) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context1) {
                        return CustomDialog(
                          showAnimatedBtn: false,
                          contex: context,
                          subTitle: "This offer has been marked Favorite!",
                          child: SvgPicture.asset(AppImages.FAV_ICON),
                          //title: "Your feedback will help us improve our services.",
                          buttonText1: AppStrings.REDEEM_NOW,
                          buttonText2: AppStrings.GO_BACK_TO_OFFER,
                          onPressed1: () {
                            Navigator.pop(context1);
                            showDialog(
                                context: context,
                                builder: (BuildContext context1) {
                                  return CustomDialog(
                                    showAnimatedBtn: true,
                                    contex: context,
                                    subTitle: "Are you sure?",
                                    //title: "Your feedback will help us improve our services.",

                                    btnWidget: AnimatedGradientButton(
                                      onAnimationTap: () {
                                        redeemOffersApi(dataList[i].id,dataList[i].qrUrl);

                                      },
                                      buttonController: _buttonController,
                                      text: AppStrings.YES,
                                    ),
                                    buttonText2: AppStrings.NO,
                                    onPressed2: () {
                                      Navigator.pop(context1);
                                    },
                                    showImage: false,
                                  );
                                });
                          },
                          onPressed2: () {
                            Navigator.pop(context1);
                          },
                          showImage: true,
                        );
                      });
                  callLikeOffersApi(dataList[i].id);
                } else {
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.SIGN_IN_VIEW,(route) => false);
                }

              },
              nopeAction: () {
                if (widget.isGuestLogin) {
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.SIGN_IN_VIEW,(route) => false);
                }else{
                  callDisLikeOffersApi(dataList[i].id);
                }

//            ToastUtil.showToast(context, "Disliked ${_names[i]}");
              },
            ));
          }

          if (_currentPage > 1) {
            setState(() {

            });
          } else {
            _matchEngine = MatchEngine(swipeItems: _swipeItems);
          }
        }
      } else if (response.data is RedeemOfferModel) {
        ToastUtil.showToast(context, response.msg);
        Navigator.pop(context);
        Navigator.pushNamed(context, AppRoutes.QR_SCAN_VIEW, arguments: {
          'fromSavedCoupon': false,
          'qrImage': qrUrl,
          'offer_id': response.data.offerId,
        });
      } else if (response.data is LikeDislikeModel) {
        ToastUtil.showToast(context, response.msg);
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

class PermissionSetting extends StatelessWidget {
  const PermissionSetting({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 25.0.h,
          margin: EdgeInsets.fromLTRB(0.0, 7.0.h, 0, 0),
          child: Center(),
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: Text(
                "Location permission is required",
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
          onTap: () {},
          text: "Please Enable Location",
        ),
        SizedBox(
          height: 15.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        SizedBox(
          height: 70.0,
        )
      ],
    );
  }
}

class Content {
  final String text;
  final String image;
  final String offer;
  final String offerName;
  final String time;
  final String locationTitle;
  final Coords coord;
  final Dataclass data;

  Content(
      {this.text,
      this.image,
      this.time,
      this.offer,
      this.offerName,
      this.coord,
      this.locationTitle,
      this.data});
}
