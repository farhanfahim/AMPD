import 'dart:async';
import 'package:ampd/data/model/LikeDislikeModel.dart';
import 'package:ampd/data/model/OffeReviewsModel.dart';
import 'package:ampd/data/model/OfferModel.dart';
import 'package:ampd/data/model/PageModel.dart';
import 'package:ampd/data/model/RedeemOfferModel.dart';
import 'package:ampd/data/model/repo_response_model.dart';
import 'package:ampd/data/network/nao/network_nao.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:ampd/data/database/app_preferences.dart';

class AboutRepository {
  AppPreferences _appPreferences;
  var _repositoryResponse = StreamController<RepositoryResponse>.broadcast();

  factory AboutRepository({@required AppPreferences appPreferences}) =>
      AboutRepository._internal(appPreferences);

  AboutRepository._internal(this._appPreferences);


  void getPage(Map<String, dynamic> map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = false;
    _appPreferences.isPreferenceReady;
    _appPreferences.getAccessToken().then((value) {

      NetworkNAO.getAboutPage(value, map).then((response) async {
        final data = (response as Response<dynamic>).data;
        if (!data['status']) {
          repositoryResponse.success = false;
          repositoryResponse.msg = data['message'];
          repositoryResponse.data = null;
          _repositoryResponse.add(repositoryResponse);
        } else {

          var pageResponse = PageModel.fromJson(data['data']);
          repositoryResponse.success = true;
          repositoryResponse.msg = data['message'];
          repositoryResponse.data = pageResponse;
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

  Stream<RepositoryResponse> getRepositoryResponse() {
    return _repositoryResponse.stream;
  }
}