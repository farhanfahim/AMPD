import 'dart:async';

import 'package:ampd/repo/about_repository.dart';
import 'package:ampd/repo/side_menu_repository.dart';
import 'package:ampd/repo/terms_condition_repository.dart';
import 'package:flutter/material.dart';
import 'package:ampd/app/app.dart';

class TermsConditionViewModel {
  TermsConditionRepository _termConditionRepository;

  static TermsConditionViewModel _instance;

  factory TermsConditionViewModel(App app) {
    _instance ??= TermsConditionViewModel._internal(termConditionRepository: app.getTermsConditionRepository(
        appPreferences: app.getAppPreferences()));
    return _instance;
  }

  TermsConditionViewModel._internal(
      {@required TermsConditionRepository termConditionRepository}) {
    _termConditionRepository = termConditionRepository;
  }

  TermsConditionRepository getTermConditionRepository() => _termConditionRepository;

  TermsConditionRepository clearRepositroyResponse() {
    _termConditionRepository = null;
  }

  void getpage(Map<String, dynamic> map) {
    _termConditionRepository.getPage(map);
  }

}
