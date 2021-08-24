class RegisterResponseModel {
  bool status;
  Data data;
  String message;

  RegisterResponseModel({this.status, this.data, this.message});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String firstName;
  String lastName;
  String phone;
  String email;
  int isApproved;
  int isVerified;
  int radius;
  String createdAt;
  String updatedAt;
  int id;
  AccessToken accessToken;
  String imageUrl;

  Data(
      {this.firstName,
        this.lastName,
        this.phone,
        this.email,
        this.isApproved,
        this.isVerified,
        this.radius,
        this.createdAt,
        this.updatedAt,
        this.id,
        this.accessToken,
        this.imageUrl});

  Data.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    isApproved = json['is_approved'];
    isVerified = json['is_verified'];
    radius = json['radius'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    id = json['id'];
    accessToken = json['access_token'] != null
        ? new AccessToken.fromJson(json['access_token'])
        : null;
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['is_approved'] = this.isApproved;
    data['is_verified'] = this.isVerified;
    data['radius'] = this.radius;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['id'] = this.id;
    if (this.accessToken != null) {
      data['access_token'] = this.accessToken.toJson();
    }
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class AccessToken {
  String type;
  String token;
  String refreshToken;

  AccessToken({this.type, this.token, this.refreshToken});

  AccessToken.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}