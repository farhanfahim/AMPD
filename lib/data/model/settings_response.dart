/// device_type : "ios"
/// push_notification : "1"
/// id : 225

class SettingsResponse {
  String _deviceType;
  int _pushNotification;
  int _id;

  String get deviceType => _deviceType;
  int get pushNotification => _pushNotification;
  int get id => _id;

  SettingsResponse({
      String deviceType,
    int pushNotification,
      int id}){
    _deviceType = deviceType;
    _pushNotification = pushNotification;
    _id = id;
}

  SettingsResponse.fromJson(dynamic json) {
    _deviceType = json["device_type"];
    _pushNotification = json["push_notification"];
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["device_type"] = _deviceType;
    map["push_notification"] = _pushNotification;
    map["id"] = _id;
    return map;
  }

}