class CreateStoreModel {
  String name;
  String description;
  String address;
  double latitude;
  double longitude;
  String image;
  int userId;
  String updatedAt;
  String createdAt;
  int id;
  int totalReviews;

  CreateStoreModel(
      {this.name,
        this.description,
        this.address,
        this.latitude,
        this.longitude,
        this.image,
        this.userId,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.totalReviews});

  CreateStoreModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    image = json['image'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    totalReviews = json['total_reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['image'] = this.image;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['total_reviews'] = this.totalReviews;
    return data;
  }
}