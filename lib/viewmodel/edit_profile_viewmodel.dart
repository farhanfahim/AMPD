import 'dart:async';

import 'package:ampd/repo/edit_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:ampd/app/app.dart';

class EditProfileViewModel {
  EditProfileRepository _editProfileRepository;

  static EditProfileViewModel _instance;

  factory EditProfileViewModel(App app) {
    _instance ??= EditProfileViewModel._internal(editProfileRepository: app.getEditProfileRepository(
        appPreferences: app.getAppPreferences()));
    return _instance;
  }

  EditProfileViewModel._internal(
      {@required EditProfileRepository editProfileRepository}) {
    _editProfileRepository = editProfileRepository;
  }

  EditProfileRepository getEditProfileRepository() => _editProfileRepository;

  EditProfileRepository clearRepositroyResponse() {
    _editProfileRepository = null;
  }

  void verificationCodeToEmail(Map<String, dynamic> map) {
    _editProfileRepository.verificationCodeToEmail(map);
  }

  void verificationCodeToPhone(Map<String, dynamic> map) {
    _editProfileRepository.verificationCodeToPhone(map);
  }
}
