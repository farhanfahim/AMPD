/// id : 87
/// teetime_id : 44
/// user_id : 85
/// status : 10
/// sender_id : 72
/// receiver_id : 85
/// created_at : "2021-02-05 08:48:55"
/// updated_at : "2021-02-05 08:48:55"

class AcceptTeetimeResponse {
  int _id;
  int _teetimeId;
  int _userId;
  int _status;
  int _senderId;
  int _receiverId;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  int get teetimeId => _teetimeId;
  int get userId => _userId;
  int get status => _status;
  int get senderId => _senderId;
  int get receiverId => _receiverId;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  AcceptTeetimeResponse({
      int id, 
      int teetimeId, 
      int userId, 
      int status, 
      int senderId, 
      int receiverId, 
      String createdAt, 
      String updatedAt}){
    _id = id;
    _teetimeId = teetimeId;
    _userId = userId;
    _status = status;
    _senderId = senderId;
    _receiverId = receiverId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  AcceptTeetimeResponse.fromJson(dynamic json) {
    _id = json["id"];
    _teetimeId = json["teetime_id"];
    _userId = json["user_id"];
    _status = json["status"];
    _senderId = json["sender_id"];
    _receiverId = json["receiver_id"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["teetime_id"] = _teetimeId;
    map["user_id"] = _userId;
    map["status"] = _status;
    map["sender_id"] = _senderId;
    map["receiver_id"] = _receiverId;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }
}