import 'Products.dart';

class MostSellingProductsModel {
  List<Products> products;
  int pages;

  MostSellingProductsModel({this.products, this.pages});

  MostSellingProductsModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['pages'] = this.pages;
    return data;
  }
}

