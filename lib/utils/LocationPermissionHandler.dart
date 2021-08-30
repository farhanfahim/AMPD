import 'package:flutter/material.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:ampd/utils/ToastUtil.dart';

class LocationPermissionHandler{

  static ServiceStatus checkServiceStatus(
      BuildContext context) {
    LocationPermissions()
        .checkServiceStatus()
        .then((ServiceStatus serviceStatus) {

          return serviceStatus;

          ToastUtil.showToast(context, serviceStatus.toString());
      // final SnackBar snackBar =
      // SnackBar(content: Text(serviceStatus.toString()));

     // Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  static Future<PermissionStatus> checkLocationPermission(){
   return LocationPermissions().checkPermissionStatus();
  }
  
  static Future<PermissionStatus> requestPermissoin(){
    return LocationPermissions().requestPermissions();
  }
}