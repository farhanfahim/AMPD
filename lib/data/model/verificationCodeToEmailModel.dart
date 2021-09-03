class VerficationCodeToEmailModel {
  bool status;
  String message;
  List<Data> data;

  VerficationCodeToEmailModel({this.status, this.message, this.data});

  VerficationCodeToEmailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String message;
  String field;
  String validation;

  Data({this.message, this.field, this.validation});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    field = json['field'];
    validation = json['validation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['field'] = this.field;
    data['validation'] = this.validation;
    return data;
  }
}
