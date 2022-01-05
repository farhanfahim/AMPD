import 'dart:async';
import 'package:ampd/app/app.dart';

import 'package:ampd/data/model/repo_response_model.dart';
import 'package:ampd/data/network/nao/network_nao.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:ampd/data/database/app_preferences.dart';

class FilterRepository {
  AppPreferences _appPreferences;
  var _repositoryResponse = StreamController<RepositoryResponse>.broadcast();

  factory FilterRepository({@required AppPreferences appPreferences}) =>
      FilterRepository._internal(appPreferences);

  FilterRepository._internal(this._appPreferences);


  Stream<RepositoryResponse> getRepositoryResponse() {
    return _repositoryResponse.stream;
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
}
