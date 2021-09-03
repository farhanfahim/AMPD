import 'dart:async';

import 'package:ampd/repo/saved_coupon_repository.dart';
import 'package:flutter/material.dart';
import 'package:ampd/app/app.dart';

class ExpiredCouponViewModel {
  SavedCouponRepository _savedCouponRepository;

  static ExpiredCouponViewModel _instance;

  factory ExpiredCouponViewModel(App app) {
    _instance ??= ExpiredCouponViewModel._internal(savedCouponRepository: app.getSavedCouponRepository(
        appPreferences: app.getAppPreferences()));
    return _instance;
  }

  ExpiredCouponViewModel._internal(
      {@required SavedCouponRepository savedCouponRepository}) {
    _savedCouponRepository = savedCouponRepository;
  }

  SavedCouponRepository getSavedCouponRepository() => _savedCouponRepository;

  SavedCouponRepository clearRepositroyResponse() {
    _savedCouponRepository = null;
  }


  void savedCoupons(Map<String, dynamic> map) {
    _savedCouponRepository.getSavedCoupons(map);
  }


}
