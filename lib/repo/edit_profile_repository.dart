import 'dart:async';
import 'package:ampd/data/model/LikeDislikeModel.dart';
import 'package:ampd/data/model/OfferModel.dart';
import 'package:ampd/data/model/changePasswordModel.dart';
import 'package:ampd/data/model/login_response_model.dart';
import 'package:ampd/data/model/repo_response_model.dart';
import 'package:ampd/data/model/verificationCodeToEmailModel.dart';
import 'package:ampd/data/network/nao/network_nao.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:ampd/app/app.dart';
import 'package:ampd/data/database/app_preferences.dart';

class EditProfileRepository {
  AppPreferences _appPreferences;
  var _repositoryResponse = StreamController<RepositoryResponse>.broadcast();

  factory EditProfileRepository({@required AppPreferences appPreferences}) =>
      EditProfileRepository._internal(appPreferences);

  EditProfileRepository._internal(this._appPreferences);

  void verificationCodeToEmail(Map<String, dynamic> map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = false;
    _appPreferences.isPreferenceReady;
    _appPreferences.getAccessToken().then((value) {

      NetworkNAO.verificationCodeToEmail(value, map).then((response) async {
        final data = (response as Response<dynamic>).data;
        if (!data['status']) {
          repositoryResponse.success = false;
          repositoryResponse.msg = data['message'];
          repositoryResponse.data = null;
          _repositoryResponse.add(repositoryResponse);
        } else {
          var changePasswordResponse = VerficationCodeToEmailModel.fromJson(data);
          repositoryResponse.success = true;
          repositoryResponse.msg = data['message'];
          repositoryResponse.data = changePasswordResponse;
          _repositoryResponse.add(repositoryResponse);
        }
      }).catchError((onError) {
        if(onError is DioError){
          if (onError.response.statusCode == 401) {
            repositoryResponse.statusCode = 401;
          }
        }
        repositoryResponse.success = false;
        repositoryResponse.msg = onError.toString();
        repositoryResponse.data = onError;

        _repositoryResponse.add(repositoryResponse);
      });
    });
  }

  void changeEmail(Map<String, dynamic> map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = false;
    _appPreferences.isPreferenceReady;
    _appPreferences.getAccessToken().then((value) {

      NetworkNAO.changeEmail(value, map).then((response) async {
        final data = (response as Response<dynamic>).data;
        if (!data['status']) {
          repositoryResponse.success = false;
          repositoryResponse.msg = data['message'];
          repositoryResponse.data = null;
          _repositoryResponse.add(repositoryResponse);
        } else {
//          var changePasswordResponse = VerficationCodeToEmailModel.fromJson(data);
          repositoryResponse.success = true;
          repositoryResponse.msg = data['message'];
          repositoryResponse.data = 0;
          _repositoryResponse.add(repositoryResponse);
        }
      }).catchError((onError) async {
        if(onError is DioError){
          if (onError.response.statusCode == 401) {
            repositoryResponse.statusCode = 401;
            await App().getAppPreferences().isPreferenceReady;
            await App().getAppPreferences().clearPreference();
          }
        }
        repositoryResponse.success = false;
        repositoryResponse.msg = onError.toString();
        repositoryResponse.data = onError;

        _repositoryResponse.add(repositoryResponse);
      });
    });
  }

  void changePhone(Map<String, dynamic> map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = false;
    _appPreferences.isPreferenceReady;
    _appPreferences.getAccessToken().then((value) {

      NetworkNAO.changePhone(value, map).then((response) async {
        final data = (response as Response<dynamic>).data;
        if (!data['status']) {
          repositoryResponse.success = false;
          repositoryResponse.msg = data['message'];
          repositoryResponse.data = null;
          _repositoryResponse.add(repositoryResponse);
        } else {
//          var changePasswordResponse = VerficationCodeToEmailModel.fromJson(data);
          repositoryResponse.success = true;
          repositoryResponse.msg = data['message'];
          repositoryResponse.data = 0;
          _repositoryResponse.add(repositoryResponse);
        }
      }).catchError((onError) async {
        if(onError is DioError){
          if (onError.response.statusCode == 401) {
            repositoryResponse.statusCode = 401;
            await App().getAppPreferences().isPreferenceReady;
            await App().getAppPreferences().clearPreference();
          }
        }
        repositoryResponse.success = false;
        repositoryResponse.msg = onError.toString();
        repositoryResponse.data = onError;

        _repositoryResponse.add(repositoryResponse);
      });
    });
  }

  void verificationCodeToPhone(Map<String, dynamic> map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = false;
    _appPreferences.isPreferenceReady;
    _appPreferences.getAccessToken().then((value) {

      NetworkNAO.verificationCodeToPhone(value, map).then((response) async {
        final data = (response as Response<dynamic>).data;
        if (!data['status']) {
          repositoryResponse.success = false;
          repositoryResponse.msg = data['message'];
          repositoryResponse.data = null;
          _repositoryResponse.add(repositoryResponse);
        } else {
//          var changePasswordResponse = VerficationCodeToEmailModel.fromJson(data);
          repositoryResponse.success = true;
          repositoryResponse.msg = data['message'];
          repositoryResponse.data = 1;
          _repositoryResponse.add(repositoryResponse);
        }
      }).catchError((onError) async {
        if(onError is DioError){
          if (onError.response.statusCode == 401) {
            repositoryResponse.statusCode = 401;
            await App().getAppPreferences().isPreferenceReady;
            await App().getAppPreferences().clearPreference();
          }
        }
        repositoryResponse.success = false;
        repositoryResponse.msg = onError.toString();
        repositoryResponse.data = onError;

        _repositoryResponse.add(repositoryResponse);
      });
    });
  }

