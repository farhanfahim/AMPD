import 'dart:async';

import 'package:ampd/repo/change_password_repository.dart';
import 'package:flutter/material.dart';
import 'package:ampd/app/app.dart';

class ChangePasswordViewModel {
  ChangePasswordRepository _changePasswordRepository;

  static ChangePasswordViewModel _instance;

  factory ChangePasswordViewModel(App app) {
    _instance ??= ChangePasswordViewModel._internal(changePasswordRepository: app.getChangePasswordRepository(
        appPreferences: app.getAppPreferences()));
    return _instance;
  }

  ChangePasswordViewModel._internal(
      {@required ChangePasswordRepository changePasswordRepository}) {
    _changePasswordRepository = changePasswordRepository;
  }

  ChangePasswordRepository getChangePasswordRepository() => _changePasswordRepository;

  ChangePasswordRepository clearRepositroyResponse() {
    _changePasswordRepository = null;
  }

  void changePassword(Map<String, dynamic> map) {
    _changePasswordRepository.changePassword(map);
  }
}
