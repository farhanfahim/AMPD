import 'PlayPreferencesResponse.dart';

class UserProfileModel{
  int userId;
  String firstName;
  Object gender;
  Object handicapeId;
  String image;
  Object handicapeName;
  Object about;
  Object favouriteCourses;
  Object genderText;
  Object address;
  Object city_town;
  Object home_town = "";
  Object handicap_index;
  Object college;
  int friendsCount;
  int is_post_pinned;
  int teeitmesCount;
  int friend_requests;
  int mutual_friends_count;
  int isFriend;
  int is_friend_req_received;
  List<PlayPreferencesResponse> playPreferences;

  UserProfileModel(
      {this.userId,
        this.firstName,
        this.gender,
        this.handicapeId,
        this.handicap_index,
        this.is_post_pinned,
        this.image,
        this.handicapeName,
        this.about,
        this.city_town,
        this.home_town,
        this.college,
        this.favouriteCourses,
        this.address,
        this.genderText,
        this.friendsCount,
        this.friend_requests,
        this.mutual_friends_count,
        this.teeitmesCount,
        this.is_friend_req_received,
        this.playPreferences,
        this.isFriend});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    is_friend_req_received = json['is_friend_req_received'];
    gender = json['gender'];
    city_town = json['city_town'];
    home_town = json['home_town'];
    college = json['college'];
    handicapeId = json['handicape_id'];
    is_post_pinned = json['is_post_pinned'];
    handicap_index = json['handicap_index'];
    image = json['image'];
    handicapeName = json['handicape_name'];
    mutual_friends_count = json['mutual_friends_count'];
    address = json['address'];
    about = json['about'];
    favouriteCourses = json['favourite_courses'];
    genderText = json['gender_text'];
    friend_requests = json['friend_requests'];
    friendsCount = json['friends_count'];
    teeitmesCount = json['teeitmes_count'];
    if (json['play_preferences'] != null) {
      playPreferences = new List<PlayPreferencesResponse>();
      json['play_preferences'].forEach((v) {
        playPreferences.add(new PlayPreferencesResponse.fromJson(v));
      });
    }
    isFriend = json['is_friend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['home_town'] = this.home_town;
    data['city_town'] = this.city_town;
    data['first_name'] = this.firstName;
    data['is_friend_req_received'] = this.is_friend_req_received;
    data['handicap_index'] = this.handicap_index;
    data['is_post_pinned'] = this.is_post_pinned;
    data['gender'] = this.gender;
    data['college'] = this.college;
    data['handicape_id'] = this.handicapeId;
    data['mutual_friends_count'] = this.mutual_friends_count;
    data['image'] = this.image;
    data['address'] = this.address;
    data['handicape_name'] = this.handicapeName;
    data['about'] = this.about;
    data['friend_requests'] = this.friend_requests;
    data['favourite_courses'] = this.favouriteCourses;
    data['gender_text'] = this.genderText;
    data['friends_count'] = this.friendsCount;
    data['teeitmes_count'] = this.teeitmesCount;
    data['is_friend'] = this.isFriend;
    if (this.playPreferences != null) {
      data['play_preferences'] =
          this.playPreferences.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class PlayPreferences {
//   int id;
//   String name;
//
//   PlayPreferences({this.id, this.name});
//
//   PlayPreferences.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     return data;
//   }
// }