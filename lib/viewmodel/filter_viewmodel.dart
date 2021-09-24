import 'dart:async';

import 'package:ampd/repo/filter_repository.dart';
import 'package:flutter/material.dart';
import 'package:ampd/app/app.dart';

class FilterViewModel {
  FilterRepository _filterRepository;

  static FilterViewModel _instance;

  factory FilterViewModel(App app) {
    _instance ??= FilterViewModel._internal(filterRepository: app.getFilterRepository(
        appPreferences: app.getAppPreferences()));
    return _instance;
  }

  FilterViewModel._internal(
      {@required FilterRepository filterRepository}) {
    _filterRepository = filterRepository;
  }

  FilterRepository getAboutRepository() => _filterRepository;

  FilterRepository clearRepositroyResponse() {
    _filterRepository = null;
  }

  void updateProfile(Map<String, dynamic> map) {
    _filterRepository.updateProfile(map);
  }


}
