class Reviews {
  int id;
  int userId;
  int storeId;
  String reviews;
  String createdAt;
  String updatedAt;
  String reviewer;
  String image;
  String time;

  Reviews(
      {this.id,
        this.userId,
        this.storeId,
        this.reviews,
        this.createdAt,
        this.updatedAt,
        this.reviewer,
        this.image,
        this.time});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    storeId = json['store_id'];
    reviews = json['reviews'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    reviewer = json['reviewer'];
    image = json['image'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['store_id'] = this.storeId;
    data['reviews'] = this.reviews;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['reviewer'] = this.reviewer;
    data['image'] = this.image;
    data['time'] = this.time;
    return data;
  }
}
