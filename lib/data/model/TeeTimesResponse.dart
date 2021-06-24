

import 'AvailableTeeMatesResponse.dart';

class TeeTimesResponse {
  List<Teetimes> teetimes;
  int pages;

  TeeTimesResponse({this.teetimes, this.pages});

  TeeTimesResponse.fromJson(Map<String, dynamic> json) {
    if (json['teetimes'] != null) {
      teetimes = new List<Teetimes>();
      json['teetimes'].forEach((v) {
        teetimes.add(new Teetimes.fromJson(v));
      });
    }
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.teetimes != null) {
      data['teetimes'] = this.teetimes.map((v) => v.toJson()).toList();
    }
    data['pages'] = this.pages;
    return data;
  }
}

class Teetimes {
  int id;
  int isJoined;
  int organizerId;
  int is_my_teetime;
  int is_requested;
  bool can_check_in;
  bool is_checked_in;
  String title;
  String description;
  String location;
  double latitude;
  double longitude;
  String date;
  String startTime;
  String organizerName;
  String image;
  List<TeetimePlayers> teetimePlayers;

  Teetimes(
      {this.id,
        this.organizerId,
        this.isJoined,
        this.is_my_teetime,
        this.is_requested,
        this.can_check_in,
        this.is_checked_in,
        this.title,
        this.description,
        this.location,
        this.latitude,
        this.longitude,
        this.date,
        this.startTime,
        this.organizerName,
        this.image,
        this.teetimePlayers});

  Teetimes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    is_requested = json['is_requested'];
    isJoined = json['is_joined'];
    is_my_teetime = json['is_my_teetime'];
    can_check_in = json['can_check_in'];
    is_checked_in = json['is_checked_in'];
    organizerId = json['organizer_id'];
    title = json['title'];
    description = json['description'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    date = json['date']; //Util.convertUTCDateToLocal(modal.startTime)
    startTime = json['start_time'];// Util.convertUTCDateToLocal(json['start_time']);
    // startTime = json['start_time'];
    organizerName = json['organizer_name'];
    image = json['image'];
    if (json['teetime_players'] != null) {
      teetimePlayers = new List<TeetimePlayers>();
      json['teetime_players'].forEach((v) {
        teetimePlayers.add(new TeetimePlayers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_joined'] = this.isJoined;
    data['is_requested'] = this.is_requested;
    data['is_my_teetime'] = this.is_my_teetime;
    data['can_check_in'] = this.can_check_in;
    data['organizer_id'] = this.organizerId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['location'] = this.location;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['organizer_name'] = this.organizerName;
    data['image'] = this.image;
    if (this.teetimePlayers != null) {
      data['teetime_players'] =
          this.teetimePlayers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeetimePlayers {
  int status;
  int id;
  String name;
  String image;
  Teemates user_availability;

  TeetimePlayers({this.status, this.id, this.name, this.image});

  TeetimePlayers.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    name = json['name'];
    image = json['image'];
    user_availability = json['user_availability'] != null ? new Teemates.fromJson(json['user_availability']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    if (this.user_availability != null) {
      data['user_availability'] = this.user_availability.toJson();
    }
    return data;
  }
}