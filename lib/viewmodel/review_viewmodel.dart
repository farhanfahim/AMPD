import 'dart:async';

import 'package:ampd/repo/home_repository.dart';
import 'package:ampd/repo/reviews_repository.dart';
import 'package:flutter/material.dart';
import 'package:ampd/app/app.dart';

class ReviewViewModel {
  ReviewsRepository _reviewRepository;

  static ReviewViewModel _instance;

  factory ReviewViewModel(App app) {
    _instance ??= ReviewViewModel._internal(reviewRepository: app.getReviewsRepository(
        appPreferences: app.getAppPreferences()));
    return _instance;
  }

  ReviewViewModel._internal(
      {@required ReviewsRepository reviewRepository}) {
    _reviewRepository = reviewRepository;
  }

  ReviewsRepository getReviewsRepository() => _reviewRepository;

  ReviewsRepository clearRepositroyResponse() {
    _reviewRepository = null;
  }

  void getReviews(Map<String, dynamic> map) {
    _reviewRepository.getReviews(map);
  }





}
