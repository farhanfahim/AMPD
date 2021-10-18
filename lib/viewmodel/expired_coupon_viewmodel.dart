import 'dart:async';

import 'package:ampd/repo/expired_coupon_repository.dart';
import 'package:flutter/material.dart';
import 'package:ampd/app/app.dart';

class ExpiredCouponViewModel {
  ExpiredCouponRepository _expiredCouponRepository;

  static ExpiredCouponViewModel _instance;

  factory ExpiredCouponViewModel(App app) {
    _instance ??= ExpiredCouponViewModel._internal(expiredCouponRepository: app.getExpiredCouponRepository(
        appPreferences: app.getAppPreferences()));
    return _instance;
  }

  ExpiredCouponViewModel._internal(
      {@required ExpiredCouponRepository expiredCouponRepository}) {
    _expiredCouponRepository = expiredCouponRepository;
  }

  ExpiredCouponRepository getSavedCouponRepository() => _expiredCouponRepository;

  ExpiredCouponRepository clearRepositroyResponse() {
    _expiredCouponRepository = null;
  }


  void savedCoupons(Map<String, dynamic> map) {
    _expiredCouponRepository.getSavedCoupons(map);
  }


}
