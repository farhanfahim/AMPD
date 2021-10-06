import 'dart:async';

import 'package:ampd/repo/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:ampd/app/app.dart';

class SettingsViewModel {
  SettingsRepository _settingsRepository;

  static SettingsViewModel _instance;

  factory SettingsViewModel(App app) {
    _instance ??= SettingsViewModel._internal(settingsRepository: app.getSettingsRepository(
        appPreferences: app.getAppPreferences()));
    return _instance;
  }

  SettingsViewModel._internal(
      {@required SettingsRepository settingsRepository}) {
    _settingsRepository = settingsRepository;
  }

  SettingsRepository getSettingsRepository() => _settingsRepository;

  SettingsRepository clearRepositroyResponse() {
    _settingsRepository = null;
  }

  void updateSettings(Map<String, dynamic> map) {
    _settingsRepository.updateSettings(map);
  }

  void logout(Map<String, dynamic> map) {
    _settingsRepository.logout(map);
  }
}
