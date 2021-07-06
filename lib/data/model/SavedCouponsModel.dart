

class SavedCouponsModel{
  List<SavedCoupons> savedCoupons;
  int pages;
  SavedCouponsModel({this.savedCoupons, this.pages});

}

class SavedCoupons {
  String name;
  String dateTime;
  String timeToAvail;
  String image;

  SavedCoupons(
      { this.name, this.dateTime, this.timeToAvail,this.image});
}