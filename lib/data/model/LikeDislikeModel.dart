class LikeDislikeModel {
  bool status;
  String message;
  Data data;

  LikeDislikeModel({this.status, this.message, this.data});

  LikeDislikeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String offerId;
  int status;
  int userId;
  String createdAt;
  String updatedAt;
  int id;

  Data(
      {this.offerId,
        this.status,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
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