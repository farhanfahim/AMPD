import 'dart:async';

import 'package:ampd/repo/saved_coupon_repository.dart';
import 'package:flutter/material.dart';
import 'package:ampd/app/app.dart';

class ActiveCouponViewModel {
  SavedCouponRepository _savedCouponRepository;

  static ActiveCouponViewModel _instance;

  factory ActiveCouponViewModel(App app) {
    _instance ??= ActiveCouponViewModel._internal(savedCouponRepository: app.getSavedCouponRepository(
        appPreferences: app.getAppPreferences()));
    return _instance;
  }

  ActiveCouponViewModel._internal(
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
