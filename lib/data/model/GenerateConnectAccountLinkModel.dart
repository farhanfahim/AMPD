class GenerateConnectAccountLinkModel{
  String object;
  int created;
  int expiresAt;
  String url;

  GenerateConnectAccountLinkModel({this.object, this.created, this.expiresAt, this.url});

  GenerateConnectAccountLinkModel.fromJson(Map<String, dynamic> json) {
    object = json['object'];
    created = json['created'];
    expiresAt = json['expires_at'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['object'] = this.object;
    data['created'] = this.created;
    data['expires_at'] = this.expiresAt;
    data['url'] = this.url;
    return data;
  }
}