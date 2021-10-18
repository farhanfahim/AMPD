import 'dart:async';
import 'package:ampd/data/model/LikeDislikeModel.dart';
import 'package:ampd/data/model/OfferModel.dart';
import 'package:ampd/data/model/changePasswordModel.dart';
import 'package:ampd/data/model/repo_response_model.dart';
import 'package:ampd/data/model/verificationCodeToEmailModel.dart';
import 'package:ampd/data/network/nao/network_nao.dart';
import 'package:dio/dio.dart';
import 'package:ampd/app/app.dart';
import 'package:meta/meta.dart';
import 'package:ampd/data/database/app_preferences.dart';

class SettingsRepository {
  AppPreferences _appPreferences;
  var _repositoryResponse = StreamController<RepositoryResponse>.broadcast();

  factory SettingsRepository({@required AppPreferences appPreferences}) =>
      SettingsRepository._internal(appPreferences);

  SettingsRepository._internal(this._appPreferences);

  void updateSettings(Map<String, dynamic> map){
    var repositoryResponse = RepositoryResponse();

      repositoryResponse.success = true;
      repositoryResponse.msg = "User updated successfully!";
      repositoryResponse.data = 0;
      _repositoryResponse.add(repositoryResponse);
  }

  void logout(Map<String, dynamic> map){
    var repositoryResponse = RepositoryResponse();
    _appPreferences.clearPreference();
    repositoryResponse.success = true;
    repositoryResponse.msg = "Logged out successfully";
    repositoryResponse.data = null;
    _repositoryResponse.add(repositoryResponse);
  }

  Stream<RepositoryResponse> getRepositoryResponse() {
    return _repositoryResponse.stream;
  }
}