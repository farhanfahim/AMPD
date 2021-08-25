import 'dart:async';

import 'package:ampd/repo/home_repository.dart';
import 'package:ampd/repo/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:ampd/app/app.dart';
import 'package:ampd/repo/register_repository.dart';

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

  HomeRepository getLoginRepository() => _homeRepository;

  RegisterRepository clearRepositroyResponse() {
    _homeRepository = null;
  }

  void offer(Map map) {
    _homeRepository.offers(map);
  }



}
