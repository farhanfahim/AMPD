import 'dart:async';

import 'package:ampd/repo/register_via_phone_repository.dart';
import 'package:flutter/material.dart';
import 'package:ampd/app/app.dart';
import 'package:ampd/repo/register_repository.dart';

class RegisterViaPhoneViewModel {
  RegisterViaPhoneRepository _registerRepository;

  static RegisterViaPhoneViewModel _instance;

  factory RegisterViaPhoneViewModel(App app) {
    _instance ??= RegisterViaPhoneViewModel._internal(registerRepository: app.getRegisterViaPhoneRepository(
        appPreferences: app.getAppPreferences()));
    return _instance;
  }

  RegisterViaPhoneViewModel._internal(
      {@required RegisterViaPhoneRepository registerRepository}) {
    _registerRepository = registerRepository;
  }

  RegisterViaPhoneRepository getSignUpRepository() => _registerRepository;

  RegisterRepository clearRepositroyResponse() {
    _registerRepository = null;
  }

  void registerViaPhone(Map map) {
    _registerRepository.registerViaPhone(map);
  }


}
