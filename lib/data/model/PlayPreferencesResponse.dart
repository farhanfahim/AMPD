class PlayPreferencesResponse {
  int id;
  String name;
  bool isSelected = false;

  PlayPreferencesResponse({this.id, this.name});

  PlayPreferencesResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}