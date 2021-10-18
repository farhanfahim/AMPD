import 'dart:async';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/data/model/LikeDislikeModel.dart';
import 'package:ampd/data/model/OffeReviewsModel.dart';
import 'package:ampd/data/model/OfferDataClassModel.dart';
import 'package:ampd/data/model/OfferModel.dart';
import 'package:ampd/data/model/RedeemOfferModel.dart';
import 'package:ampd/data/model/repo_response_model.dart';
import 'package:ampd/data/network/nao/network_nao.dart';
import 'package:dio/dio.dart';
import 'package:ampd/app/app.dart';
import 'package:meta/meta.dart';
import 'package:ampd/data/database/app_preferences.dart';

class HomeRepository {
  AppPreferences _appPreferences;
  var _repositoryResponse = StreamController<RepositoryResponse>.broadcast();

  factory HomeRepository({@required AppPreferences appPreferences}) =>
      HomeRepository._internal(appPreferences);

  HomeRepository._internal(this._appPreferences);

  void offers(Map<String, dynamic> map){
    var repositoryResponse = RepositoryResponse();

    User dummyUser = User(
        id: 91,
        address: "39899 Balentine Drive",
        phone: "03456678669",
        image: "users/1628087466728.png",
        latitude: "24.90300813260006",
        longitude: "67.01836125592482",
        radius: 100,
        imageUrl: "https://ampd.tekstaging.com/users/1628087466728.png",
        mediumImageUrl: "https://ampd.tekstaging.com/users/medium_1628087466728.png",
        smallImageUrl: "https://ampd.tekstaging.com/users/small_1628087466728.png"
    );

    ReviewUser dummyReviewUser1 = ReviewUser(
      id: 182,
      firstName: "Mark",
      lastName: "Smith",
      image: null,
      imageUrl: AppImages.DUMMY_REVIEW_PROFILE,
      mediumImageUrl: AppImages.DUMMY_REVIEW_PROFILE,
      smallImageUrl: AppImages.DUMMY_REVIEW_PROFILE,
    );


    ReviewUser dummyReviewUser2 = ReviewUser(
      id: 182,
      firstName: "John",
      lastName: "Doe",
      image: null,
      imageUrl: AppImages.DUMMY_REVIEW_PROFILE,
      mediumImageUrl: AppImages.DUMMY_REVIEW_PROFILE,
      smallImageUrl: AppImages.DUMMY_REVIEW_PROFILE,
    );

    ReviewsData dummyReview1 = ReviewsData(
        id: 100,
        offerId: 34,
        userId: 182,
        review: "Sed ut perspiciatis unde omnis iste natus error sit volup tatem accus antiudm dolasor emque laudan tb eatae vitaae suant explicabo.",
        rating: "4.8",
        status: 10,
        createdAt: "2021-10-07 07:45:52",
        updatedAt: "2021-10-07 07:45:52",
        user: dummyReviewUser1
    );
    ReviewsData dummyReview2 = ReviewsData(
        id: 100,
        offerId: 34,
        userId: 182,
        review: "Sed ut perspiciatis unde omnis iste natus error sit volup tatem accus antiudm dolasor emque laudan tb eatae vitaae suant explicabo.",
        rating: "4.8",
        status: 10,
        createdAt: "2021-10-07 07:45:52",
        updatedAt: "2021-10-07 07:45:52",
        user: dummyReviewUser2
    );
    Store dummyStore = Store(
        id: 6,
        userId: 91,
        name: "Starbucks",
        about: "Starbucks Corporation is an American multinational chain of coffeehouses and roastery reserves headquartered in Seattle, Washington. As the world's largest coffeehouse chain, Starbucks is seen to be the main representation of the United States' second wave of coffee culture.\r\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\r\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\r\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\r\n\r\n",
        openingTime: "09:00:00",
        closingTime: "17:00:00"
    );

    List<ReviewsData> listOfReview = [dummyReview1,dummyReview2,dummyReview2,dummyReview2,dummyReview2];
    Meta dummyMeta = Meta(isReviewed : 0);
    Dataclass dummySubData = Dataclass(
      id: 35,
      userId: 91,
      title: "Triple Mocha Frappuccino",
      productName: "Starbucks Triple Mocha",
      type: 10,
      value: 25,
      expireAt: "2021-10-21 00:00:00",
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
      imageUrl: AppImages.DUMMY_OFFER_IMAGE,
      mediumImageUrl: AppImages.DUMMY_OFFER_IMAGE,
      smallImageUrl: AppImages.DUMMY_OFFER_IMAGE,
      qrUrl: "https://ampd.tekstaging.com/offers/1634021602832.png",
      user: dummyUser,
      store: dummyStore,
      reviews: listOfReview,
      mMeta: dummyMeta
    );
    List<Dataclass> _listOfData = [dummySubData,dummySubData,dummySubData,dummySubData];

    Data dummyData = Data(
      total: 4,
      perPage: 10,
      page: 1,
      lastPage: 1,
      dataclass: _listOfData
    );

    OfferModel dummyOffer = OfferModel(status: true,data:dummyData,message: "Record fetched successfully!");

    repositoryResponse.success = true;
    repositoryResponse.msg = dummyOffer.message;
    repositoryResponse.data = dummyOffer;
    _repositoryResponse.add(repositoryResponse);

  }

