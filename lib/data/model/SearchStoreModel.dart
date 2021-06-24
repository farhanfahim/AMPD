class SearchStoreModel{
  List<Stores> stores;
  int pages;

  SearchStoreModel({this.stores, this.pages});

  SearchStoreModel.fromJson(Map<String, dynamic> json) {
    if (json['stores'] != null) {
      stores = new List<Stores>();
      json['stores'].forEach((v) {
        stores.add(new Stores.fromJson(v));
      });
    }
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stores != null) {
      data['stores'] = this.stores.map((v) => v.toJson()).toList();
    }
    data['pages'] = this.pages;
    return data;
  }
}

class Stores {
  int id;
  int userId;
  String name;
  String description;
  String address;
  double latitude;
  double longitude;
  Null startTime;
  Null endTime;
  bool featured;
  int inMenu;
  String image;
  String createdAt;
  String updatedAt;
  int totalReviews;
  User user;

  Stores(
      {this.id,
        this.userId,
        this.name,
        this.description,
        this.address,
        this.latitude,
        this.longitude,
        this.startTime,
        this.endTime,
        this.featured,
        this.inMenu,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.totalReviews,
        this.user});

  Stores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    description = json['description'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    featured = json['featured'];
    inMenu = json['in_menu'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    totalReviews = json['total_reviews'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['featured'] = this.featured;
    data['in_menu'] = this.inMenu;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['total_reviews'] = this.totalReviews;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String name;
  String email;
  String createdAt;
  Details details;

  User({this.id, this.name, this.email, this.createdAt, this.details});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    createdAt = json['created_at'];
    details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
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
    return data;
  }
}

class Details {
  int id;
  String firstName;
  Null lastName;
  int gender;
  String phone;
  String address;
  int handicapeId;
  String favouriteCourses;
  String image;
  Null customerId;
  int isVerified;
  int emailUpdates;
  int isSocialLogin;
  String college;
  String birthdate;
  String homeTown;
  String cityTown;
  String about;
  int storeId;
  Handicapes handicapes;
  List<UserDevices> userDevices;

  Details(
      {this.id,
        this.firstName,
        this.lastName,
        this.gender,
        this.phone,
        this.address,
        this.handicapeId,
        this.favouriteCourses,
        this.image,
        this.customerId,
        this.isVerified,
        this.emailUpdates,
        this.isSocialLogin,
        this.college,
        this.birthdate,
        this.homeTown,
        this.cityTown,
        this.about,
        this.storeId,
        this.handicapes,
        this.userDevices});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    phone = json['phone'];
    address = json['address'];
    handicapeId = json['handicape_id'];
    favouriteCourses = json['favourite_courses'];
    image = json['image'];
    customerId = json['customer_id'];
    isVerified = json['is_verified'];
    emailUpdates = json['email_updates'];
    isSocialLogin = json['is_social_login'];
    college = json['college'];
    birthdate = json['birthdate'];
    homeTown = json['home_town'];
    cityTown = json['city_town'];
    about = json['about'];
    storeId = json['store_id'];
    handicapes = json['handicapes'] != null
        ? new Handicapes.fromJson(json['handicapes'])
        : null;
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
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['handicape_id'] = this.handicapeId;
    data['favourite_courses'] = this.favouriteCourses;
    data['image'] = this.image;
    data['customer_id'] = this.customerId;
    data['is_verified'] = this.isVerified;
    data['email_updates'] = this.emailUpdates;
    data['is_social_login'] = this.isSocialLogin;
    data['college'] = this.college;
    data['birthdate'] = this.birthdate;
    data['home_town'] = this.homeTown;
    data['city_town'] = this.cityTown;
    data['about'] = this.about;
    data['store_id'] = this.storeId;
    if (this.handicapes != null) {
      data['handicapes'] = this.handicapes.toJson();
    }
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