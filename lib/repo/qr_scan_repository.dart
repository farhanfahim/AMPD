import 'dart:async';

import 'package:ampd/data/model/repo_response_model.dart';
import 'package:ampd/data/network/nao/network_nao.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:ampd/data/database/app_preferences.dart';

class QrScanRepository {
  AppPreferences _appPreferences;
  var _repositoryResponse = StreamController<RepositoryResponse>.broadcast();

  factory QrScanRepository({@required AppPreferences appPreferences}) =>
      QrScanRepository._internal(appPreferences);

  QrScanRepository._internal(this._appPreferences);

  void offerReview(Map map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = false;
    _appPreferences.getAccessToken().then((value) {
    NetworkNAO.offerReview(value,map)
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
  });}


  Stream<RepositoryResponse> getRepositoryResponse() {
    return _repositoryResponse.stream;
  }
}