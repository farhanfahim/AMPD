import 'dart:async';

import 'package:ampd/repo/home_repository.dart';
import 'package:ampd/repo/redeem_now_repository.dart';
import 'package:flutter/material.dart';
import 'package:ampd/app/app.dart';

class RedeemNowViewModel {
  RedeemNowRepository _redeemOfferRepository;

  static RedeemNowViewModel _instance;

  factory RedeemNowViewModel(App app) {
    _instance ??= RedeemNowViewModel._internal(redeemOfferRepository: app.getRedeemNowRepository(
        appPreferences: app.getAppPreferences()));
    return _instance;
  }

  RedeemNowViewModel._internal(
      {@required RedeemNowRepository redeemOfferRepository}) {
    _redeemOfferRepository = redeemOfferRepository;
  }

  RedeemNowRepository getRedeemRepository() => _redeemOfferRepository;

  RedeemNowRepository clearRepositroyResponse() {
    _redeemOfferRepository = null;
  }

  void redeemNow(Map<String, dynamic> map,int id) {
    _redeemOfferRepository.getRedeemOffers(map,id);
  }

  void redeemOffer(Map<String, dynamic> map) {
    _redeemOfferRepository.redeemOffer(map);
  }



}
