import 'dart:async';
import 'dart:convert';
import 'package:ampd/data/model/OfferModel.dart';
import 'package:ampd/data/model/login_response_model.dart';
import 'package:ampd/data/model/register_response_model.dart';
import 'package:ampd/data/model/repo_response_model.dart';
import 'package:ampd/data/network/nao/network_nao.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:ampd/data/database/app_preferences.dart';

class HomeRepository {
  AppPreferences _appPreferences;
  var _repositoryResponse = StreamController<RepositoryResponse>.broadcast();

  factory HomeRepository({@required AppPreferences appPreferences}) =>
      HomeRepository._internal(appPreferences);

  HomeRepository._internal(this._appPreferences);

  void offers(Map map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = false;

    NetworkNAO.getOffers(map)
        .then((response) async {
      final data = (response as Response<dynamic>).data;
      if(!data['status']) {
        repositoryResponse.success = false;
        repositoryResponse.msg = data['message'];
        repositoryResponse.data = null;
        _repositoryResponse.add(repositoryResponse);
      } else {
        var offerResponse = OfferModel.fromJson(data);
        repositoryResponse.success = true;
        repositoryResponse.msg = data['message'];
        repositoryResponse.data = offerResponse;
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