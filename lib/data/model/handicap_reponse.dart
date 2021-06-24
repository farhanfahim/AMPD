/// id : 1
/// name : "Beginner level"
/// level : 1
/// created_at : "2020-11-13 07:13:05"
/// updated_at : "2020-11-13 07:13:05"
/// deleted_at : null

class HandicapReponse {
  int _id;
  String _name;
  int _level;
  String _createdAt;
  String _updatedAt;
  dynamic _deletedAt;

  int get id => _id;
  String get name => _name;
  int get level => _level;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;

  HandicapReponse({
      int id, 
      String name, 
      int level, 
      String createdAt, 
      String updatedAt, 
      dynamic deletedAt}){
    _id = id;
    _name = name;
    _level = level;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
}

  HandicapReponse.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _level = json["level"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _deletedAt = json["deleted_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["level"] = _level;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["deleted_at"] = _deletedAt;
    return map;
  }
}