  void verifyEmailOtp(Map<String, dynamic> map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = false;
    _appPreferences.isPreferenceReady;
    _appPreferences.getAccessToken().then((value) {

      NetworkNAO.verifyEmailOtp(value, map).then((response) async {
        final data = (response as Response<dynamic>).data;
        if (!data['status']) {
          repositoryResponse.success = false;
          repositoryResponse.msg = data['message'];
          repositoryResponse.data = null;
          _repositoryResponse.add(repositoryResponse);
        } else {
//          var changePasswordResponse = VerficationCodeToEmailModel.fromJson(data);
          repositoryResponse.success = true;
          repositoryResponse.msg = data['message'];
          repositoryResponse.data = null;
          _repositoryResponse.add(repositoryResponse);
        }
      }).catchError((onError) async {
        if(onError is DioError){
          if (onError.response.statusCode == 401) {
            repositoryResponse.statusCode = 401;
            await App().getAppPreferences().isPreferenceReady;
            await App().getAppPreferences().clearPreference();
          }
        }
        repositoryResponse.success = false;
        repositoryResponse.msg = onError.toString();
        repositoryResponse.data = onError;

        _repositoryResponse.add(repositoryResponse);
      });
    });
  }

  void verifyPhoneOtp(Map<String, dynamic> map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = false;
    _appPreferences.isPreferenceReady;
    _appPreferences.getAccessToken().then((value) {

      NetworkNAO.verifyPhoneOtp(value, map).then((response) async {
        final data = (response as Response<dynamic>).data;
        if (!data['status']) {
          repositoryResponse.success = false;
          repositoryResponse.msg = data['message'];
          repositoryResponse.data = null;
          _repositoryResponse.add(repositoryResponse);
        } else {
//          var changePasswordResponse = VerficationCodeToEmailModel.fromJson(data);
          repositoryResponse.success = true;
          repositoryResponse.msg = data['message'];
          repositoryResponse.data = 2;
          _repositoryResponse.add(repositoryResponse);
        }
      }).catchError((onError) async {
        if(onError is DioError){
          if (onError.response.statusCode == 401) {
            repositoryResponse.statusCode = 401;
            await App().getAppPreferences().isPreferenceReady;
            await App().getAppPreferences().clearPreference();
          }
        }
        repositoryResponse.success = false;
        repositoryResponse.msg = onError.toString();
        repositoryResponse.data = onError;

        _repositoryResponse.add(repositoryResponse);
      });
    });
  }

  void updateProfile(Map<String, dynamic> map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = false;
    _appPreferences.isPreferenceReady;
    _appPreferences.getAccessToken().then((value) {

      NetworkNAO.updateProfile(value, map).then((response) async {
        final data = (response as Response<dynamic>).data;
        if (!data['status']) {
          repositoryResponse.success = false;
          repositoryResponse.msg = data['message'];
          repositoryResponse.data = null;
          _repositoryResponse.add(repositoryResponse);
        } else {
         var changePasswordResponse = LoginResponseModel.fromJson(data);
          repositoryResponse.success = true;
          repositoryResponse.msg = data['message'];
          repositoryResponse.data = changePasswordResponse;
          _repositoryResponse.add(repositoryResponse);
        }
      }).catchError((onError) async {
        if(onError is DioError){
          if (onError.response.statusCode == 401) {
            repositoryResponse.statusCode = 401;
            await App().getAppPreferences().isPreferenceReady;
            await App().getAppPreferences().clearPreference();
          }
        }
        repositoryResponse.success = false;
        repositoryResponse.msg = onError.toString();
        repositoryResponse.data = onError;

        _repositoryResponse.add(repositoryResponse);
      });
    });
  }
  void updateProfileWithRemoveImage(Map<String, dynamic> map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = false;
    _appPreferences.isPreferenceReady;
    _appPreferences.getAccessToken().then((value) {

      NetworkNAO.updateProfileWithRemoveImage(value, map).then((response) async {
        final data = (response as Response<dynamic>).data;
        if (!data['status']) {
          repositoryResponse.success = false;
          repositoryResponse.msg = data['message'];
          repositoryResponse.data = null;
          _repositoryResponse.add(repositoryResponse);
        } else {
          var changePasswordResponse = LoginResponseModel.fromJson(data);
          repositoryResponse.success = true;
          repositoryResponse.msg = data['message'];
          repositoryResponse.data = changePasswordResponse;
          _repositoryResponse.add(repositoryResponse);
        }
      }).catchError((onError) async {
        if(onError is DioError){
          if (onError.response.statusCode == 401) {
            repositoryResponse.statusCode = 401;
            await App().getAppPreferences().isPreferenceReady;
            await App().getAppPreferences().clearPreference();
          }
        }
        repositoryResponse.success = false;
        repositoryResponse.msg = onError.toString();
        repositoryResponse.data = onError;

        _repositoryResponse.add(repositoryResponse);
      });
    });
  }

  Stream<RepositoryResponse> getRepositoryResponse() {
    return _repositoryResponse.stream;
  }
}