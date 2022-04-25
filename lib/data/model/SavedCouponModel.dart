

class SavedCouponModel {
  int total;
  int perPage;
  int page;
  int lastPage;
  List<DataClass> dataClass;

  SavedCouponModel({this.total, this.perPage, this.page, this.lastPage, this.dataClass});

  SavedCouponModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['perPage'];
    page = json['page'];
    lastPage = json['lastPage'];
    if (json['data'] != null) {
      dataClass = <DataClass>[];
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
  Object value;
  String expireAt;
  int numberOfUses;
  Object dislikeTime;
  Object recurrenceTime;
  Object availTime;
  String qrCode;
  String redeemMessage;
  String image;
  String backgroundColor;
  String description;
  int status;
  int isActive;
  String createdAt;
  String updatedAt;
  String averageRating;
  int totalReviews;
  String imageUrl;
  String mediumImageUrl;
  String smallImageUrl;
  String qrUrl;
  int isExpire;
  List<UserOffers> userOffers;
  Store store;

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
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.averageRating,
        this.totalReviews,
        this.imageUrl,
        this.mediumImageUrl,
        this.smallImageUrl,
        this.qrUrl,
        this.isExpire,
        this.userOffers,
        this.store});

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
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    averageRating = json['average_rating'];
    totalReviews = json['total_reviews'];
    imageUrl = json['image_url'];
    mediumImageUrl = json['medium_image_url'];
    smallImageUrl = json['small_image_url'];
    qrUrl = json['qr_url'];
    isExpire = json['is_expire'];
    if (json['user_offers'] != null) {
      userOffers = <UserOffers>[];
      json['user_offers'].forEach((v) {
        userOffers.add(new UserOffers.fromJson(v));
      });
    }
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
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
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['average_rating'] = this.averageRating;
    data['total_reviews'] = this.totalReviews;
    data['image_url'] = this.imageUrl;
    data['medium_image_url'] = this.mediumImageUrl;
    data['small_image_url'] = this.smallImageUrl;
    data['qr_url'] = this.qrUrl;
    data['is_expire'] = this.isExpire;
    if (this.userOffers != null) {
      data['user_offers'] = this.userOffers.map((v) => v.toJson()).toList();
    }
    if (this.store != null) {
      data['store'] = this.store.toJson();
    }
    return data;
  }
}

class UserOffers {
  int id;
  int offerId;
  String createdAt;

  UserOffers({this.id, this.offerId,this.createdAt});

  UserOffers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    offerId = json['offer_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['offer_id'] = this.offerId;
    data['created_at'] = this.createdAt;
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