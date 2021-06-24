class ShippingAddressModel {

  int id;
  int userId;
  String address;
  String city;
  String country;
  String zip;
  String phone;
  String createdAt;
  String updatedAt;

  ShippingAddressModel({this.id,
    this.userId,
    this.address,
    this.city,
    this.country,
    this.zip,
    this.phone,
    this.createdAt,
    this.updatedAt});

  ShippingAddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    zip = json['zip'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['address'] = this.address;
    data['city'] = this.city;
    data['country'] = this.country;
    data['zip'] = this.zip;
    data['phone'] = this.phone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}