import 'dart:async';
import 'dart:convert';
import 'package:ampd/data/model/login_response.dart';
import 'package:ampd/data/model/repo_response_model.dart';
import 'package:ampd/data/network/nao/network_nao.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:ampd/data/database/app_preferences.dart';

class RegisterViaPhoneRepository {
  AppPreferences _appPreferences;
  var _repositoryResponse = StreamController<RepositoryResponse>.broadcast();

  factory RegisterViaPhoneRepository({@required AppPreferences appPreferences}) =>
      RegisterViaPhoneRepository._internal(appPreferences);

  RegisterViaPhoneRepository._internal(this._appPreferences);

  void registerViaPhone(Map map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = false;

    NetworkNAO.signUpViaPhone(map)
        .then((response) async {
      final data = (response as Response<dynamic>).data;
      if(!data['success']) {
        repositoryResponse.success = false;
        repositoryResponse.msg = data['message'];
        repositoryResponse.data = null;
        _repositoryResponse.add(repositoryResponse);
      } else {
        var loginResponse = LoginResponse.fromJson(data);

        repositoryResponse.success = true;
        repositoryResponse.msg = data['message'];
        repositoryResponse.data = loginResponse;
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