class Reviews {
  int total;
  int perPage;
  int page;
  int lastPage;
  List<ReviewsData> data;

  Reviews({this.total, this.perPage, this.page, this.lastPage, this.data});

  Reviews.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['perPage'];
    page = json['page'];
    lastPage = json['lastPage'];
    if (json['data'] != null) {
      data = new List<ReviewsData>();
      json['data'].forEach((v) {
        data.add(new ReviewsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['perPage'] = this.perPage;
    data['page'] = this.page;
    data['lastPage'] = this.lastPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReviewsData {
  int id;
  int offerId;
  int userId;
  String review;
  String rating;
  int status;
  String createdAt;
  String updatedAt;
  ReviewUser user;

  ReviewsData(
      {this.id,
        this.offerId,
        this.userId,
        this.review,
        this.rating,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.user});

  ReviewsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    offerId = json['offer_id'];
    userId = json['user_id'];
    review = json['review'];
    rating = json['rating'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new ReviewUser.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['offer_id'] = this.offerId;
    data['user_id'] = this.userId;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class ReviewUser {
  int id;
  String firstName;
  String lastName;
  String image;
  String imageUrl;
  String mediumImageUrl;
  String smallImageUrl;

  ReviewUser(
      {this.id,
        this.firstName,
        this.lastName,
        this.image,
        this.imageUrl,
        this.mediumImageUrl,
        this.smallImageUrl});

  ReviewUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
    imageUrl = json['image_url'];
    mediumImageUrl = json['medium_image_url'];
    smallImageUrl = json['small_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['image'] = this.image;
    data['image_url'] = this.imageUrl;
    data['medium_image_url'] = this.mediumImageUrl;
    data['small_image_url'] = this.smallImageUrl;
    return data;
  }
}