import 'package:json_annotation/json_annotation.dart';

import 'OfferDataClassModel.dart';

@JsonSerializable()
class OfferModel {
  bool status;
  String message;
  Data data;

  OfferModel({this.status, this.message, this.data});

  OfferModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  int total;
  int perPage;
  int page;
  int lastPage;
  @JsonKey(name: 'data')
  List<Dataclass> dataclass;

  Data({this.total, this.perPage, this.page, this.lastPage, this.dataclass});

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['perPage'];
    page = json['page'];
    lastPage = json['lastPage'];
    if (json['data'] != null) {
      dataclass = new List<Dataclass>();
      json['data'].forEach((v) {
        dataclass.add(new Dataclass.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['perPage'] = this.perPage;
    data['page'] = this.page;
    data['lastPage'] = this.lastPage;
    if (this.dataclass != null) {
      data['data'] = this.dataclass.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
