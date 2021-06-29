import 'dart:ffi';

class ReviewsModel{
  List<Reviews> reviews;
  int pages;
  ReviewsModel({this.reviews, this.pages});

}

class Reviews {
  String name;
  double rating;
  String description;
  String image;

  Reviews(
      { this.name, this.rating, this.description,this.image});
}