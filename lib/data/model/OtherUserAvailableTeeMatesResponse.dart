
class OtherUserAvailableTeeMatesResponse {
  List<Friends> friends;
  int pages;

  OtherUserAvailableTeeMatesResponse({this.friends, this.pages});

  OtherUserAvailableTeeMatesResponse.fromJson(Map<String, dynamic> json) {
    if (json['friends'] != null) {
      friends = new List<Friends>();
      json['friends'].forEach((v) {
        friends.add(new Friends.fromJson(v));
      });
    }
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.friends != null) {
      data['friends'] = this.friends.map((v) => v.toJson()).toList();
    }
    data['pages'] = this.pages;
    return data;
  }
}

class Friends {
  int id;
  int userId;
  String date;
  String startTime;
  String endTime;
  Null day;
  bool weekly;
  double latitude;
  double longitude;
  String location;
  String createdAt;
  String updatedAt;
  String firstName;
  String original_image_url;
  int gender;
  int handicapeId;

  Friends(
      {this.id,
        this.userId,
        this.date,
        this.startTime,
        this.endTime,
        this.day,
        this.weekly,
        this.latitude,
        this.longitude,
        this.location,
        this.createdAt,
        this.updatedAt,
        this.firstName,
        this.original_image_url,
        this.gender,
        this.handicapeId});

  Friends.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    day = json['day'];
    weekly = json['weekly'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstName = json['first_name'];
    original_image_url = json['original_image_url'];
    gender = json['gender'];
    handicapeId = json['handicape_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['day'] = this.day;
    data['weekly'] = this.weekly;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['first_name'] = this.firstName;
    data['original_image_url'] = this.original_image_url;
    data['gender'] = this.gender;
    data['handicape_id'] = this.handicapeId;
    return data;
  }
}