class StoriesModel {
  List<MyStories> myStories;
  List<MyStories> otherStories;

  StoriesModel({this.myStories, this.otherStories});

  StoriesModel.fromJson(Map<String, dynamic> json) {
    if (json['myStories'] != null) {
      myStories = new List<MyStories>();
      json['myStories'].forEach((v) {
        myStories.add(new MyStories.fromJson(v));
      });
    }
    if (json['otherStories'] != null) {
      otherStories = new List<MyStories>();
      json['otherStories'].forEach((v) {
        otherStories.add(new MyStories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myStories != null) {
      data['myStories'] = this.myStories.map((v) => v.toJson()).toList();
    }
    if (this.otherStories != null) {
      data['otherStories'] = this.otherStories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyStories {
  int userId;
  String userName;
  String userImage;
  List<Stories> stories;

  MyStories({this.userId, this.userName, this.userImage, this.stories});

  MyStories.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userImage = json['user_image'];
    if (json['stories'] != null) {
      stories = new List<Stories>();
      json['stories'].forEach((v) {
        stories.add(new Stories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_image'] = this.userImage;
    if (this.stories != null) {
      data['stories'] = this.stories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stories {
  int id;
  int userId;
  String file;
  String mimeType;
  String thumbnail;
  String aws_thumbnail;
  String aws_src;
  String medium_image_url;
  String description;
  String videoDuration;
  String createdAt;
  String updatedAt;
  Object deletedAt;
  String firstName;
  String userImage;
  String createdAgo;

  Stories(
      {this.id,
        this.userId,
        this.file,
        this.mimeType,
        this.medium_image_url,
        this.aws_thumbnail,
        this.aws_src,
        this.thumbnail,
        this.description,
        this.videoDuration,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.firstName,
        this.userImage,
        this.createdAgo});

  Stories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    file = json['file'];
    mimeType = json['mime_type'];
    medium_image_url = json['medium_image_url'];
    aws_thumbnail = json['aws_thumbnail'];
    aws_src = json['aws_src'];
    thumbnail = json['thumbnail'];
    description = json['description'];
    videoDuration = json['video_duration'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    firstName = json['first_name'];
    userImage = json['user_image'];
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['file'] = this.file;
    data['mime_type'] = this.mimeType;
    data['thumbnail'] = this.thumbnail;
    data['description'] = this.description;
    data['aws_thumbnail'] = this.aws_thumbnail;
    data['video_duration'] = this.videoDuration;
    data['medium_image_url'] = this.medium_image_url;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['first_name'] = this.firstName;
    data['user_image'] = this.userImage;
    data['created_ago'] = this.createdAgo;
    return data;
  }
}
