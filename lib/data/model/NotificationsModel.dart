class NotificationsModel{
  List<Notifications> notifications;
  int pages;

  NotificationsModel({this.notifications, this.pages});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = new List<Notifications>();
      json['notifications'].forEach((v) {
        notifications.add(new Notifications.fromJson(v));
      });
    }
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications.map((v) => v.toJson()).toList();
    }
    data['pages'] = this.pages;
    return data;
  }
}

class Notifications {
  int senderId;
  int refId;
  String message;
  String metaType;
  String image;
  String ago;

  Notifications(
      {this.senderId, this.refId, this.message, this.metaType, this.image});

  Notifications.fromJson(Map<String, dynamic> json) {
    senderId = json['sender_id'];
    refId = json['ref_id'];
    message = json['message'];
    metaType = json['meta_type'];
    image = json['image'];
    ago = json['ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender_id'] = this.senderId;
    data['ref_id'] = this.refId;
    data['message'] = this.message;
    data['meta_type'] = this.metaType;
    data['image'] = this.image;
    data['ago'] = this.ago;
    return data;
  }
}