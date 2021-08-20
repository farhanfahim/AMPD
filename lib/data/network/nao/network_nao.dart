import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:ampd/utils/network_util.dart';

import '../network_config.dart';
import '../network_endpoints.dart';

class NetworkNAO {

  static Future<dynamic> signUp(Map map) async => NetworkUtil()
      .post(
      url: NetworkEndpoints.SIGNUP,
      hasHeader: false,
      token: "",
      formData: FormData.fromMap({
        NetworkConfig.API_KEY_NAME: map['name'],
        NetworkConfig.API_KEY_EMAIL: map['email'],
        NetworkConfig.API_KEY_PASSWORD: map['password'],
        NetworkConfig.API_KEY_PASSWORD_CONFIRMATION: map['password_confirmation'],
        NetworkConfig.API_KEY_DEVICE_TYPE: map['device_type'],
        NetworkConfig.API_KEY_DEVICE_TOKEN: map['device_token']
      }))
      .then((dynamic response) {
    print(response);
    return response;
  });

  static Future<dynamic> login(String email, String password, String deviceType,
          String deviceToken) =>
      NetworkUtil()
          .post(
              url: NetworkEndpoints.LOGIN,
              hasHeader: false,
              token: "",
              formData: FormData.fromMap({
                NetworkConfig.API_KEY_EMAIL: email,
                NetworkConfig.API_KEY_PASSWORD: password,
                NetworkConfig.API_KEY_DEVICE_TYPE: deviceType,
                NetworkConfig.API_KEY_DEVICE_TOKEN: deviceToken
              }))
          .then((dynamic response) {
        print(response);
        return response;
      });

  static Future<dynamic> forgotPassowrd(Map<String, String> map) =>
      NetworkUtil().post(
          url: NetworkEndpoints.FORGOT_PASSWORD,
          hasHeader: false,
          token: null,
          formData: FormData.fromMap({
            NetworkConfig.API_KEY_EMAIL: map['email'],
          })
      ).then((dynamic response) {
        print(map['email']);
        //print(response);
        return response;
      });

  static Future<dynamic> verifyEmailOTP(Map<String, String> map) =>
      NetworkUtil().post(
          url: NetworkEndpoints.VERIFY_EMAIL_API,
          hasHeader: false,
          token: null,
          formData: FormData.fromMap({
            NetworkConfig.API_KEY_CODE: map['code'],
            NetworkConfig.API_KEY_EMAIL: map['email'],
          })
      ).then((dynamic response) {

        print(map['code']);
        print(map['email']);
        //print(response);
        return response;
      });

  static Future<dynamic> resendEmailOTPCode(Map<String, String> map) =>
      NetworkUtil().post(
          url: NetworkEndpoints.RESEND_EMAIL_OTP_CODE,
          hasHeader: false,
          token: null,
          formData: FormData.fromMap({
            NetworkConfig.API_KEY_EMAIL: map['email'],
          })
      ).then((dynamic response) {
        //print(response);
        return response;
      });

}
