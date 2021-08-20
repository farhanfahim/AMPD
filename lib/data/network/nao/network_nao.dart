
import 'package:dio/dio.dart';
import 'package:ampd/utils/network_util.dart';
import '../network_config.dart';
import '../network_endpoints.dart';

class NetworkNAO {

  static Future<dynamic> signUpViaPhone(Map map) async => NetworkUtil()
      .post(
      url: NetworkEndpoints.REGISTER_VIA_PHONE,
      hasHeader: false,
      token: "",
      formData: FormData.fromMap({
        NetworkConfig.API_KEY_PHONE: map['phone'],
      }))
      .then((dynamic response) {
    print(response);
    return response;
  });

  static Future<dynamic> signUp(Map map) async => NetworkUtil()
      .post(
      url: NetworkEndpoints.REGISTER,
      hasHeader: false,
      token: "",
      formData: FormData.fromMap({
        NetworkConfig.API_KEY_DEVICE_TOKEN: map['device_token'],
        NetworkConfig.API_KEY_EMAIL: map['email'],
      }))
      .then((dynamic response) {
    print(response);
    return response;
  });

  static Future<dynamic> login(String phone, String password, String deviceType,
          String deviceToken) =>
      NetworkUtil()
          .post(
              url: NetworkEndpoints.LOGIN,
              hasHeader: false,
              token: "",
              formData: FormData.fromMap({
                NetworkConfig.API_KEY_PHONE: phone,
                NetworkConfig.API_KEY_PASSWORD: password,
                NetworkConfig.API_KEY_DEVICE_TYPE: deviceType,
                NetworkConfig.API_KEY_DEVICE_TOKEN: deviceToken
              }))
          .then((dynamic response) {
        print(response);
        return response;
      });

  static Future<dynamic> forgotPassword(Map<String, String> map) =>
      NetworkUtil().post(
          url: NetworkEndpoints.FORGOT_PASSWORD,
          hasHeader: false,
          token: null,
          formData: FormData.fromMap({
            NetworkConfig.API_KEY_PHONE: map['phone'],
          })
      ).then((dynamic response) {
        print(map['email']);
        //print(response);
        return response;
      });

  static Future<dynamic> resetPassword(Map<String, String> map) =>
      NetworkUtil().post(
          url: NetworkEndpoints.RESET_PASSWORD,
          hasHeader: false,
          token: null,
          formData: FormData.fromMap({
            NetworkConfig.API_KEY_PHONE: map['phone'],
            NetworkConfig.API_KEY_CODE: map['code'],
            NetworkConfig.API_KEY_PASSWORD: map['password'],
          })
      ).then((dynamic response) {
        print(map['email']);
        //print(response);
        return response;
      });

  static Future<dynamic> verifyOTP(Map<String, String> map) =>
      NetworkUtil().post(
          url: NetworkEndpoints.VERIFY_PHONE,
          hasHeader: false,
          token: null,
          formData: FormData.fromMap({
            NetworkConfig.API_KEY_PHONE: map['phone'],
            NetworkConfig.API_KEY_CODE: map['code'],
          })
      ).then((dynamic response) {

        print(map['code']);
        print(map['email']);
        //print(response);
        return response;
      });

}
