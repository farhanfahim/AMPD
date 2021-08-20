import 'dart:async';
import 'dart:convert';
import 'package:ampd/data/model/login_response.dart';
import 'package:ampd/data/model/repo_response_model.dart';
import 'package:ampd/data/network/nao/network_nao.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
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
      if(!data['success']) {
        repositoryResponse.success = false;
        repositoryResponse.msg = data['message'];
        repositoryResponse.data = null;
        _repositoryResponse.add(repositoryResponse);
      } else {
        var loginResponse = LoginResponse.fromJson(data['data']['user']);
        var isVeridied = data['data']['is_verified'];
        print(isVeridied);

        if(isVeridied == 1) {
          await _appPreferences.isPreferenceReady;
          _appPreferences.setUserDetails(data: jsonEncode(loginResponse));
          _appPreferences.setFcmToken(token: map['device_token']);
          _appPreferences.setAccessToken(token: loginResponse.accessToken);
          print(isVeridied);

          // FirestoreController.instance.saveUserData(loginResponse);

          if(loginResponse.details.store_id == null){
            print("nulllllllllllll");
            _appPreferences.setStoreId(id: '0');
          }else{
            print(" notttt nulllllllllllll");
            _appPreferences.setStoreId(id: loginResponse.details.store_id.toString());
          }
          repositoryResponse.success = true;
          repositoryResponse.msg = data['message'];
          repositoryResponse.data = loginResponse;
          repositoryResponse.userVerified = 1;
          _repositoryResponse.add(repositoryResponse);
        } else {
          repositoryResponse.success = true;
          repositoryResponse.msg = data['message'];
          repositoryResponse.data = null;
          repositoryResponse.userVerified = 0;
          _repositoryResponse.add(repositoryResponse);
        }
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