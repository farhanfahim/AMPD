import 'OfferDataClassModel.dart';

class SingleOfferModel {
  bool status;
  String message;
  Dataclass data;

  SingleOfferModel({this.status, this.message, this.data});

  SingleOfferModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Dataclass.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}


class Meta {
  int isReviewed;

  Meta({this.isReviewed});

  Meta.fromJson(Map<String, dynamic> json) {
    isReviewed = json['is_reviewed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_reviewed'] = this.isReviewed;
    return data;
  }
}