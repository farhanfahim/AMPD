import 'dart:async';

import 'package:ampd/repo/active_coupon_repository.dart';
import 'package:ampd/repo/saved_coupon_repository.dart';
import 'package:flutter/material.dart';
import 'package:ampd/app/app.dart';

class ActiveCouponViewModel {
  ActiveCouponRepository _activeCouponRepository;

  static ActiveCouponViewModel _instance;

  factory ActiveCouponViewModel(App app) {
    _instance ??= ActiveCouponViewModel._internal(activeCouponRepository: app.getActiveCouponRepository(
        appPreferences: app.getAppPreferences()));
    return _instance;
  }

  ActiveCouponViewModel._internal(
      {@required ActiveCouponRepository activeCouponRepository}) {
    _activeCouponRepository = activeCouponRepository;
  }

  ActiveCouponRepository getActiveCouponRepository() => _activeCouponRepository;

  ActiveCouponRepository clearRepositroyResponse() {
    _activeCouponRepository = null;
  }

  void redeemOffer(Map<String, dynamic> map) {
    _activeCouponRepository.redeemOffer(map);
  }
  void deleteOffer(Map<String, dynamic> map) {
    _activeCouponRepository.deleteOffer(map);
  }


  void savedCoupons(Map<String, dynamic> map) {
    _activeCouponRepository.getSavedCoupons(map);
  }


}
