import 'dart:async';

import 'package:ampd/repo/about_repository.dart';
import 'package:ampd/repo/notification_repository.dart';
import 'package:ampd/repo/side_menu_repository.dart';
import 'package:flutter/material.dart';
import 'package:ampd/app/app.dart';

class NotificationViewModel {
  NotificationRepository _notificationRepository;

  static NotificationViewModel _instance;

  factory NotificationViewModel(App app) {
    _instance ??= NotificationViewModel._internal(notificationRepository: app.getNotificationRepository(
        appPreferences: app.getAppPreferences()));
    return _instance;
  }

  NotificationViewModel._internal(
      {@required NotificationRepository notificationRepository}) {
    _notificationRepository = notificationRepository;
  }

  NotificationRepository getNotificationRepository() => _notificationRepository;

  NotificationRepository clearRepositroyResponse() {
    _notificationRepository = null;
  }

  void getNotification(Map<String, dynamic> map) {
    _notificationRepository.getNotification(map);
  }

}
