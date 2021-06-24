/// id : 4
/// slug : "about-us"
/// status : 1
/// created_at : "2020-11-16 06:54:32"
/// updated_at : "2020-11-16 06:54:32"
/// deleted_at : null
/// title : "About us"
/// content : "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,"
/// translations : [{"id":1,"page_id":4,"locale":"en","title":"About us","content":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,","status":false,"created_at":"2021-02-03 12:51:49","updated_at":"2021-02-03 12:51:49","deleted_at":null}]

class AboutUsResponse {
  int _id;
  String _slug;
  int _status;
  String _createdAt;
  String _updatedAt;
  dynamic _deletedAt;
  String _title;
  String _content;
  List<Translations> _translations;

  int get id => _id;
  String get slug => _slug;
  int get status => _status;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  String get title => _title;
  String get content => _content;
  List<Translations> get translations => _translations;

  AboutUsResponse({
      int id, 
      String slug, 
      int status, 
      String createdAt, 
      String updatedAt, 
      dynamic deletedAt, 
      String title, 
      String content, 
      List<Translations> translations}){
    _id = id;
    _slug = slug;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _title = title;
    _content = content;
    _translations = translations;
}

  AboutUsResponse.fromJson(dynamic json) {
    _id = json["id"];
    _slug = json["slug"];
    _status = json["status"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _deletedAt = json["deleted_at"];
    _title = json["title"];
    _content = json["content"];
    if (json["translations"] != null) {
      _translations = [];
      json["translations"].forEach((v) {
        _translations.add(Translations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["slug"] = _slug;
    map["status"] = _status;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["deleted_at"] = _deletedAt;
    map["title"] = _title;
    map["content"] = _content;
    if (_translations != null) {
      map["translations"] = _translations.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// page_id : 4
/// locale : "en"
/// title : "About us"
/// content : "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,"
/// status : false
/// created_at : "2021-02-03 12:51:49"
/// updated_at : "2021-02-03 12:51:49"
/// deleted_at : null

class Translations {
  int _id;
  int _pageId;
  String _locale;
  String _title;
  String _content;
  bool _status;
  String _createdAt;
  String _updatedAt;
  dynamic _deletedAt;

  int get id => _id;
  int get pageId => _pageId;
  String get locale => _locale;
  String get title => _title;
  String get content => _content;
  bool get status => _status;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;

  Translations({
      int id, 
      int pageId, 
      String locale, 
      String title, 
      String content, 
      bool status, 
      String createdAt, 
      String updatedAt, 
      dynamic deletedAt}){
    _id = id;
    _pageId = pageId;
    _locale = locale;
    _title = title;
    _content = content;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
}

  Translations.fromJson(dynamic json) {
    _id = json["id"];
    _pageId = json["page_id"];
    _locale = json["locale"];
    _title = json["title"];
    _content = json["content"];
    _status = json["status"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _deletedAt = json["deleted_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["page_id"] = _pageId;
    map["locale"] = _locale;
    map["title"] = _title;
    map["content"] = _content;
    map["status"] = _status;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["deleted_at"] = _deletedAt;
    return map;
  }
}