  void offersWithoutToken(Map<String, dynamic> map){
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = false;
    _appPreferences.isPreferenceReady;

      NetworkNAO.getOffersWithoutToken(map).then((response) async {
        final data = (response as Response<dynamic>).data;
        if (!data['status']) {
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

  }

  void offersLikeDislike(Map<String, dynamic> map){
    var repositoryResponse = RepositoryResponse();

    LikeDislikeModel likeDislikeOfferResponse = LikeDislikeModel(

    offerId: "37",
    status: 20,
    userId: 100,
    createdAt: "2021-10-18 10:14:34",
    updatedAt: "2021-10-18 10:14:34",
    id: 1336
    );

    repositoryResponse.success = true;
    repositoryResponse.msg = "Offer has been disliked";
    repositoryResponse.data = likeDislikeOfferResponse;
    _repositoryResponse.add(repositoryResponse);
  }

  void offersLike(Map<String, dynamic> map){
    var repositoryResponse = RepositoryResponse();

    LikeDislikeModel likeDislikeOfferResponse = LikeDislikeModel(

        offerId: "37",
        status: 10,
        userId: 100,
        createdAt: "2021-10-18 10:14:34",
        updatedAt: "2021-10-18 10:14:34",
        id: 1336
    );

    repositoryResponse.success = true;
    repositoryResponse.msg = "Offer has been disliked";
    repositoryResponse.data = likeDislikeOfferResponse;
    _repositoryResponse.add(repositoryResponse);
  }

  void redeemOffer(Map<String, dynamic> map){

    RedeemOfferModel redeemOfferModel = RedeemOfferModel(

    id: 1337,
    offerId: 36,
    userId: 100,
    redeemAt: "2021-10-18T10:32:43.108Z",
    status: 30,
    isAvailable: 1,
    createdAt: "2021-10-18 10:19:48",
    updatedAt: "2021-10-18 10:32:43"

    );

    var repositoryResponse = RepositoryResponse();

    repositoryResponse.success = true;
    repositoryResponse.msg = "Redeemed successfully!";
    repositoryResponse.data = redeemOfferModel;
    _repositoryResponse.add(repositoryResponse);
  }

  void getReviews(Map<String, dynamic> map){


    ReviewUser dummyReviewUser = ReviewUser(
        id: 182,
        firstName: "John",
        lastName: "Smith",
        image: null,
        imageUrl: "https://ampd.tekstaging.com/user.png",
        mediumImageUrl: "https://ampd.tekstaging.com/user.png",
        smallImageUrl: "https://ampd.tekstaging.com/user.png"
    );

    ReviewsData dummyReview = ReviewsData(
        id: 100,
        offerId: 34,
        userId: 182,
        review: "this is dummy review",
        rating: "4",
        status: 10,
        createdAt: "2021-10-07 07:45:52",
        updatedAt: "2021-10-07 07:45:52",
        user: dummyReviewUser
    );
    List<ReviewsData> listOfReview = [dummyReview,dummyReview,dummyReview,dummyReview,dummyReview];

    Reviews dummyReviews= Reviews(
        total: 5,
        perPage: 10,
        page: 1,
        lastPage: 1,
        data: listOfReview);
    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = true;
    repositoryResponse.msg = "Record fetched successfully!";
    repositoryResponse.data = dummyReviews;
    _repositoryResponse.add(repositoryResponse);
  }

  Stream<RepositoryResponse> getRepositoryResponse() {
    return _repositoryResponse.stream;
  }
}