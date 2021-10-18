import 'dart:async';
import 'package:ampd/data/model/SavedCouponModel.dart';
import 'package:ampd/data/model/repo_response_model.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:meta/meta.dart';
import 'package:ampd/data/database/app_preferences.dart';

class ExpiredCouponRepository {
  AppPreferences _appPreferences;
  var _repositoryResponse = StreamController<RepositoryResponse>.broadcast();

  factory ExpiredCouponRepository({@required AppPreferences appPreferences}) =>
      ExpiredCouponRepository._internal(appPreferences);

  ExpiredCouponRepository._internal(this._appPreferences);

  void getSavedCoupons(Map<String, dynamic> map){
       DataClass dummySubData = DataClass(
      id: 35,
      userId: 91,
      title: "Triple Mocha Frappuccino",
      productName: "Starbucks Triple Mocha",
      type: 10,
      value: 25,
      expireAt: "2021-10-02 00:00:00",
      numberOfUses: 1,
      dislikeTime: 2,
      recurrenceTime: 2,
      availTime: 2,
      qrCode: "offers/1634021602832.png",
      redeemMessage: null,
      image: "offers/1634021602820.jpg",
      backgroundColor: "#067655",
      description: null,
      status: 20,
      createdAt: "2021-10-12 06:53:22",
      updatedAt: "2021-10-12 06:53:22",
      averageRating: "3.75",
      totalReviews: 6,
      imageUrl: AppImages.DUMMY_SAVED_OFFER_1,
      mediumImageUrl: AppImages.DUMMY_SAVED_OFFER_1,
      smallImageUrl: AppImages.DUMMY_SAVED_OFFER_1,
      qrUrl: "https://ampd.tekstaging.com/offers/1634021602832.png",

    );
    DataClass dummySubData1 = DataClass(
      id: 35,
      userId: 91,
      title: "Café Au Lait",
      productName: "Café Au Lait",
      type: 10,
      value: 25,
      expireAt: "2021-10-02 00:00:00",
      numberOfUses: 1,
      dislikeTime: 2,
      recurrenceTime: 2,
      availTime: 2,
      qrCode: "offers/1634021602832.png",
      redeemMessage: null,
      image: "offers/1634021602820.jpg",
      backgroundColor: "#067655",
      description: null,
      status: 20,
      createdAt: "2021-10-12 06:53:22",
      updatedAt: "2021-10-12 06:53:22",
      averageRating: "3.75",
      totalReviews: 6,
      imageUrl: AppImages.DUMMY_SAVED_OFFER_2,
      mediumImageUrl: AppImages.DUMMY_SAVED_OFFER_2,
      smallImageUrl: AppImages.DUMMY_SAVED_OFFER_2,
      qrUrl: "https://ampd.tekstaging.com/offers/1634021602832.png",

    );
    DataClass dummySubData2 = DataClass(
      id: 35,
      userId: 91,
      title: "Starbucks Coffee",
      productName: "Starbucks Coffee",
      type: 10,
      value: 25,
      expireAt: "2021-10-02 00:00:00",
      numberOfUses: 1,
      dislikeTime: 2,
      recurrenceTime: 2,
      availTime: 2,
      qrCode: "offers/1634021602832.png",
      redeemMessage: null,
      image: "offers/1634021602820.jpg",
      backgroundColor: "#067655",
      description: null,
      status: 20,
      createdAt: "2021-10-12 06:53:22",
      updatedAt: "2021-10-12 06:53:22",
      averageRating: "3.75",
      totalReviews: 6,
      imageUrl: AppImages.DUMMY_SAVED_OFFER_3,
      mediumImageUrl: AppImages.DUMMY_SAVED_OFFER_3,
      smallImageUrl: AppImages.DUMMY_SAVED_OFFER_3,
      qrUrl: "https://ampd.tekstaging.com/offers/1634021602832.png",

    );
    DataClass dummySubData3 = DataClass(
      id: 35,
      userId: 91,
      title: "Triple Mocha Frappuccino",
      productName: "Starbucks Triple Mocha",
      type: 10,
      value: 25,
      expireAt: "2021-10-02 00:00:00",
      numberOfUses: 1,
      dislikeTime: 2,
      recurrenceTime: 2,
      availTime: 2,
      qrCode: "offers/1634021602832.png",
      redeemMessage: null,
      image: "offers/1634021602820.jpg",
      backgroundColor: "#067655",
      description: null,
      status: 20,
      createdAt: "2021-10-12 06:53:22",
      updatedAt: "2021-10-12 06:53:22",
      averageRating: "3.75",
      totalReviews: 6,
      imageUrl: AppImages.DUMMY_SAVED_OFFER_1,
      mediumImageUrl: AppImages.DUMMY_SAVED_OFFER_1,
      smallImageUrl: AppImages.DUMMY_SAVED_OFFER_1,
      qrUrl: "https://ampd.tekstaging.com/offers/1634021602832.png",

    );
    DataClass dummySubData4 = DataClass(
      id: 35,
      userId: 91,
      title: "Café Au Lait",
      productName: "Café Au Lait",
      type: 10,
      value: 25,
      expireAt: "2021-10-02 00:00:00",
      numberOfUses: 1,
      dislikeTime: 2,
      recurrenceTime: 2,
      availTime: 2,
      qrCode: "offers/1634021602832.png",
      redeemMessage: null,
      image: "offers/1634021602820.jpg",
      backgroundColor: "#067655",
      description: null,
      status: 20,
      createdAt: "2021-10-12 06:53:22",
      updatedAt: "2021-10-12 06:53:22",
      averageRating: "3.75",
      totalReviews: 6,
      imageUrl: AppImages.DUMMY_SAVED_OFFER_2,
      mediumImageUrl: AppImages.DUMMY_SAVED_OFFER_2,
      smallImageUrl: AppImages.DUMMY_SAVED_OFFER_2,
      qrUrl: "https://ampd.tekstaging.com/offers/1634021602832.png",

    );
    DataClass dummySubData5 = DataClass(
      id: 35,
      userId: 91,
      title: "Starbucks Coffee",
      productName: "Starbucks Coffee",
      type: 10,
      value: 25,
      expireAt: "2021-10-02 00:00:00",
      numberOfUses: 1,
      dislikeTime: 2,
      recurrenceTime: 2,
      availTime: 2,
      qrCode: "offers/1634021602832.png",
      redeemMessage: null,
      image: "offers/1634021602820.jpg",
      backgroundColor: "#067655",
      description: null,
      status: 20,
      createdAt: "2021-10-12 06:53:22",
      updatedAt: "2021-10-12 06:53:22",
      averageRating: "3.75",
      totalReviews: 6,
      imageUrl: AppImages.DUMMY_SAVED_OFFER_3,
      mediumImageUrl: AppImages.DUMMY_SAVED_OFFER_3,
      smallImageUrl: AppImages.DUMMY_SAVED_OFFER_3,
      qrUrl: "https://ampd.tekstaging.com/offers/1634021602832.png",

    );

    List<DataClass> _listOfData = [dummySubData,dummySubData1,dummySubData2,dummySubData3,dummySubData4,dummySubData5];

    SavedCouponModel dummyData = SavedCouponModel(
        total: 4,
        perPage: 10,
        page: 1,
        lastPage: 1,
        dataClass: _listOfData
    );

    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = true;
    repositoryResponse.msg = "Offers fetched successfully!";
    repositoryResponse.data = dummyData;
    _repositoryResponse.add(repositoryResponse);
  }

  Stream<RepositoryResponse> getRepositoryResponse() {
    return _repositoryResponse.stream;
  }
}