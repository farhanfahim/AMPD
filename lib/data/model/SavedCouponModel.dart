import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SavedCouponModel {
  bool status;
  String message;
  Data data;

  SavedCouponModel({this.status, this.message, this.data});

  SavedCouponModel.fromJson(Map<String, dynamic> json) {
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
  int total;
  int perPage;
  int page;
  int lastPage;
  @JsonKey(name: 'data')
  List<DataClass> dataClass;

  Data({this.total, this.perPage, this.page, this.lastPage, this.dataClass});

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['perPage'];
    page = json['page'];
    lastPage = json['lastPage'];
    if (json['data'] != null) {
      dataClass = new List<DataClass>();
      json['data'].forEach((v) {
        dataClass.add(new DataClass.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['perPage'] = this.perPage;
    data['page'] = this.page;
    data['lastPage'] = this.lastPage;
    if (this.dataClass != null) {
      data['data'] = this.dataClass.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataClass {
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

  DataClass(
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
        this.qrUrl});

  DataClass.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}