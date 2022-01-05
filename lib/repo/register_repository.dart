import 'dart:async';
import 'package:ampd/data/model/register_response_model.dart';
import 'package:ampd/data/model/repo_response_model.dart';
import 'package:ampd/data/network/nao/network_nao.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:ampd/app/app.dart';
import 'package:ampd/data/database/app_preferences.dart';

class RegisterRepository {
  AppPreferences _appPreferences;
  var _repositoryResponse = StreamController<RepositoryResponse>.broadcast();

  factory RegisterRepository({@required AppPreferences appPreferences}) =>
      RegisterRepository._internal(appPreferences);

  RegisterRepository._internal(this._appPreferences);

  void register(Map map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = false;

    NetworkNAO.signUp(map)
        .then((response) async {
      final data = (response as Response<dynamic>).data;
      if(!data['status']) {
        repositoryResponse.success = false;
        repositoryResponse.msg = data['message'];
        repositoryResponse.data = null;
        _repositoryResponse.add(repositoryResponse);
      } else {
        var registerResponse = RegisterResponseModel.fromJson(data);
        repositoryResponse.success = true;
        repositoryResponse.msg = data['message'];
        repositoryResponse.data = registerResponse;
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

  Stream<RepositoryResponse> getRepositoryResponse() {
    return _repositoryResponse.stream;
  }
}
