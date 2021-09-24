class LoginResponseModel {
  bool status;
  Data data;
  String message;

  LoginResponseModel({this.status, this.data, this.message});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String image;
  Object address;
  Object latitude;
  Object longitude;
  int pushNotifications;
  int sortingAscending;
  int nearestLocation;
  int highestDiscountAmount;
  int soonestExpiration;
  int radius;
  Object socialPlatform;
  Object clientId;
  Object token;
  Object verificationCode;
  int isSocialLogin;
  int isVerified;
  int isApproved;
  String createdAt;
  String updatedAt;
  AccessToken accessToken;
  String imageUrl;
  String mediumImageUrl;
  String smallImageUrl;
  Meta mMeta;

  Data(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.image,
        this.address,
        this.latitude,
        this.longitude,
        this.pushNotifications,
        this.sortingAscending,
        this.nearestLocation,
        this.highestDiscountAmount,
        this.soonestExpiration,
        this.radius,
        this.socialPlatform,
        this.clientId,
        this.token,
        this.verificationCode,
        this.isSocialLogin,
        this.isVerified,
        this.isApproved,
        this.createdAt,
        this.updatedAt,
        this.accessToken,
        this.imageUrl,
        this.mediumImageUrl,
        this.smallImageUrl,
        this.mMeta});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    pushNotifications = json['push_notifications'];
    sortingAscending = json['sorting_ascending'];
    nearestLocation = json['nearest_location'];
    highestDiscountAmount = json['highest_discount_amount'];
    soonestExpiration = json['soonest_expiration'];
    radius = json['radius'];
    socialPlatform = json['social_platform'];
    clientId = json['client_id'];
    token = json['token'];
    verificationCode = json['verification_code'];
    isSocialLogin = json['is_social_login'];
    isVerified = json['is_verified'];
    isApproved = json['is_approved'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    accessToken = json['access_token'] != null
        ? new AccessToken.fromJson(json['access_token'])
        : null;
    imageUrl = json['image_url'];
    mediumImageUrl = json['medium_image_url'];
    smallImageUrl = json['small_image_url'];
    mMeta =
    json['__meta__'] != null ? new Meta.fromJson(json['__meta__']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['push_notifications'] = this.pushNotifications;
    data['sorting_ascending'] = this.sortingAscending;
    data['nearest_location'] = this.nearestLocation;
    data['highest_discount_amount'] = this.highestDiscountAmount;
    data['soonest_expiration'] = this.soonestExpiration;
    data['radius'] = this.radius;
    data['social_platform'] = this.socialPlatform;
    data['client_id'] = this.clientId;
    data['token'] = this.token;
    data['verification_code'] = this.verificationCode;
    data['is_social_login'] = this.isSocialLogin;
    data['is_verified'] = this.isVerified;
    data['is_approved'] = this.isApproved;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.accessToken != null) {
      data['access_token'] = this.accessToken.toJson();
    }
    data['image_url'] = this.imageUrl;
    data['medium_image_url'] = this.mediumImageUrl;
    data['small_image_url'] = this.smallImageUrl;
    if (this.mMeta != null) {
      data['__meta__'] = this.mMeta.toJson();
    }
    return data;
  }
}

class AccessToken {
  String type;
  String token;
  String refreshToken;

  AccessToken({this.type, this.token, this.refreshToken});

  AccessToken.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}

class Meta {
  String rolesCsv;

  Meta({this.rolesCsv});

  Meta.fromJson(Map<String, dynamic> json) {
    rolesCsv = json['rolesCsv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rolesCsv'] = this.rolesCsv;
    return data;
  }
}