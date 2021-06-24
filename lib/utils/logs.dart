import 'package:flutter/material.dart';

const kLOG_ENABLE = true;
const kLOG_TAG = "[LOGS]";

void printLog(dynamic data) {
  if (kLOG_ENABLE) {
    /// "y-m-d h:min:sec.msZ"
    final String now = DateTime.now().toUtc().toString().split(' ').last;
    debugPrint("[$now]$kLOG_TAG${data.toString()}");
  }
}
