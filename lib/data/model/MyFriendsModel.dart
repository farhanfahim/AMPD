class MyFriendsModel{
  List<Friends> friends;
  int pages;

  MyFriendsModel({this.friends, this.pages});

  MyFriendsModel.fromJson(Map<String, dynamic> json) {
    if (json['friends'] != null) {
      friends = new List<Friends>();
      json['friends'].forEach((v) {
        friends.add(new Friends.fromJson(v));
      });
    }
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.friends != null) {
      data['friends'] = this.friends.map((v) => v.toJson()).toList();
    }
    data['pages'] = this.pages;
    return data;
  }
}

class Friends {
  int id;
  int userId;
  int friendId;
  String createdAt;
  String updatedAt;
  Object deletedAt;
  String friendName;
  String friendImage;
  bool isSelected = false;
  bool canDelete = false;

  Friends(
      {
        this.id,
        this.userId,
        this.friendId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.friendName,
        this.isSelected,
        this.canDelete,
        this.friendImage});

  Friends.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    friendId = json['friend_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    friendName = json['friend_name'];
    friendImage = json['friend_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['friend_id'] = this.friendId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['friend_name'] = this.friendName;
    data['friend_image'] = this.friendImage;
    data['isSelected'] = this.isSelected;
    return data;
  }
}