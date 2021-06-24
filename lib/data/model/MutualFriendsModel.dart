class MutualFriendsModel {
  List<MutualFriends> mutualFriends;
  int pages;

  MutualFriendsModel({this.mutualFriends, this.pages});

  MutualFriendsModel.fromJson(Map<String, dynamic> json) {
    if (json['mutual_friends'] != null) {
      mutualFriends = new List<MutualFriends>();
      json['mutual_friends'].forEach((v) {
        mutualFriends.add(new MutualFriends.fromJson(v));
      });
    }
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mutualFriends != null) {
      data['mutual_friends'] =
          this.mutualFriends.map((v) => v.toJson()).toList();
    }
    data['pages'] = this.pages;
    return data;
  }
}

class MutualFriends {
  int id;
  int userId;
  String firstName;
  Null lastName;
  int gender;
  Null phone;
  String address;
  double latitude;
  double longitude;
  int handicapeId;
  Null favouriteCourses;
  String image;
  String customerId;
  String connectAccountId;
  int isVerified;
  int emailUpdates;
  int isSocialLogin;
  Null college;
  Null birthdate;
  String homeTown;
  String cityTown;
  String about;
  Null handicapIndex;
  Null storeId;
  int friendsCount;
  int teetimesCount;
  int isFriend;

  MutualFriends(
      {this.id,
        this.userId,
        this.firstName,
        this.lastName,
        this.gender,
        this.phone,
        this.address,
        this.latitude,
        this.longitude,
        this.handicapeId,
        this.favouriteCourses,
        this.image,
        this.customerId,
        this.connectAccountId,
        this.isVerified,
        this.emailUpdates,
        this.isSocialLogin,
        this.college,
        this.birthdate,
        this.homeTown,
        this.cityTown,
        this.about,
        this.handicapIndex,
        this.storeId,
        this.friendsCount,
        this.teetimesCount,
        this.isFriend});

  MutualFriends.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    phone = json['phone'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    handicapeId = json['handicape_id'];
    favouriteCourses = json['favourite_courses'];
    image = json['image'];
    customerId = json['customer_id'];
    connectAccountId = json['connect_account_id'];
    isVerified = json['is_verified'];
    emailUpdates = json['email_updates'];
    isSocialLogin = json['is_social_login'];
    college = json['college'];
    birthdate = json['birthdate'];
    homeTown = json['home_town'];
    cityTown = json['city_town'];
    about = json['about'];
    handicapIndex = json['handicap_index'];
    storeId = json['store_id'];
    friendsCount = json['friends_count'];
    teetimesCount = json['teetimes_count'];
    isFriend = json['is_friend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['handicape_id'] = this.handicapeId;
    data['favourite_courses'] = this.favouriteCourses;
    data['image'] = this.image;
    data['customer_id'] = this.customerId;
    data['connect_account_id'] = this.connectAccountId;
    data['is_verified'] = this.isVerified;
    data['email_updates'] = this.emailUpdates;
    data['is_social_login'] = this.isSocialLogin;
    data['college'] = this.college;
    data['birthdate'] = this.birthdate;
    data['home_town'] = this.homeTown;
    data['city_town'] = this.cityTown;
    data['about'] = this.about;
    data['handicap_index'] = this.handicapIndex;
    data['store_id'] = this.storeId;
    data['friends_count'] = this.friendsCount;
    data['teetimes_count'] = this.teetimesCount;
    data['is_friend'] = this.isFriend;
    return data;
  }
}