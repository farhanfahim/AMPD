import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/widgets/offer_card_widget_2.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

class RedeemNowView extends StatefulWidget {
  @override
  _RedeemNowViewState createState() => _RedeemNowViewState();
}

class _RedeemNowViewState extends State<RedeemNowView> {
  String _appBarTitle = 'Offer';

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
        child: OfferCardWidget2(
          isRedeemNow: true,
          image: "https://papers.co/wallpaper/papers.co-ax29-starbucks-logo-green-illustration-art-40-wallpaper.jpg?download=true",
          offer: AppImages.STARBUCKS_OFFER,
          offerName: "Starbucks Triple Mocha",
          text: "Offer 25% Off",
          time: "2021-07-03 09:00:00",
          coord: Coords(40.7565007, -73.986803),
          locationTitle: "Starbucks",
          changeDetailTitle: (value) {
            setState(() {
              if(value) {
                _appBarTitle = 'Offer Details';
              } else {
                _appBarTitle = 'Offer';
              }
            });
          },
        )
    );

    return Scaffold(
        appBar: appBar1,
        body: body
    );
  }
}
