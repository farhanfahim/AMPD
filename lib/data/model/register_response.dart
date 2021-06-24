/// name : "delete"
/// email : "delete1111213@gmail.com"
/// created_at : "2021-02-01 12:44:19"
/// id : 50

class Register_response {
  String _name;
  String _email;
  String _createdAt;
  int _id;

  String get name => _name;
  String get email => _email;
  String get createdAt => _createdAt;
  int get id => _id;

  Register_response({
      String name, 
      String email, 
      String createdAt, 
      int id}){
    _name = name;
    _email = email;
    _createdAt = createdAt;
    _id = id;
}

  Register_response.fromJson(dynamic json) {
    _name = json["name"];
    _email = json["email"];
    _createdAt = json["created_at"];
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["email"] = _email;
    map["created_at"] = _createdAt;
    map["id"] = _id;
    return map;
  }

}