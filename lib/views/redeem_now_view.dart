import 'dart:async';

import 'package:ampd/app/app.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/data/model/OfferDataClassModel.dart';
import 'package:ampd/data/model/OfferModel.dart';
import 'package:ampd/data/model/UserLocation.dart';
import 'package:ampd/utils/ToastUtil.dart';
import 'package:ampd/utils/Util.dart';
import 'package:ampd/viewmodel/redeem_now_viewmodel.dart';
import 'package:ampd/widgets/NoRecordFound.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:ampd/widgets/offer_card_widget_2.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:app_settings/app_settings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import 'package:ampd/utils/LocationPermissionHandler.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart' as gcl;
import 'package:sizer/sizer.dart';
import 'package:ampd/utils/loader.dart';
import 'package:location_permissions/location_permissions.dart'
as locationPermission;
class RedeemNowView extends StatefulWidget {

  Map<String, dynamic> map;


  RedeemNowView(this.map);
  @override
  _RedeemNowViewState createState() => _RedeemNowViewState();
}

class _RedeemNowViewState extends State<RedeemNowView> {
  bool _openSetting = false;
  String _appBarTitle = 'Offer';
  RedeemNowViewModel _redeemNowViewModel;
  Dataclass singleOfferModel;
  gcl.Position position;
  bool _enabled = true;
  bool isDataLoad = true;
  bool _isInternetAvailable = true;
  StreamController _streamController;
  UserLocation userLocation = UserLocation();
  @override
  void initState() {

    super.initState();
    _streamController = new StreamController<Dataclass>.broadcast();
    _streamController.add(null);

    _redeemNowViewModel = RedeemNowViewModel(App());
    subscribeToViewModel();
    getCurrentLocation();
  }

  void getCurrentLocation(){
    LocationPermissionHandler.checkLocationPermission().then((permission) {
      if (permission == locationPermission.PermissionStatus.granted) {
        setState(() {
          _openSetting = true;
          gcl.Geolocator.getCurrentPosition(
              desiredAccuracy: gcl.LocationAccuracy.medium)
              .then((value) {
            position = value;

            UserLocation(
                latitude: position.latitude, longitude: position.longitude);

            callRedeemOfferApi(widget.map['offer_id']);

          });
        });

      }else if (permission == locationPermission.PermissionStatus.unknown ||
          permission == locationPermission.PermissionStatus.denied || permission == locationPermission.PermissionStatus.restricted) {
        print('HEEEEEEEE');
        try {
          LocationPermissionHandler.requestPermissoin();
        } on PlatformException catch (err) {
          print(err);
        } catch (err) {
          print(err);
        }
      }
      else {

        setState(() {
          _openSetting = false;
        });

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final appBar1 = appBar(
        title: _appBarTitle, onBackClick: (){
      Navigator.of(context).pop();
    },
        iconColor:AppColors.COLOR_BLACK,
        hasLeading: true
    );

    final body = SafeArea(

        child: _openSetting? StreamBuilder<Dataclass>(
    stream: _streamController.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.6,
              child: Center(
                child: Loader(
                    isLoading: isDataLoad,
                    color: AppColors.ACCENT_COLOR
                ),
              ),
            );
          } else {

            return snapshot.data!= null ? OfferCardWidget2(
              isRedeemNow: true,
              image: singleOfferModel.imageUrl,
              offer: AppImages.STARBUCKS_OFFER,
              offerName: "Starbucks Triple Mocha",
              text: singleOfferModel.title,
              time: "2021-07-03 09:00:00",
              coord: Coords(double.parse(singleOfferModel.user.latitude), double.parse(singleOfferModel.user.longitude)),
              currentCoords:UserLocation(
                  latitude: position.latitude,
                  longitude: position.longitude),
              locationTitle: singleOfferModel.user.address,
              data: singleOfferModel,
              changeDetailTitle: (value) {
                setState(() {
                  if(value) {
                    _appBarTitle = 'Offer Details';
                  } else {
                    _appBarTitle = 'Offer';
                  }
                });
              },
            ): Center(
                child: NoRecordFound("No Offer Found",
                    AppImages.NO_NOTIFICATIONS_IMAGE)
            );
          }
        }):Center(
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
        ),
    );

    return Scaffold(
        appBar: appBar1,
        body: body
    );
  }

  Future<void> callRedeemOfferApi(int id) async {

    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
        });

        var map = Map<String, dynamic>();
        _redeemNowViewModel.redeemNow(map,id);
      } else {
        setState(() {
          _isInternetAvailable = false;
          ToastUtil.showToast(context, "No internet");
        });
      }
    });
  }

  void subscribeToViewModel() {
    _redeemNowViewModel
        .getRedeemRepository()
        .getRepositoryResponse()
        .listen((response) async {

      if(mounted) {
        setState(() {
          _enabled = true;
          isDataLoad= false;
        });
      }

      if(response.data is Dataclass) {

        singleOfferModel = response.data;
        _streamController.add(singleOfferModel);
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
