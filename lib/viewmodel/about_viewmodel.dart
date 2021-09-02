import 'dart:async';

import 'package:ampd/repo/about_repository.dart';
import 'package:ampd/repo/side_menu_repository.dart';
import 'package:flutter/material.dart';
import 'package:ampd/app/app.dart';

class AboutViewModel {
  AboutRepository _aboutRepository;

  static AboutViewModel _instance;

  factory AboutViewModel(App app) {
    _instance ??= AboutViewModel._internal(aboutRepository: app.getAboutRepository(
        appPreferences: app.getAppPreferences()));
    return _instance;
  }

  AboutViewModel._internal(
      {@required AboutRepository aboutRepository}) {
    _aboutRepository = aboutRepository;
  }

  AboutRepository getAboutRepository() => _aboutRepository;

  AboutRepository clearRepositroyResponse() {
    _aboutRepository = null;
  }

  void getpage(Map<String, dynamic> map) {
    _aboutRepository.getPage(map);
  }

}
