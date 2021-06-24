import 'dart:io';

import 'package:permission_handler/permission_handler.dart';


class MediaPermissionHandler{
  //PermissionGroup.storage, PermissionGroup.photos

  // static Future<PermissionStatus> checkCameraPermission() async {
  //   final PermissionHandler _permissionHandler = PermissionHandler();
  //   return _permissionHandler.checkPermissionStatus(PermissionGroup.camera);
  // }
  //
  // static Future<PermissionStatus> checkGalleryPermission() async {
  //   final PermissionHandler _permissionHandler = PermissionHandler();
  //   return _permissionHandler.checkPermissionStatus(Platform.isIOS ? PermissionGroup.storage : PermissionGroup.photos);
  // }

  static Future<void> requestCameraPermission() async {
    final PermissionHandler _permissionHandler = PermissionHandler();
    _permissionHandler.requestPermissions([PermissionGroup.camera]);
  }
  static  Future<bool> checkGalleryCameraPermission() async {
    final permissionCameraGroup =
        PermissionGroup.camera;
    final permissionMicrophoneGroup =
        PermissionGroup.microphone;
    final permissionStorageGroup =
    Platform.isIOS ? PermissionGroup.photos : PermissionGroup.storage;
    Map<PermissionGroup, PermissionStatus> res =
    await PermissionHandler().requestPermissions([
      permissionCameraGroup,
      permissionMicrophoneGroup,
      permissionStorageGroup,
    ]);
    return res[permissionStorageGroup] == PermissionStatus.granted;
  }

  static Future<void> requestGalleryPermission() async {
    final PermissionHandler _permissionHandler = PermissionHandler();
    _permissionHandler.requestPermissions([Platform.isIOS ? PermissionGroup.photos : PermissionGroup.storage]);
  }

  static String permissionStatusResult(PermissionStatus result){
    switch (result) {
      case PermissionStatus.unknown:
        return 'unknown';
        break;
      case PermissionStatus.granted:
        return 'granted';

        break;
      case PermissionStatus.denied:

        return 'denied';
        break;
      case PermissionStatus.disabled:

        return 'disabled';
        break;
      case PermissionStatus.restricted:
        return 'restricted';
        break;

      default:
        break;
        return 'unknown';
    }
  }

  static String permissionStatusResult1(PermissionStatus result){
    switch (result) {
      case PermissionStatus.granted:

        return 'granted';

        break;
      case PermissionStatus.denied:

        return 'denied';
        break;
      case PermissionStatus.disabled:

        return 'disabled';
        break;
      case PermissionStatus.restricted:
        return 'restricted';
        break;
      case PermissionStatus.unknown:
        return 'unknown';
        break;
      default:
    }
  }

  static  Future<bool> checkCameraPermission() async {
    final permissionStorageGroup =
        PermissionGroup.camera;
    Map<PermissionGroup, PermissionStatus> res =
    await PermissionHandler().requestPermissions([
      permissionStorageGroup,
    ]);
    return res[permissionStorageGroup] == PermissionStatus.granted;
  }


  static  Future<bool> checkGalleryPermission() async {
    final permissionStorageGroup =
    Platform.isIOS ? PermissionGroup.photos : PermissionGroup.storage;
    Map<PermissionGroup, PermissionStatus> res =
    await PermissionHandler().requestPermissions([
      permissionStorageGroup,
    ]);
    return res[permissionStorageGroup] == PermissionStatus.granted;
  }

  static Future<String> cameraPermissionAsked() async {
    PermissionStatus status = await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
    return permissionStatusResult(status);
  }

  static Future<String> microphonePermissionAsked() async {
    PermissionStatus status = await PermissionHandler().checkPermissionStatus(PermissionGroup.microphone);
    return permissionStatusResult(status);
  }

  static Future<String> photosPermissionAsked() async {
    PermissionStatus status = await PermissionHandler().checkPermissionStatus(Platform.isIOS ? PermissionGroup.photos : PermissionGroup.storage);
    return permissionStatusResult(status);
  }

  static  Future<bool> checkCameraMicPhotosPermission() async {
    final permissionCameraGroup =
        PermissionGroup.camera;
    final permissionMicrophoneGroup =
        PermissionGroup.microphone;
    final permissionPhotosGroup =
    Platform.isIOS ? PermissionGroup.photos : PermissionGroup.storage;
    Map<PermissionGroup, PermissionStatus> res =
    await PermissionHandler().requestPermissions([
      permissionCameraGroup,
      permissionMicrophoneGroup,
      permissionPhotosGroup
    ]);

    if(res[permissionCameraGroup] == PermissionStatus.granted && res[permissionMicrophoneGroup] == PermissionStatus.granted && res[permissionPhotosGroup] == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}