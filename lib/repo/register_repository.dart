import 'dart:async';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/data/model/register_response_model.dart';
import 'package:ampd/data/model/repo_response_model.dart';
import 'package:ampd/data/network/nao/network_nao.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:ampd/app/app.dart';
import 'package:ampd/data/database/app_preferences.dart';

class RegisterRepository {
  AppPreferences _appPreferences;
  var _repositoryResponse = StreamController<RepositoryResponse>.broadcast();

  factory RegisterRepository({@required AppPreferences appPreferences}) =>
      RegisterRepository._internal(appPreferences);

  RegisterRepository._internal(this._appPreferences);


  void register(Map map){



    AccessToken dummyToken = AccessToken(
      type : "bearer",
      token :"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEwMCwiaWF0IjoxNjM0NTQ2NTAzfQ.Vtj_vFW2vsaLkuRoVCT7MT_JmoIdz5tsV3tpvkZNbLc",
      refreshToken :"2831c15ab7f1f562557e9eaae9c352f3mqC1f/tq3rAFYvD64lpujl+yFG5QxU3yoVKsnr5UUIj6iBK3rrMpRj9JrQxm+bGQ",
    );

    Data dummyData = Data(

        firstName : "Yusuf ",
        lastName : "Nahass",
        email : "Yusufnahass@email.com",
        phone: "(800) 362-9239",
        id: 100,
        radius: 100,
        isVerified:1,
        isApproved:1,
        createdAt : "2021-08-24 00:34:51",
        updatedAt: "2021-08-24 00:34:51",
        accessToken: dummyToken,
        imageUrl : AppImages.DUMMY_PROFILE,);


    var registerResponse = RegisterResponseModel(status:true,data: dummyData,message: "Registered Successfully.");

    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = true;
    repositoryResponse.msg = registerResponse.message;
    repositoryResponse.data = registerResponse;
    _repositoryResponse.add(repositoryResponse);
  }

  void registerViaPhone(Map map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = true;
    repositoryResponse.msg = "Code has been sent to your phone number";
    repositoryResponse.data = null;
    _repositoryResponse.add(repositoryResponse);
  }

  void verifyOtp(Map map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = false;


    repositoryResponse.success = true;
    repositoryResponse.msg = "Verified";
    repositoryResponse.data = null;
    _repositoryResponse.add(repositoryResponse);
  }

  Stream<RepositoryResponse> getRepositoryResponse() {
    return _repositoryResponse.stream;
  }
}