class FriendRequestsModel{
  int id;
  int userId;
  Object handicape_id;
  Object handicape_name;
  String firstName;
  String image;

  FriendRequestsModel({this.id, this.userId, this.firstName, this.image});

  FriendRequestsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstName = json['first_name'];
    handicape_name = json['handicape_name'];
    handicape_id = json['handicape_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['handicape_name'] = this.handicape_name;
    data['handicape_id'] = this.handicape_id;
    data['image'] = this.image;
    return data;
  }
}