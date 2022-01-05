import 'dart:async';
import 'dart:convert';
import 'package:ampd/data/model/login_response_model.dart';
import 'package:ampd/data/model/repo_response_model.dart';
import 'package:ampd/data/network/nao/network_nao.dart';
import 'package:dio/dio.dart';
import 'package:ampd/app/app.dart';
import 'package:meta/meta.dart';
import 'package:ampd/data/database/app_preferences.dart';

class LoginRepository {
  AppPreferences _appPreferences;
  var _repositoryResponse = StreamController<RepositoryResponse>.broadcast();

  factory LoginRepository({@required AppPreferences appPreferences}) =>
      LoginRepository._internal(appPreferences);

  LoginRepository._internal(this._appPreferences);

  void login(Map map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = false;

    NetworkNAO.login(map)
        .then((response) async {
      final data = (response as Response<dynamic>).data;
      if(!data['status']) {
        repositoryResponse.success = false;
        repositoryResponse.msg = data['message'];
        repositoryResponse.data = null;
        _repositoryResponse.add(repositoryResponse);
      } else {
        var loginResponse = LoginResponseModel.fromJson(data);

        await _appPreferences.isPreferenceReady;
        _appPreferences.setUserId(id: loginResponse.data.id.toString());
        _appPreferences.setUserDetails(data: jsonEncode(loginResponse));
        _appPreferences.setFcmToken(token: map['device_token']);
        _appPreferences.setAccessToken(token: loginResponse.data.accessToken.token);

        repositoryResponse.success = true;
        repositoryResponse.msg = data['message'];
        repositoryResponse.data = loginResponse;
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
  }

  void forgetPassword(Map map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = false;

    NetworkNAO.forgotPassword(map)
        .then((response) async {
      final data = (response as Response<dynamic>).data;
      if(!data['status']) {
        repositoryResponse.success = false;
        repositoryResponse.msg = data['message'];
        repositoryResponse.data = null;
        _repositoryResponse.add(repositoryResponse);
      } else {
        //  var loginResponse = LoginResponse.fromJson(data);

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
  }

  void resetPassword(Map map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = false;

    NetworkNAO.resetPassword(map)
        .then((response) async {
      final data = (response as Response<dynamic>).data;
      if(!data['status']) {
        repositoryResponse.success = false;
        repositoryResponse.msg = data['message'];
        repositoryResponse.data = null;
        _repositoryResponse.add(repositoryResponse);
      } else {
        //  var loginResponse = LoginResponse.fromJson(data);

        repositoryResponse.success = true;
        repositoryResponse.msg = data['message'];
        repositoryResponse.data = null;
        _repositoryResponse.add(repositoryResponse);
      }
    }).catchError((onError) {
      repositoryResponse.success = false;
      repositoryResponse.msg = onError.toString();
      repositoryResponse.data = onError;

      _repositoryResponse.add(repositoryResponse);
    });
  }

  void verifyOtp(Map map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = false;

    NetworkNAO.verifyOTP(map)
        .then((response) async {
      final data = (response as Response<dynamic>).data;
      if(!data['status']) {
        repositoryResponse.success = false;
        repositoryResponse.msg = data['message'];
        repositoryResponse.data = null;
        _repositoryResponse.add(repositoryResponse);
      } else {
        //  var loginResponse = LoginResponse.fromJson(data);

        repositoryResponse.success = true;
        repositoryResponse.msg = data['message'];
        repositoryResponse.data = null;
        _repositoryResponse.add(repositoryResponse);
      }
    }).catchError((onError) {
      repositoryResponse.success = false;
      repositoryResponse.msg = onError.toString();
      repositoryResponse.data = onError;

      _repositoryResponse.add(repositoryResponse);
    });
  }

  void registerViaPhone(Map map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = false;

    NetworkNAO.signUpViaPhone(map)
        .then((response) async {
      final data = (response as Response<dynamic>).data;
      if(!data['status']) {
        repositoryResponse.success = false;
        repositoryResponse.msg = data['message'];
        repositoryResponse.data = null;
        _repositoryResponse.add(repositoryResponse);
      } else {
        //  var loginResponse = LoginResponse.fromJson(data);

        repositoryResponse.success = true;
        repositoryResponse.msg = data['message'];
        repositoryResponse.data = null;
        _repositoryResponse.add(repositoryResponse);
      }
    }).catchError((onError) {
      repositoryResponse.success = false;
      repositoryResponse.msg = onError.toString();
      repositoryResponse.data = onError;

      _repositoryResponse.add(repositoryResponse);
    });
  }


  Stream<RepositoryResponse> getRepositoryResponse() {
    return _repositoryResponse.stream;
  }
}
