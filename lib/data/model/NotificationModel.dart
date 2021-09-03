class NotificationModel {
  int total;
  int perPage;
  int page;
  int lastPage;
  List<Data> data;

  NotificationModel(
      {this.total, this.perPage, this.page, this.lastPage, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['perPage'];
    page = json['page'];
    lastPage = json['lastPage'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['perPage'] = this.perPage;
    data['page'] = this.page;
    data['lastPage'] = this.lastPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  int notifiableId;
  String title;
  String message;
  int refId;
  int type;
  Null image;
  Null readAt;
  String createdAt;
  String updatedAt;
  String imageUrl;

  Data(
      {this.id,
        this.notifiableId,
        this.title,
        this.message,
        this.refId,
        this.type,
        this.image,
        this.readAt,
        this.createdAt,
        this.updatedAt,
        this.imageUrl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notifiableId = json['notifiable_id'];
    title = json['title'];
    message = json['message'];
    refId = json['ref_id'];
    type = json['type'];
    image = json['image'];
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['notifiable_id'] = this.notifiableId;
    data['title'] = this.title;
    data['message'] = this.message;
    data['ref_id'] = this.refId;
    data['type'] = this.type;
    data['image'] = this.image;
    data['read_at'] = this.readAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_url'] = this.imageUrl;
    return data;
  }
}