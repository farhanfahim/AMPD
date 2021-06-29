

class NotificationsModel{
  List<Notifications> notification;
  int pages;
  NotificationsModel({this.notification, this.pages});

}

class Notifications {
  String name;
  String dateTime;
  String address;
  String image;

  Notifications(
      { this.name, this.dateTime, this.address,this.image});
}