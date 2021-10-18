import 'dart:async';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/data/model/OfferDataClassModel.dart';
import 'package:ampd/data/model/RedeemOfferModel.dart';
import 'package:ampd/data/model/repo_response_model.dart';
import 'package:ampd/data/model/LikeDislikeModel.dart';
import 'package:ampd/data/model/OffeReviewsModel.dart';
import 'package:ampd/data/model/OfferDataClassModel.dart';
import 'package:ampd/data/model/OfferModel.dart';
import 'package:ampd/data/model/RedeemOfferModel.dart';
import 'package:ampd/data/model/repo_response_model.dart';
import 'package:ampd/data/network/nao/network_nao.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:ampd/app/app.dart';
import 'package:ampd/data/database/app_preferences.dart';

class RedeemNowRepository {
  AppPreferences _appPreferences;
  var _repositoryResponse = StreamController<RepositoryResponse>.broadcast();

  factory RedeemNowRepository({@required AppPreferences appPreferences}) =>
      RedeemNowRepository._internal(appPreferences);

  RedeemNowRepository._internal(this._appPreferences);

  void getRedeemOffers(Map<String, dynamic> map,int id){

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

    var repositoryResponse = RepositoryResponse();
    repositoryResponse.success = true;
    repositoryResponse.msg = "Offer fetched successfully!";
    repositoryResponse.data = dummySubData;
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
  Stream<RepositoryResponse> getRepositoryResponse() {
    return _repositoryResponse.stream;
  }
}