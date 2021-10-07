class SubmitReviews {
  bool status;
  String message;
  Data data;

  SubmitReviews({this.status, this.message, this.data});

  SubmitReviews.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String offerId;
  String review;
  String rating;
  int userId;
  int status;
  String createdAt;
  String updatedAt;
  int id;

  Data(
      {this.offerId,
        this.review,
        this.rating,
        this.userId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    offerId = json['offer_id'];
    review = json['review'];
    rating = json['rating'];
    userId = json['user_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offer_id'] = this.offerId;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}