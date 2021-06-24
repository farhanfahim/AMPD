class MyPaymentMethod{
  int id;
  int userId;
  String name;
  String paymentMethodId;
  int lastFour;
  String brand;
  String country;
  int expMonth;
  int expYear;
  String createdAt;
  String updatedAt;
  Null deletedAt;

  MyPaymentMethod(
      {this.id,
        this.name,
        this.userId,
        this.paymentMethodId,
        this.lastFour,
        this.brand,
        this.country,
        this.expMonth,
        this.expYear,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  MyPaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    paymentMethodId = json['payment_method_id'];
    lastFour = json['last_four'];
    brand = json['brand'];
    country = json['country'];
    expMonth = json['exp_month'];
    expYear = json['exp_year'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['payment_method_id'] = this.paymentMethodId;
    data['last_four'] = this.lastFour;
    data['brand'] = this.brand;
    data['country'] = this.country;
    data['exp_month'] = this.expMonth;
    data['exp_year'] = this.expYear;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}