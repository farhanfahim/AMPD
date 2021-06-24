
class LoginResponse {
  int id;
  String name;
  String email;
  String createdAt;
  Details details;
  String accessToken;
  String tokenType;
  String firebaseToken;
  int expiresIn;

  LoginResponse(
      {this.id,
        this.name,
        this.email,
        this.createdAt,
        this.details,
        this.accessToken,
        this.tokenType,
        this.firebaseToken,
        this.expiresIn});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    createdAt = json['created_at'];
    details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    firebaseToken = json['firebase_token'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    if (this.details != null) {
      data['details'] = this.details.toJson();
    }
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['firebaseToken'] = this.firebaseToken;
    return data;
  }
}

class Details {
  int id;
  String firstName;
  String lastName;
  String phone;
  String address;
  Object handicapeId;
  Object connect_id;
  Object store_id;
  Handicapes handicapes;
  String favouriteCourses;
  String image;
  String home_town;
  String city_town;
  Object gender;
  String college;
  String about;
  Object handicap_index;
  String birthdate;
  Object customerId;
  int isVerified;
  int emailUpdates;
  int isSocialLogin;
  List<UserDevices> userDevices;


  Details(
      {this.id,
        this.firstName,
        this.lastName,
        this.phone,
        this.gender,
        this.address,
        this.connect_id,
        this.handicapeId,
        this.handicap_index,
        this.store_id,
        this.handicapes,
        this.birthdate,
        this.home_town,
        this.city_town,
        this.college,
        this.favouriteCourses,
        this.image,
        this.about,
        this.customerId,
        this.isVerified,
        this.emailUpdates,
        this.isSocialLogin,
        this.userDevices});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    handicap_index = json['handicap_index'];
    connect_id = json['connect_account_id'];
    address = json['address'];
    store_id = json['store_id'];
    handicapeId = json['handicape_id'];
    handicapes = json["handicapes"] != null ? Handicapes.fromJson(json["handicapes"]) : null;
    favouriteCourses = json['favourite_courses'];
    gender = json['gender'];
    home_town = json['home_town'];
    city_town = json['city_town'];
    college = json['college'];
    image = json['image'];
    about = json['about'];
    birthdate = json['birthdate'];
    customerId = json['customer_id'];
    isVerified = json['is_verified'];
    emailUpdates = json['email_updates'];
    isSocialLogin = json['is_social_login'];
    if (json['user_devices'] != null) {
      userDevices = new List<UserDevices>();
      json['user_devices'].forEach((v) {
        userDevices.add(new UserDevices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['connect_account_id'] = this.connect_id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['college'] = this.college;
    data['store_id'] = this.store_id;
    data['handicap_index'] = this.handicap_index;
    data['address'] = this.address;
    data['handicape_id'] = this.handicapeId;
    data['handicapes'] = this.handicapes;
    data['favourite_courses'] = this.favouriteCourses;
    data['home_town'] = this.home_town;
    data['city_town'] = this.city_town;
    data['gender'] = this.gender;
    data['about'] = this.about;
    data['image'] = this.image;
    data['birthdate'] = this.birthdate;
    data['customer_id'] = this.customerId;
    data['is_verified'] = this.isVerified;
    data['email_updates'] = this.emailUpdates;
    data['is_social_login'] = this.isSocialLogin;
    if (this.userDevices != null) {
      data['user_devices'] = this.userDevices.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Handicapes {
  int id;
  String name;
  int level;
  String createdAt;
  String updatedAt;
  Null deletedAt;

  Handicapes(
      {this.id,
        this.name,
        this.level,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Handicapes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    level = json['level'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['level'] = this.level;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
class UserDevices {
  int id;
  String deviceType;
  String deviceToken;
  int pushNotification;

  UserDevices(
      {this.id, this.deviceType, this.deviceToken, this.pushNotification});

  UserDevices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    pushNotification = json['push_notification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['device_type'] = this.deviceType;
    data['device_token'] = this.deviceToken;
    data['push_notification'] = this.pushNotification;
    return data;
  }
}