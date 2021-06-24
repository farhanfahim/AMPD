class PostCommentsModel {
  List<Comments> comments;
  int pages;

  PostCommentsModel({this.comments, this.pages});

  PostCommentsModel.fromJson(Map<String, dynamic> json) {
    if (json['comments'] != null) {
      comments = new List<Comments>();
      json['comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    data['pages'] = this.pages;
    return data;
  }
}

class Comments {
  int id;
  Object parentId;
  int userId;
  int repliedTo;
  int instanceId;
  int instanceType;
  String comments;
  Object likes;
  int isLiked;
  String ago;
  String image;
  String name;
  RepliedToUser repliedToUser;
  List<Tags> tags;

  Comments(
      {this.id,
        this.parentId,
        this.userId,
        this.repliedTo,
        this.instanceId,
        this.instanceType,
        this.comments,
        this.likes,
        this.ago,
        this.image,
        this.isLiked,
        this.name,
        this.repliedToUser,
        this.tags});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    userId = json['user_id'];
    repliedTo = json['replied_to'];
    instanceId = json['instance_id'];
    instanceType = json['instance_type'];
    comments = json['comments'];
    likes = json['likes'];
    ago = json['ago'];
    image = json['image'];
    name = json['name'];
    isLiked = json['is_liked'];
    repliedToUser = json['replied_to_user'] != null
        ? new RepliedToUser.fromJson(json['replied_to_user'])
        : null;
    if (json['tags'] != null) {
      tags = new List<Tags>();
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['user_id'] = this.userId;
    data['replied_to'] = this.repliedTo;
    data['instance_id'] = this.instanceId;
    data['instance_type'] = this.instanceType;
    data['comments'] = this.comments;
    data['likes'] = this.likes;
    data['ago'] = this.ago;
    data['image'] = this.image;
    data['name'] = this.name;
    data['is_liked'] = this.isLiked;
    if (this.repliedToUser != null) {
      data['replied_to_user'] = this.repliedToUser.toJson();
    }
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tags {
  int id;
  int userId;
  String userName;
  String userImage;

  Tags({this.id, this.userId, this.userName, this.userImage});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_image'] = this.userImage;
    return data;
  }
}

class RepliedToUser {
  String firstName;
  int id;
  int friendsCount;
  int teetimesCount;
  Object handicapes;

  RepliedToUser(
      {this.firstName,
        this.id,
        this.friendsCount,
        this.teetimesCount,
        this.handicapes});

  RepliedToUser.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    id = json['id'];
    friendsCount = json['friends_count'];
    teetimesCount = json['teetimes_count'];
    handicapes = json['handicapes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['id'] = this.id;
    data['friends_count'] = this.friendsCount;
    data['teetimes_count'] = this.teetimesCount;
    data['handicapes'] = this.handicapes;
    return data;
  }
}
