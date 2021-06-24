class ExtraPayload{
  String type;
  int ref_id;

  ExtraPayload({this.type, this.ref_id});

  ExtraPayload.fromJson(dynamic json) {
    type = json["type"];
    ref_id = json["ref_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["ref_id"] = ref_id;
    map["type"] = type;
   return map;
  }
}
