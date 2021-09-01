
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
        NetworkConfig.API_KEY_FIRST_NAME: map['first_name'],
        NetworkConfig.API_KEY_LAST_NAME: map['last_name'],
        NetworkConfig.API_KEY_PHONE: map['phone'],
        NetworkConfig.API_KEY_PASSWORD: map['password'],
        NetworkConfig.API_KEY_DEVICE_TYPE: map['device_type'],
        NetworkConfig.API_KEY_DEVICE_TOKEN: map['device_token'],
        NetworkConfig.API_KEY_EMAIL: map['email'],
      }))
      .then((dynamic response) {
    print(response);
    return response;
  });

  static Future<dynamic> login(Map map) =>
      NetworkUtil()
          .post(
              url: NetworkEndpoints.LOGIN,
              hasHeader: false,
              token: "",
              formData: FormData.fromMap({
                NetworkConfig.API_KEY_PHONE: map['phone'],
                NetworkConfig.API_KEY_PASSWORD: map['password'],
                NetworkConfig.API_KEY_DEVICE_TYPE: map['device_type'],
                NetworkConfig.API_KEY_DEVICE_TOKEN: map['device_token'],
              }))
          .then((dynamic response) {
        print(response);
        return response;
      });

  static Future<dynamic> forgotPassword(Map map) =>
      NetworkUtil().post(
          url: NetworkEndpoints.FORGOT_PASSWORD,
          hasHeader: false,
          token: null,
          formData: FormData.fromMap({
            NetworkConfig.API_KEY_PHONE: map['phone'],
          })
      ).then((dynamic response) {
        print(map['phone']);
        //print(response);
        return response;
      });

  static Future<dynamic> resetPassword(Map map) =>
      NetworkUtil().post(
          url: NetworkEndpoints.RESET_PASSWORD,
          hasHeader: false,
          token: null,
          formData: FormData.fromMap({
            NetworkConfig.API_KEY_PHONE: map['phone'],
            NetworkConfig.API_KEY_VERIFICATION_CODE: map['verification_code'],
            NetworkConfig.API_KEY_PASSWORD: map['password'],
          })
      ).then((dynamic response) {
        print(map['phone']);
        print(map['verification_code']);
        print(map['password']);
        //print(response);
        return response;
      });

  static Future<dynamic> verifyOTP(Map map) =>
      NetworkUtil().post(
          url: NetworkEndpoints.VERIFY_PHONE,
          hasHeader: false,
          token: null,
          formData: FormData.fromMap({
            NetworkConfig.API_KEY_PHONE: map['phone'],
            NetworkConfig.API_KEY_CODE: map['code'],
          })
      ).then((dynamic response) {

        print(map['phone']);
        print(map['code']);
        //print(response);
        return response;
      });


  static Future<dynamic> getOffers(String accessToken,Map<String, dynamic> map) =>
      NetworkUtil().get(
        url: NetworkEndpoints.OFFERS,
        hasHeader: true,
        token: accessToken,
        map: map
      ).then((dynamic response) {
        print(response);
        return response;
      });

  static Future<dynamic> getRedeemOffers(String accessToken,Map<String, dynamic> map,int id) =>
      NetworkUtil().get(
          url: NetworkEndpoints.OFFERS+"/"+id.toString(),
          hasHeader: true,
          token: accessToken,
          map: map
      ).then((dynamic response) {
        print(response);
        return response;
      });


  static Future<dynamic> getSavedOffers(String accessToken,Map<String, dynamic> map) =>
      NetworkUtil().get(
          url: NetworkEndpoints.SAVED_OFFERS,
          hasHeader: true,
          token: accessToken,
          map: map
      ).then((dynamic response) {
        print(response);
        return response;
      });



  static Future<dynamic> likeDislikeApi(String accessToken,Map map) =>
      NetworkUtil().post(
          url: NetworkEndpoints.OFFERS_LIKE_DISLIKE,
          hasHeader: false,
          token: accessToken,
          formData: FormData.fromMap({
            NetworkConfig.API_OFFER_ID: map['offer_id'],
            NetworkConfig.API_OFFER_STATUS: map['status'],
          })
      ).then((dynamic response) {

        print(map['offer_id']);
        print(map['status']);
        //print(response);
        return response;
      });

  static Future<dynamic> changePassword(String accessToken,Map map) =>
      NetworkUtil().post(
          url: NetworkEndpoints.CHANGE_PASSWORD,
          hasHeader: true,
          token: accessToken,
          formData: FormData.fromMap({
            NetworkConfig.API_KEY_CURRENT_PASSWORD: map['current_password'],
            NetworkConfig.API_KEY_PASSWORD: map['password'],
          })
      ).then((dynamic response) {
        //print(response);
        return response;
      });

  static Future<dynamic> verificationCodeToEmail(String accessToken,Map map) =>
      NetworkUtil().post(
          url: NetworkEndpoints.VERIFIFCATION_CODE_TO_EMAIL,
          hasHeader: true,
          token: accessToken,
          formData: FormData.fromMap({
            NetworkConfig.API_KEY_CURRENT_PASSWORD: map['email'],
          })
      ).then((dynamic response) {
        //print(response);
        return response;
      });

  static Future<dynamic> verificationCodeToPhone(String accessToken,Map map) =>
      NetworkUtil().post(
          url: NetworkEndpoints.VERIFIFCATION_CODE_TO_PHONE,
          hasHeader: true,
          token: accessToken,
          formData: FormData.fromMap({
            NetworkConfig.API_KEY_CURRENT_PASSWORD: map['phone'],
          })
      ).then((dynamic response) {
        //print(response);
        return response;
      });

}
