import 'dart:async';

import 'package:ampd/repo/saved_coupon_repository.dart';
import 'package:flutter/material.dart';
import 'package:ampd/app/app.dart';

class SavedCouponViewModel {
  SavedCouponRepository _savedCouponRepository;

  static SavedCouponViewModel _instance;

  factory SavedCouponViewModel(App app) {
    _instance ??= SavedCouponViewModel._internal(savedCouponRepository: app.getSavedCouponRepository(
        appPreferences: app.getAppPreferences()));
    return _instance;
  }

  SavedCouponViewModel._internal(
      {@required SavedCouponRepository savedCouponRepository}) {
    _savedCouponRepository = savedCouponRepository;
  }

  SavedCouponRepository getHomeRepository() => _savedCouponRepository;

  SavedCouponRepository clearRepositroyResponse() {
    _savedCouponRepository = null;
  }


  void savedCoupons(Map<String, dynamic> map) {
    _savedCouponRepository.getSavedCoupons(map);
  }


}
