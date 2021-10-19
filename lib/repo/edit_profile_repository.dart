import 'dart:async';
import 'package:ampd/data/model/LikeDislikeModel.dart';
import 'package:ampd/data/model/OfferModel.dart';
import 'package:ampd/data/model/changePasswordModel.dart';
import 'package:ampd/data/model/login_response_model.dart';
import 'package:ampd/data/model/repo_response_model.dart';
import 'package:ampd/data/model/verificationCodeToEmailModel.dart';
import 'package:ampd/data/network/nao/network_nao.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:ampd/app/app.dart';
import 'package:ampd/data/database/app_preferences.dart';

class EditProfileRepository {
  AppPreferences _appPreferences;
  var _repositoryResponse = StreamController<RepositoryResponse>.broadcast();

  factory EditProfileRepository({@required AppPreferences appPreferences}) =>
      EditProfileRepository._internal(appPreferences);

  EditProfileRepository._internal(this._appPreferences);

  void verificationCodeToEmail(Map<String, dynamic> map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = true;
    repositoryResponse.msg = "Code has been sent to your email";
    repositoryResponse.data = 3;
    _repositoryResponse.add(repositoryResponse);
  }
  void verifyEmailOtp(Map<String, dynamic> map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = true;
    repositoryResponse.msg = "Verified";
    repositoryResponse.data = null;
    _repositoryResponse.add(repositoryResponse);
  }
  void changeEmail(Map<String, dynamic> map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = true;
    repositoryResponse.msg = "Email address updated successfully!";
    repositoryResponse.data = 0;
    _repositoryResponse.add(repositoryResponse);
  }




  void verificationCodeToPhone(Map<String, dynamic> map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = true;
    repositoryResponse.msg = "Code has been sent to your phone number";
    repositoryResponse.data = 1;
    _repositoryResponse.add(repositoryResponse);
  }
  void verifyPhoneOtp(Map<String, dynamic> map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = true;
    repositoryResponse.msg = "Verified";
    repositoryResponse.data = 2;
    _repositoryResponse.add(repositoryResponse);
  }
  void changePhone(Map<String, dynamic> map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = true;
    repositoryResponse.msg = "Phone number updated successfully!";
    repositoryResponse.data = 0;
    _repositoryResponse.add(repositoryResponse);
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
         var changePasswordResponse = LoginResponseModel.fromJson(data);
          repositoryResponse.success = true;
          repositoryResponse.msg = data['message'];
          repositoryResponse.data = changePasswordResponse;
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
  void updateProfileWithRemoveImage(Map<String, dynamic> map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = false;
    _appPreferences.isPreferenceReady;
    _appPreferences.getAccessToken().then((value) {

      NetworkNAO.updateProfileWithRemoveImage(value, map).then((response) async {
        final data = (response as Response<dynamic>).data;
        if (!data['status']) {
          repositoryResponse.success = false;
          repositoryResponse.msg = data['message'];
          repositoryResponse.data = null;
          _repositoryResponse.add(repositoryResponse);
        } else {
          var changePasswordResponse = LoginResponseModel.fromJson(data);
          repositoryResponse.success = true;
          repositoryResponse.msg = data['message'];
          repositoryResponse.data = changePasswordResponse;
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

  Stream<RepositoryResponse> getRepositoryResponse() {
    return _repositoryResponse.stream;
  }
}

