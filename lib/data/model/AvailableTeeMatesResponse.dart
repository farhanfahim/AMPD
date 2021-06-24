class AvailableTeeMatesRespnse {
  List<Teemates> teemates;
  int pages;

  AvailableTeeMatesRespnse({this.teemates, this.pages});

  AvailableTeeMatesRespnse.fromJson(Map<String, dynamic> json) {
    if (json['teemates'] != null) {
      teemates = new List<Teemates>();
      json['teemates'].forEach((v) {
        teemates.add(new Teemates.fromJson(v));
      });
    }
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.teemates != null) {
      data['teemates'] = this.teemates.map((v) => v.toJson()).toList();
    }
    data['pages'] = this.pages;
    return data;
  }
}

class Teemates {
  int id;
  int userId;
  String date;
  String startTime;
  String endTime;
  Object day;
  Object weekly;
  Object latitude;
  Object longitude;
  String location;
  String createdAt;
  String updatedAt;
  String firstName;
  String image;
  String city = "N/A";
  Object gender;
  Object handicapeId;
  Object distance;
  bool isSelected = false;

  Teemates(
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
        this.image,
        this.city,
        this.gender,
        this.handicapeId,
        this.isSelected,
        this.distance});

  Teemates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    day = json['day'];
    weekly = json['weekly'];
    city = json['city_town'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstName = json['first_name'];
    image = json['image'];
    gender = json['gender'];
    handicapeId = json['handicape_id'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['day'] = this.day;
    data['city_town'] = this.city;
    data['weekly'] = this.weekly;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['first_name'] = this.firstName;
    data['image'] = this.image;
    data['gender'] = this.gender;
    data['handicape_id'] = this.handicapeId;
    data['distance'] = this.distance;
    return data;
  }
}