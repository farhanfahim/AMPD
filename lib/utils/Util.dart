import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
//import 'package:connectivity/connectivity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ToastUtil.dart';

class Util {
  static void hideKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode()); //DateFormat('MMM/dd/yyyy').format(date);
  }

  static String formatTimeToRemoveSeconds(String time) {
    DateTime tempDate = new DateFormat("HH:mm:ss").parse(
        time);
    return DateFormat("HH:mm").format(tempDate);
  }

  static String formatSlotDate(String date) {
    DateTime dateTime = DateFormat('EEEE, MMM dd, yyyy').parse(date);
    String formattedDate = DateFormat('MMM/dd/yyyy').format(dateTime);
    return formattedDate;
  }

  static String getFormattedDates(String date){
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat('EEEE, MMMM dd, yyyy').format(dateTime);
    return formattedDate;
  }

  static int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  static String getFormattedDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat('MMM/dd/yyyy').format(dateTime);
    return formattedDate;
  }

  static String getFormattedDate2(String date) {
    DateTime dateTime = DateFormat('MMM/dd/yyyy').parse(date);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }
  static String formatMonth(String date) {
    DateTime tempDate = new DateFormat("MM").parse(date);
    return DateFormat("MM").format(tempDate);
  }
  static String formatYear(String date) {
    DateTime tempDate = new DateFormat("yyyy").parse(date);
    return DateFormat("yy").format(tempDate);
  }
  static String formatDate(String date) {
    DateTime tempDate = new DateFormat("yyyy-MM-dd HH:mm:ss").parse(date);
    return DateFormat("dd MMM, yyyy").format(tempDate);
  }
  static String formatDate2(String date) {
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(date);
    return DateFormat("dd MMM, yyyy").format(tempDate);
  }

  static String formatTime(String time) {
    DateTime tempDate = new DateFormat("HH:mm:ss").parse(time);
    return DateFormat("hh:mm a").format(tempDate);
  }

  static String formatTimeNew(String time) {
    DateTime tempDate = new DateFormat("HH:mm").parse(time);
    return DateFormat("hh:mm a").format(tempDate);
  }

  static String formatTime2(String time) {
    DateTime tempDate = new DateFormat("hh:mm a").parse(time);
    return DateFormat("HH:mm").format(tempDate);
  }

  static String formatUTCTime(String time) {
    DateTime tempDate = new DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'").parse(
        time);
    return DateFormat("HH:mm").format(tempDate);
  }

  static String formatUTCDateTime(String time) {
    DateTime tempDate = new DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'").parse(
        time);
    return DateFormat("yyyy-MM-dd HH:mm").format(tempDate);
  }

  static String formatUTCTimeReceived(String time) {
    DateTime tempDate = new DateFormat("HH:mm").parse(time);
    return DateFormat("hh:mm a").format(tempDate.toLocal());
  }

  static String getDeviceType() {
    return Platform.isIOS ? "ios" : "android";
  }

  static String convertLocalDateTimeToUTC(String time) {
    DateTime tempDate = new DateFormat("yyyy-MM-dd HH:mm").parse(time);
    return formatUTCDateTime(tempDate.toUtc().toString());
  }

  static String convertUTCDateTimeToLocal(String time) {
    DateTime tempDate = new DateFormat("yyyy-MM-dd HH:mm").parse(time, true);
    // return formatUTCDateTime(tempDate.toLocal().toString());

    var xxx = DateFormat("yyyy-MM-dd HH:mm").format(tempDate.toLocal());
    return xxx; //tempDate.toLocal().toString();
  }

  static String convertLocalTimeToUTC(String time) {
    DateTime tempDate = new DateFormat("HH:mm").parse(time);
    return formatUTCTime(tempDate.toUtc().toString());
  }

  static String convertUTCTimeToLocal(String time) {
    // DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(time);

    DateTime tempDate = new DateFormat("HH:mm:SS").parse(time);
    return tempDate.toLocal().toString();
    // return formatUTCTimeReceived(tempDate.toLocal().toString());
  }

  static String convertLocalDateToUTC(String time) {
    DateTime tempDate = new DateFormat("HH:mm").parse(time);
    return tempDate.toUtc().toString();
  }

  static String convertUTCDateToLocal(String time) {
    DateTime tempDate = new DateFormat("HH:mm:ss").parse(time, true);

    var xxx = DateFormat("HH:mm:ss").format(tempDate.toLocal());

    return xxx.toString();
  }

  static bool showErrorMsg(BuildContext context, DioError error) {
    if (error.type == DioErrorType.CONNECT_TIMEOUT) {
      //ToastUtil.showToast(context, "No Internet Connectivity");
      return false;
    }

    if (error.type == DioErrorType.DEFAULT) {
      //  ToastUtil.showToast(context, "No Internet Connectivity");
      return false;
    }

    if (error.type == DioErrorType.RECEIVE_TIMEOUT) {
      // ToastUtil.showToast(context, "No Internet Connectivity");
      return false;
    }

    if (error.type == DioErrorType.SEND_TIMEOUT) {
      // ToastUtil.showToast(context, "No Internet Connectivity");
      return false;
    }
    return true;
  }

  static String getFullVariantNameFromShortCode(String code) {
    if (code == 's') {
      return "Small";
    } else if (code == 'm') {
      return "Medium";
    } else if (code == 'l') {
      return "Large";
    }
    else {
      return "Extra Large";
    }
  }

