import 'dart:async';
import 'dart:convert';
import 'package:ampd/data/model/login_response_model.dart';
import 'package:ampd/data/model/repo_response_model.dart';
import 'package:ampd/data/network/nao/network_nao.dart';
import 'package:dio/dio.dart';
import 'package:ampd/app/app.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:meta/meta.dart';
import 'package:ampd/data/database/app_preferences.dart';

class LoginRepository {
  AppPreferences _appPreferences;
  var _repositoryResponse = StreamController<RepositoryResponse>.broadcast();

  factory LoginRepository({@required AppPreferences appPreferences}) =>
      LoginRepository._internal(appPreferences);

  LoginRepository._internal(this._appPreferences);

  Future<void> login(Map map) async {
    var repositoryResponse = RepositoryResponse();

    AccessToken dummyToken = AccessToken(
      type : "bearer",
      token :"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEwMCwiaWF0IjoxNjM0NTQ2NTAzfQ.Vtj_vFW2vsaLkuRoVCT7MT_JmoIdz5tsV3tpvkZNbLc",
      refreshToken :"2831c15ab7f1f562557e9eaae9c352f3mqC1f/tq3rAFYvD64lpujl+yFG5QxU3yoVKsnr5UUIj6iBK3rrMpRj9JrQxm+bGQ",
    );

    Meta dummyMeta = Meta(rolesCsv : "User");

    Data dummyData = Data(
        id: 100,
        firstName : "Yusuf ",
        lastName : "Nahass",
        email : "Yusufnahass@email.com",
        phone: "+12063456545",
        image: null,
        address: null,
        latitude: null,
        longitude: null,
        pushNotifications :1,
        sortingAscending:1,
        nearestLocation:1,
        highestDiscountAmount:1,
        soonestExpiration:1,
        radius:0,
        socialPlatform: null,
        clientId: null,
        token: null,
        verificationCode: "0000",
        isSocialLogin:1,
        isVerified:1,
        isApproved:0,
        createdAt : "2021-08-24 00:34:51",
        updatedAt: "2021-08-24 00:34:51",
        accessToken: dummyToken,
        imageUrl : "https://res.cloudinary.com/crunchbase-production/image/upload/c_thumb,h_170,w_170,f_auto,g_faces,z_0.7,b_white,q_auto:eco,dpr_1/v1425465847/ffllgzbmsh1u6bfdkyow.jpg",
        mediumImageUrl : "https://res.cloudinary.com/crunchbase-production/image/upload/c_thumb,h_170,w_170,f_auto,g_faces,z_0.7,b_white,q_auto:eco,dpr_1/v1425465847/ffllgzbmsh1u6bfdkyow.jpg",
        smallImageUrl :"https://res.cloudinary.com/crunchbase-production/image/upload/c_thumb,h_170,w_170,f_auto,g_faces,z_0.7,b_white,q_auto:eco,dpr_1/v1425465847/ffllgzbmsh1u6bfdkyow.jpg",
        mMeta: dummyMeta);

    var loginResponse = LoginResponseModel(status:true,data: dummyData,message: "Login Successfully.");

    await _appPreferences.isPreferenceReady;
    _appPreferences.setUserId(id: loginResponse.data.id.toString());
    _appPreferences.setUserDetails(data: jsonEncode(loginResponse));
    _appPreferences.setFcmToken(token: map['device_token']);
    _appPreferences.setAccessToken(token: loginResponse.data.accessToken.token);

    repositoryResponse.success = true;
    repositoryResponse.msg = loginResponse.message;
    repositoryResponse.data = loginResponse;
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

  void verifyOtp(Map map){
    var repositoryResponse = RepositoryResponse();

    repositoryResponse.success = true;
    repositoryResponse.msg = "Verified";
    repositoryResponse.data = null;
    _repositoryResponse.add(repositoryResponse);
  }

  void registerViaPhone(Map map){
    var repositoryResponse = RepositoryResponse();

    repositoryResponse.success = true;
    repositoryResponse.msg = "Code has been sent to your phone number";
    repositoryResponse.data = null;
    _repositoryResponse.add(repositoryResponse);
  }


  Stream<RepositoryResponse> getRepositoryResponse() {
    return _repositoryResponse.stream;
  }
}