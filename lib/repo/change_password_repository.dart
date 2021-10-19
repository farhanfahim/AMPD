import 'dart:async';
import 'package:ampd/data/model/LikeDislikeModel.dart';
import 'package:ampd/data/model/OfferModel.dart';
import 'package:ampd/data/model/changePasswordModel.dart';
import 'package:ampd/data/model/repo_response_model.dart';
import 'package:ampd/data/network/nao/network_nao.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:ampd/app/app.dart';
import 'package:ampd/data/database/app_preferences.dart';

class ChangePasswordRepository {
  AppPreferences _appPreferences;
  var _repositoryResponse = StreamController<RepositoryResponse>.broadcast();

  factory ChangePasswordRepository({@required AppPreferences appPreferences}) =>
      ChangePasswordRepository._internal(appPreferences);

  ChangePasswordRepository._internal(this._appPreferences);

  void changePassword(Map<String, dynamic> map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = true;
    repositoryResponse.msg = "Password has been Changed Successfully";
    repositoryResponse.data = null;
    _repositoryResponse.add(repositoryResponse);
  }

  void forgetPassword(Map map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = true;
    repositoryResponse.msg = "Verification code has been send successfully";
    repositoryResponse.data = null;
    _repositoryResponse.add(repositoryResponse);
  }

  void resetPassword(Map map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = true;
    repositoryResponse.msg = "Password Changed Successfully";
    repositoryResponse.data = null;
    _repositoryResponse.add(repositoryResponse);
  }

  Stream<RepositoryResponse> getRepositoryResponse() {
    return _repositoryResponse.stream;
  }
}