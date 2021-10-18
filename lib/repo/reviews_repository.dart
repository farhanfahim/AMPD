import 'dart:async';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/data/model/OffeReviewsModel.dart';
import 'package:ampd/data/model/repo_response_model.dart';
import 'package:ampd/data/network/nao/network_nao.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:ampd/app/app.dart';
import 'package:ampd/data/database/app_preferences.dart';

class ReviewsRepository {
  AppPreferences _appPreferences;
  var _repositoryResponse = StreamController<RepositoryResponse>.broadcast();

  factory ReviewsRepository({@required AppPreferences appPreferences}) =>
      ReviewsRepository._internal(appPreferences);

  ReviewsRepository._internal(this._appPreferences);

  void getReviews(Map<String, dynamic> map){
    var repositoryResponse = RepositoryResponse();
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
    List<ReviewsData> listOfReview = [dummyReview1,dummyReview2,dummyReview2,dummyReview2,dummyReview2];

    Reviews dummyReviews= Reviews(
        total: 5,
        perPage: 10,
        page: 1,
        lastPage: 1,
        data: listOfReview);
    repositoryResponse.success = true;
    repositoryResponse.msg = "Record fetched successfully!";
    repositoryResponse.data = dummyReviews;
    _repositoryResponse.add(repositoryResponse);
  }

  Stream<RepositoryResponse> getRepositoryResponse() {
    return _repositoryResponse.stream;
  }
}