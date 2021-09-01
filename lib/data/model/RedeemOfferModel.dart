class RedeemOfferModel {
  int id;
  int offerId;
  int userId;
  String redeemAt;
  int status;
  int isAvailable;
  String createdAt;
  String updatedAt;

  RedeemOfferModel(
      {this.id,
        this.offerId,
        this.userId,
        this.redeemAt,
        this.status,
        this.isAvailable,
        this.createdAt,
        this.updatedAt});

  RedeemOfferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    offerId = json['offer_id'];
    userId = json['user_id'];
    redeemAt = json['redeem_at'];
    status = json['status'];
    isAvailable = json['is_available'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['offer_id'] = this.offerId;
    data['user_id'] = this.userId;
    data['redeem_at'] = this.redeemAt;
    data['status'] = this.status;
    data['is_available'] = this.isAvailable;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}