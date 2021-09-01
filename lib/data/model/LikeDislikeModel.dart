class LikeDislikeModel {
  String offerId;
  int status;
  int userId;
  String createdAt;
  String updatedAt;
  int id;

  LikeDislikeModel(
      {this.offerId,
        this.status,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.id});

  LikeDislikeModel.fromJson(Map<String, dynamic> json) {
    offerId = json['offer_id'];
    status = json['status'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offer_id'] = this.offerId;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}