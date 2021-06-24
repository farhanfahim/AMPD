class AllFriendsModel{
  List<Users> users;
  int pages;

  AllFriendsModel({this.users, this.pages});

  AllFriendsModel.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = new List<Users>();
      json['users'].forEach((v) {
        users.add(new Users.fromJson(v));
      });
    }
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['users'] = this.users.map((v) => v.toJson()).toList();
    }
    data['pages'] = this.pages;
    return data;
  }
}

class MutualFriendsModel{
  List<Users> users;
  int pages;

  MutualFriendsModel({this.users, this.pages});

  MutualFriendsModel.fromJson(Map<String, dynamic> json) {
    if (json['mutual_friends'] != null) {
      users = new List<Users>();
      json['mutual_friends'].forEach((v) {
        users.add(new Users.fromJson(v));
      });
    }
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['mutual_friends'] = this.users.map((v) => v.toJson()).toList();
    }
    data['pages'] = this.pages;
    return data;
  }
}

class Users {
  int userId;
  String firstName;
  Object gender;
  Object handicapeId;
  String image;
  Object handicapeName;
  int is_friend;

  Users(
      {this.userId,
        this.firstName,
        this.gender,
        this.handicapeId,
        this.image,
        this.is_friend,
        this.handicapeName});

  Users.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    gender = json['gender'];
    handicapeId = json['handicape_id'];
    image = json['image'];
    handicapeName = json['handicape_name'];
    is_friend = json['is_friend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['gender'] = this.gender;
    data['handicape_id'] = this.handicapeId;
    data['image'] = this.image;
    data['handicape_name'] = this.handicapeName;
    data['is_friend'] = this.is_friend;
    return data;
  }
}