//  static Future<bool> check() async {
//    var connectivityResult = await (Connectivity().checkConnectivity());
//    if (connectivityResult == ConnectivityResult.mobile) {
//      return true;
//    } else if (connectivityResult == ConnectivityResult.wifi) {
//      return true;
//    }
//    return false;
//  }

  static Future<bool> checkCameraPermission() async {
    final permissionStorageGroup =
        PermissionGroup.camera;
    Map<PermissionGroup, PermissionStatus> res =
    await PermissionHandler().requestPermissions([
      permissionStorageGroup,
    ]);
    return res[permissionStorageGroup] == PermissionStatus.granted;
  }


  static Future<bool> checkGalleryPermission() async {
    final permissionStorageGroup =
    Platform.isIOS ? PermissionGroup.photos : PermissionGroup.storage;
    Map<PermissionGroup, PermissionStatus> res =
    await PermissionHandler().requestPermissions([
      permissionStorageGroup,
    ]);
    return res[permissionStorageGroup] == PermissionStatus.granted;
  }

// static void openSettings(){
  //   final opened = await openAppSettings(); //opens App'wide system settings
  // }

  static String checkDate(String dateString) {
    //  example, dateString = "2020-01-26";

    DateTime checkedTime = DateTime.parse(dateString);
    DateTime currentTime = DateTime.now();

    if ((currentTime.year == checkedTime.year)
        && (currentTime.month == checkedTime.month)
        && (currentTime.day == checkedTime.day)) {
      return "Today";
    } else if ((currentTime.year == checkedTime.year)
        && (currentTime.month == checkedTime.month)) {
      if ((currentTime.day - checkedTime.day) == 1) {
        return "Yesterday";
      } else {
        return dateString;
      }
    }
  }

  static String makeChatId(String myID,String selectedUserID) {
    String chatID;
    if (myID.hashCode > selectedUserID.hashCode) {
      chatID = '$selectedUserID-$myID';
    }else {
      chatID = '$myID-$selectedUserID';
    }
    return chatID;
  }

  static String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      if (diff.inHours > 0) {
        time = diff.inHours.toString() + 'h ago';
      }else if (diff.inMinutes > 0) {
        time = diff.inMinutes.toString() + 'm ago';
      }else if (diff.inSeconds > 0) {
        time = 'now';
      }else if (diff.inMilliseconds > 0) {
        time = 'now';
      }else if (diff.inMicroseconds > 0) {
        time = 'now';
      }else {
        time = 'now';
      }
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      time = diff.inDays.toString() + 'd ago';
    } else if (diff.inDays > 6){
      time = (diff.inDays / 7).floor().toString() + 'w ago';
    }else if (diff.inDays > 29) {
      time = (diff.inDays / 30).floor().toString() + 'm ago';
    }else if (diff.inDays > 365) {
      time = '${date.month}-${date.day}-${date.year}';
    }
    return time;
  }

  static String returnTimeStamp(int messageTimeStamp) {
    String resultString = '';
    // var format = DateFormat('dd/MM/yyyy hh:mm a');
    var format = DateFormat('hh:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(messageTimeStamp);
    resultString = format.format(date);
    return resultString;
  }


  static String getFileSize(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + ' ' + suffixes[i];
  }

  static  Future<void> launchInWebViewWithJavaScript(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,

      );
    } else {
      throw 'Could not launch $url';
    }
  }

  static void setPortraitMode(){
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);
  }

  static bool isValidPassowrd(String password){
    var matchingRegix = RegExp(r'[^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$]');
  }

  static bool isPasswordCompliant(BuildContext context, String password, String message) {

    print(password);

    if (password == null || password.isEmpty) {
      return false;
    }

    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    if(!hasUppercase){
      ToastUtil.showToast(context, "$message must contains at least 1 upper case letter");
      return false;
    }
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    if(!hasDigits){
      ToastUtil.showToast(context, "$message must contains at least 1 digit");
      return false;
    }
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    if(!hasLowercase){
      ToastUtil.showToast(context, "$message must contains at least 1 lower case letter");
      return false;
    }
    bool hasSpecialCharacters = password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    if(!hasSpecialCharacters){
      ToastUtil.showToast(context, "$message must contains at least 1 special character");
      return false;
    }
    bool hasMinLength = password.length >= 6;
    if(!hasMinLength){
      ToastUtil.showToast(context, "Your password must be 6 characters or more");
      return false;
    }

    return true;
  }

  static String makeStoreChatId(String storeId,String userId) {
    return "$storeId-$userId";
  }

}

