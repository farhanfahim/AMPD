import 'dart:async';

import 'package:ampd/repo/side_menu_repository.dart';
import 'package:flutter/material.dart';
import 'package:ampd/app/app.dart';

class SideMenuViewModel {
  SideMenuRepository _sideMenuRepository;

  static SideMenuViewModel _instance;

  factory SideMenuViewModel(App app) {
    _instance ??= SideMenuViewModel._internal(sideMenuRepository: app.getSideMenuRepository(
        appPreferences: app.getAppPreferences()));
    return _instance;
  }

  SideMenuViewModel._internal(
      {@required SideMenuRepository sideMenuRepository}) {
    _sideMenuRepository = sideMenuRepository;
  }

  SideMenuRepository getSideMenuRepository() => _sideMenuRepository;

  SideMenuRepository clearRepositroyResponse() {
    _sideMenuRepository = null;
  }

  void logout(Map<String, dynamic> map) {
    _sideMenuRepository.logout(map);
  }

}
