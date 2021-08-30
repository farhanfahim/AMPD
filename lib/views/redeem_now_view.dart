import 'package:ampd/app/app.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/data/model/OfferDataClassModel.dart';
import 'package:ampd/data/model/UserLocation.dart';
import 'package:ampd/utils/ToastUtil.dart';
import 'package:ampd/utils/Util.dart';
import 'package:ampd/viewmodel/redeem_now_viewmodel.dart';
import 'package:ampd/widgets/offer_card_widget_2.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';

class RedeemNowView extends StatefulWidget {

  Map<String, dynamic> map;

  RedeemNowView(this.map);
  @override
  _RedeemNowViewState createState() => _RedeemNowViewState();
}

class _RedeemNowViewState extends State<RedeemNowView> {
  String _appBarTitle = 'Offer';
  RedeemNowViewModel _redeemNowViewModel;
  Dataclass singleOfferModel;

  bool _enabled = true;
  bool _isInternetAvailable = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _redeemNowViewModel = RedeemNowViewModel(App());
    subscribeToViewModel();
    callRedeemOfferApi(widget.map['offer_id']);
  }
  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    final appBar1 = appBar(
        title: _appBarTitle, onBackClick: (){
      Navigator.of(context).pop();
    },
        iconColor:AppColors.COLOR_BLACK,
        hasLeading: true
    );

    final body = SafeArea(
        child: singleOfferModel != null ? OfferCardWidget2(
          isRedeemNow: true,
          image: singleOfferModel.imageUrl,
          offer: AppImages.STARBUCKS_OFFER,
          offerName: "Starbucks Triple Mocha",
          text: singleOfferModel.title,
          time: "2021-07-03 09:00:00",
          coord: Coords(double.parse(singleOfferModel.user.latitude), double.parse(singleOfferModel.user.longitude)),
          currentCoords: userLocation,
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
        ):Container(),
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
        });
      }

      if(response.data is Dataclass) {

        singleOfferModel = response.data;
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
