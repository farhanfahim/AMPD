import 'dart:async';

import 'package:ampd/repo/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:ampd/app/app.dart';
import 'package:ampd/repo/register_repository.dart';

class LoginViewModel {
  LoginRepository _loginRepository;

  static LoginViewModel _instance;

  factory LoginViewModel(App app) {
    _instance ??= LoginViewModel._internal(loginRepository: app.getLoginRepository(
        appPreferences: app.getAppPreferences()));
    return _instance;
  }

  LoginViewModel._internal(
      {@required LoginRepository loginRepository}) {
    _loginRepository = loginRepository;
  }

  LoginRepository getLoginRepository() => _loginRepository;

  RegisterRepository clearRepositroyResponse() {
    _loginRepository = null;
  }

  void login(Map map) {
    _loginRepository.login(map);
  }

  void verifyOtp(Map map) {
    _loginRepository.verifyOtp(map);
  }

  void registerViaPhone(Map map) {
    _loginRepository.registerViaPhone(map);
  }

  void resetPassword(Map map) {
    _loginRepository.resetPassword(map);
  }

  void forgetPassword(Map map) {
    _loginRepository.forgetPassword(map);
  }


}
