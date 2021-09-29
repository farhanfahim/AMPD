import 'dart:async';

import 'package:ampd/repo/saved_coupon2_repository.dart';
import 'package:ampd/repo/saved_coupon_repository.dart';
import 'package:flutter/material.dart';
import 'package:ampd/app/app.dart';

class SavedCoupon2ViewModel {
  SavedCoupon2Repository _savedCoupon2Repository;

  static SavedCoupon2ViewModel _instance;

  factory SavedCoupon2ViewModel(App app) {
    _instance ??= SavedCoupon2ViewModel._internal(savedCoupon2Repository: app.getSavedCoupon2Repository(
        appPreferences: app.getAppPreferences()));
    return _instance;
  }

  SavedCoupon2ViewModel._internal(
      {@required SavedCoupon2Repository savedCoupon2Repository}) {
    _savedCoupon2Repository = savedCoupon2Repository;
  }

  SavedCoupon2Repository getSavedCoupon2Repository() => _savedCoupon2Repository;

  SavedCoupon2Repository clearRepositroyResponse() {
    _savedCoupon2Repository = null;
  }


  void savedCoupons(Map<String, dynamic> map) {
    _savedCoupon2Repository.getSavedCoupons(map);
  }

  void redeemOffer(Map<String, dynamic> map) {
    _savedCoupon2Repository.redeemOffer(map);
  }


}
