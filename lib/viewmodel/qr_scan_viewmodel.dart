import 'dart:async';

import 'package:ampd/repo/qr_scan_repository.dart';
import 'package:flutter/material.dart';
import 'package:ampd/app/app.dart';

class QrScanViewModel {
  QrScanRepository _qrScanRepository;

  static QrScanViewModel _instance;

  factory QrScanViewModel(App app) {
    _instance ??= QrScanViewModel._internal(qrScanRepository: app.getQrScanRepository(
        appPreferences: app.getAppPreferences()));
    return _instance;
  }

  QrScanViewModel._internal(
      {@required QrScanRepository qrScanRepository}) {
    _qrScanRepository = qrScanRepository;
  }

  QrScanRepository getQrScanRepository() => _qrScanRepository;

  QrScanRepository clearRepositroyResponse() {
    _qrScanRepository = null;
  }


  void offerReview(Map map) {
    _qrScanRepository.offerReview(map);
  }



}
