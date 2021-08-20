import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ampd/app/app.dart';
import 'package:ampd/repo/register_repository.dart';

class RegisterViewModel {
  RegisterRepository _registerRepository;

  static RegisterViewModel _instance;

  factory RegisterViewModel(App app) {
    _instance ??= RegisterViewModel._internal(registerRepository: app.getRegisterRepository(
        appPreferences: app.getAppPreferences()));
    return _instance;
  }

  RegisterViewModel._internal(
      {@required RegisterRepository registerRepository}) {
    _registerRepository = registerRepository;
  }

  RegisterRepository getSignUpRepository() => _registerRepository;

  RegisterRepository clearRepositroyResponse() {
    _registerRepository = null;
  }

  void register(Map map) {
    _registerRepository.register(map);
  }

}
