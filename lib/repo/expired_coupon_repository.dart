import 'dart:async';
import 'package:ampd/data/model/LikeDislikeModel.dart';
import 'package:ampd/data/model/OfferModel.dart';
import 'package:ampd/data/model/SavedCouponModel.dart';
import 'package:ampd/data/model/repo_response_model.dart';
import 'package:ampd/data/network/nao/network_nao.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:ampd/data/database/app_preferences.dart';

class ExpiredCouponRepository {
  AppPreferences _appPreferences;
  var _repositoryResponse = StreamController<RepositoryResponse>.broadcast();

  factory ExpiredCouponRepository({@required AppPreferences appPreferences}) =>
      ExpiredCouponRepository._internal(appPreferences);

  ExpiredCouponRepository._internal(this._appPreferences);

  void getSavedCoupons(Map<String, dynamic> map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = false;
    _appPreferences.isPreferenceReady;
    _appPreferences.getAccessToken().then((value) {

      NetworkNAO.getSavedOffers(value, map).then((response) async {
        final data = (response as Response<dynamic>).data;
        if (!data['status']) {
          repositoryResponse.success = false;
          repositoryResponse.msg = data['message'];
          repositoryResponse.data = null;
          _repositoryResponse.add(repositoryResponse);
        } else {
          var savedCouponResponse = SavedCouponModel.fromJson(data['data']);
          print("saved ${savedCouponResponse.toJson()}");
          repositoryResponse.success = true;
          repositoryResponse.msg = data['message'];
          repositoryResponse.data = savedCouponResponse;
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