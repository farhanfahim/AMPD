/// id : 72
/// name : "John Doe"
/// email : "ejaz@yopmail.com"
/// created_at : "2021-02-02 15:52:06"
/// details : {"id":71,"first_name":"Ejaz","last_name":null,"gender":10,"phone":"987654321","address":"Google complexx","handicape_id":1,"favourite_courses":"qqq","image":null,"customer_id":null,"is_verified":1,"email_updates":1,"is_social_login":0,"college":"eee","birthdate":"0000-00-00","home_town":"qeqe","city_town":null,"about":"dwc","handicapes":{"id":1,"name":"Beginner level","level":1,"created_at":"2020-11-13 07:13:05","updated_at":"2020-11-13 07:13:05","deleted_at":null}}

class EditProfileResponse {
  int _id;
  String _name;
  String _email;
  String _createdAt;
  Details _details;

  int get id => _id;
  String get name => _name;
  String get email => _email;
  String get createdAt => _createdAt;
  Details get details => _details;

  EditProfileResponse({
      int id, 
      String name, 
      String email, 
      String createdAt, 
      Details details}){
    _id = id;
    _name = name;
    _email = email;
    _createdAt = createdAt;
    _details = details;
}

  EditProfileResponse.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _email = json["email"];
    _createdAt = json["created_at"];
    _details = json["details"] != null ? Details.fromJson(json["details"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["email"] = _email;
    map["created_at"] = _createdAt;
    if (_details != null) {
      map["details"] = _details.toJson();
    }
    return map;
  }

}

/// id : 71
/// first_name : "Ejaz"
/// last_name : null
/// gender : 10
/// phone : "987654321"
/// address : "Google complexx"
/// handicape_id : 1
/// favourite_courses : "qqq"
/// image : null
/// customer_id : null
/// is_verified : 1
/// email_updates : 1
/// is_social_login : 0
/// college : "eee"
/// birthdate : "0000-00-00"
/// home_town : "qeqe"
/// city_town : null
/// about : "dwc"
/// handicapes : {"id":1,"name":"Beginner level","level":1,"created_at":"2020-11-13 07:13:05","updated_at":"2020-11-13 07:13:05","deleted_at":null}

class Details {
  int _id;
  String _firstName;
  dynamic _lastName;
  int _gender;
  String _phone;
  String _address;
  int _handicapeId;
  String _favouriteCourses;
  dynamic _image;
  dynamic _customerId;
  int _isVerified;
  int _emailUpdates;
  int _isSocialLogin;
  String _college;
  String _birthdate;
  String _homeTown;
  dynamic _cityTown;
  String _about;
  Handicapes _handicapes;

  int get id => _id;
  String get firstName => _firstName;
  dynamic get lastName => _lastName;
  int get gender => _gender;
  String get phone => _phone;
  String get address => _address;
  int get handicapeId => _handicapeId;
  String get favouriteCourses => _favouriteCourses;
  dynamic get image => _image;
  dynamic get customerId => _customerId;
  int get isVerified => _isVerified;
  int get emailUpdates => _emailUpdates;
  int get isSocialLogin => _isSocialLogin;
  String get college => _college;
  String get birthdate => _birthdate;
  String get homeTown => _homeTown;
  dynamic get cityTown => _cityTown;
  String get about => _about;
  Handicapes get handicapes => _handicapes;

  Details({
      int id, 
      String firstName, 
      dynamic lastName, 
      int gender, 
      String phone, 
      String address, 
      int handicapeId, 
      String favouriteCourses, 
      dynamic image, 
      dynamic customerId, 
      int isVerified, 
      int emailUpdates, 
      int isSocialLogin, 
      String college, 
      String birthdate, 
      String homeTown, 
      dynamic cityTown, 
      String about, 
      Handicapes handicapes}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _gender = gender;
    _phone = phone;
    _address = address;
    _handicapeId = handicapeId;
    _favouriteCourses = favouriteCourses;
    _image = image;
    _customerId = customerId;
    _isVerified = isVerified;
    _emailUpdates = emailUpdates;
    _isSocialLogin = isSocialLogin;
    _college = college;
    _birthdate = birthdate;
    _homeTown = homeTown;
    _cityTown = cityTown;
    _about = about;
    _handicapes = handicapes;
}

  Details.fromJson(dynamic json) {
    _id = json["id"];
    _firstName = json["first_name"];
    _lastName = json["last_name"];
    _gender = json["gender"];
    _phone = json["phone"];
    _address = json["address"];
    _handicapeId = json["handicape_id"];
    _favouriteCourses = json["favourite_courses"];
    _image = json["image"];
    _customerId = json["customer_id"];
    _isVerified = json["is_verified"];
    _emailUpdates = json["email_updates"];
    _isSocialLogin = json["is_social_login"];
    _college = json["college"];
    _birthdate = json["birthdate"];
    _homeTown = json["home_town"];
    _cityTown = json["city_town"];
    _about = json["about"];
    _handicapes = json["handicapes"] != null ? Handicapes.fromJson(json["handicapes"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["first_name"] = _firstName;
    map["last_name"] = _lastName;
    map["gender"] = _gender;
    map["phone"] = _phone;
    map["address"] = _address;
    map["handicape_id"] = _handicapeId;
    map["favourite_courses"] = _favouriteCourses;
    map["image"] = _image;
    map["customer_id"] = _customerId;
    map["is_verified"] = _isVerified;
    map["email_updates"] = _emailUpdates;
    map["is_social_login"] = _isSocialLogin;
    map["college"] = _college;
    map["birthdate"] = _birthdate;
    map["home_town"] = _homeTown;
    map["city_town"] = _cityTown;
    map["about"] = _about;
    if (_handicapes != null) {
      map["handicapes"] = _handicapes.toJson();
    }
    return map;
  }

}

/// id : 1
/// name : "Beginner level"
/// level : 1
/// created_at : "2020-11-13 07:13:05"
/// updated_at : "2020-11-13 07:13:05"
/// deleted_at : null

class Handicapes {
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

  Handicapes({
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

  Handicapes.fromJson(dynamic json) {
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