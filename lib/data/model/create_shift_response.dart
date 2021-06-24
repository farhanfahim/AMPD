/// date : "2020-11-29 00:00:00"
/// start_time : "12:00"
/// end_time : "16:00"
/// latitude : 24.928140913509758
/// longitude : 67.08930648256217
/// location : "Abid Plaza"
/// weekly : true
/// day : 7
/// user_id : 20
/// updated_at : "2021-02-01 12:57:47"
/// created_at : "2021-02-01 12:57:47"
/// id : 46

class CreateShiftResponse {
  String _date;
  String _startTime;
  String _endTime;
  double _latitude;
  double _longitude;
  String _location;
  bool _weekly;
  int _day;
  int _userId;
  String _updatedAt;
  String _createdAt;
  int _id;

  String get date => _date;
  String get startTime => _startTime;
  String get endTime => _endTime;
  double get latitude => _latitude;
  double get longitude => _longitude;
  String get location => _location;
  bool get weekly => _weekly;
  int get day => _day;
  int get userId => _userId;
  String get updatedAt => _updatedAt;
  String get createdAt => _createdAt;
  int get id => _id;

  CreateShiftResponse({
      String date, 
      String startTime, 
      String endTime, 
      double latitude, 
      double longitude, 
      String location, 
      bool weekly, 
      int day, 
      int userId, 
      String updatedAt, 
      String createdAt, 
      int id}){
    _date = date;
    _startTime = startTime;
    _endTime = endTime;
    _latitude = latitude;
    _longitude = longitude;
    _location = location;
    _weekly = weekly;
    _day = day;
    _userId = userId;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
}

  CreateShiftResponse.fromJson(dynamic json) {
    _date = json["date"];
    _startTime = json["start_time"];
    _endTime = json["end_time"];
    _latitude = json["latitude"];
    _longitude = json["longitude"];
    _location = json["location"];
    _weekly = json["weekly"];
    _day = json["day"];
    _userId = json["user_id"];
    _updatedAt = json["updated_at"];
    _createdAt = json["created_at"];
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["date"] = _date;
    map["start_time"] = _startTime;
    map["end_time"] = _endTime;
    map["latitude"] = _latitude;
    map["longitude"] = _longitude;
    map["location"] = _location;
    map["weekly"] = _weekly;
    map["day"] = _day;
    map["user_id"] = _userId;
    map["updated_at"] = _updatedAt;
    map["created_at"] = _createdAt;
    map["id"] = _id;
    return map;
  }

}