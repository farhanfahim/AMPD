import 'dart:async';

import 'package:ampd/repo/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:ampd/app/app.dart';

class HomeViewModel {
  HomeRepository _homeRepository;

  static HomeViewModel _instance;

  factory HomeViewModel(App app) {
    _instance ??= HomeViewModel._internal(homeRepository: app.getHomeRepository(
        appPreferences: app.getAppPreferences()));
    return _instance;
  }

  HomeViewModel._internal(
      {@required HomeRepository homeRepository}) {
    _homeRepository = homeRepository;
  }

  HomeRepository getHomeRepository() => _homeRepository;

  HomeRepository clearRepositroyResponse() {
    _homeRepository = null;
  }

  void offer(Map<String, dynamic> map) {
    _homeRepository.offers(map);
  }

  void offerWithoutToken(Map<String, dynamic> map) {
    _homeRepository.offersWithoutToken(map);
  }

  void redeemOffer(Map<String, dynamic> map) {
    _homeRepository.redeemOffer(map);
  }

  void likeDislikeOffer(Map<String, dynamic> map) {
    _homeRepository.offersLikeDislike(map);
  }

  void getReviews(Map<String, dynamic> map) {
    _homeRepository.getReviews(map);
  }




}
