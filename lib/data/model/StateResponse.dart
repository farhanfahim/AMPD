class StateResponse{
  int id;
  String name;
  String shortName;
  Object salesTax;
  String createdAt;
  String updatedAt;
  Null deletedAt;

  StateResponse(
      {this.id,
        this.name,
        this.shortName,
        this.salesTax,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  StateResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['short_name'];
    salesTax = json['sales_tax'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['short_name'] = this.shortName;
    data['sales_tax'] = this.salesTax;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}