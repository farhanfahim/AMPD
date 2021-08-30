

import 'package:ampd/data/model/OffeReviewsModel.dart';

class Dataclass {
  int id;
  int userId;
  String title;
  String productName;
  int type;
  int value;
  String expireAt;
  int numberOfUses;
  int dislikeTime;
  int recurrenceTime;
  int availTime;
  String qrCode;
  Null redeemMessage;
  String image;
  String backgroundColor;
  Null description;
  int status;
  String createdAt;
  String updatedAt;
  Null averageRating;
  int totalReviews;
  String imageUrl;
  String mediumImageUrl;
  String smallImageUrl;
  String qrUrl;
  User user;
  Store store;
  List<Reviews> reviews;
  Meta mMeta;

  Dataclass(
      {this.id,
        this.userId,
        this.title,
        this.productName,
        this.type,
        this.value,
        this.expireAt,
        this.numberOfUses,
        this.dislikeTime,
        this.recurrenceTime,
        this.availTime,
        this.qrCode,
        this.redeemMessage,
        this.image,
        this.backgroundColor,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.averageRating,
        this.totalReviews,
        this.imageUrl,
        this.mediumImageUrl,
        this.smallImageUrl,
        this.qrUrl,
        this.user,
        this.store,
        this.reviews,
        this.mMeta});

  Dataclass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    productName = json['product_name'];
    type = json['type'];
    value = json['value'];
    expireAt = json['expire_at'];
    numberOfUses = json['number_of_uses'];
    dislikeTime = json['dislike_time'];
    recurrenceTime = json['recurrence_time'];
    availTime = json['avail_time'];
    qrCode = json['qr_code'];
    redeemMessage = json['redeem_message'];
    image = json['image'];
    backgroundColor = json['background_color'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    averageRating = json['average_rating'];
    totalReviews = json['total_reviews'];
    imageUrl = json['image_url'];
    mediumImageUrl = json['medium_image_url'];
    smallImageUrl = json['small_image_url'];
    qrUrl = json['qr_url'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    if (json['reviews'] != null) {
      reviews = new List<Reviews>();
      json['reviews'].forEach((v) {
        reviews.add(new Reviews.fromJson(v));
      });
    }
    mMeta =
    json['__meta__'] != null ? new Meta.fromJson(json['__meta__']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['product_name'] = this.productName;
    data['type'] = this.type;
    data['value'] = this.value;
    data['expire_at'] = this.expireAt;
    data['number_of_uses'] = this.numberOfUses;
    data['dislike_time'] = this.dislikeTime;
    data['recurrence_time'] = this.recurrenceTime;
    data['avail_time'] = this.availTime;
    data['qr_code'] = this.qrCode;
    data['redeem_message'] = this.redeemMessage;
    data['image'] = this.image;
    data['background_color'] = this.backgroundColor;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['average_rating'] = this.averageRating;
    data['total_reviews'] = this.totalReviews;
    data['image_url'] = this.imageUrl;
    data['medium_image_url'] = this.mediumImageUrl;
    data['small_image_url'] = this.smallImageUrl;
    data['qr_url'] = this.qrUrl;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.store != null) {
      data['store'] = this.store.toJson();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    }
    if (this.mMeta != null) {
      data['__meta__'] = this.mMeta.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String address;
  String phone;
  String image;
  String latitude;
  String longitude;
  int radius;
  String imageUrl;
  String mediumImageUrl;
  String smallImageUrl;

  User(
      {this.id,
        this.address,
        this.phone,
        this.image,
        this.latitude,
        this.longitude,
        this.radius,
        this.imageUrl,
        this.mediumImageUrl,
        this.smallImageUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    phone = json['phone'];
    image = json['image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    radius = json['radius'];
    imageUrl = json['image_url'];
    mediumImageUrl = json['medium_image_url'];
    smallImageUrl = json['small_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['radius'] = this.radius;
    data['image_url'] = this.imageUrl;
    data['medium_image_url'] = this.mediumImageUrl;
    data['small_image_url'] = this.smallImageUrl;
    return data;
  }
}


class Store {
  int id;
  int userId;
  String name;
  String about;
  String openingTime;
  String closingTime;

  Store(
      {this.id,
        this.userId,
        this.name,
        this.about,
        this.openingTime,
        this.closingTime});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    about = json['about'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['about'] = this.about;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    return data;
  }
}

class Meta {
  int isReviewed;

  Meta({this.isReviewed});

  Meta.fromJson(Map<String, dynamic> json) {
    isReviewed = json['is_reviewed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_reviewed'] = this.isReviewed;
    return data;
  }
}