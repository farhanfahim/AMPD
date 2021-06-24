import 'VariantsModel.dart';
import 'categories_response.dart';

class MainProductDataResponse{

  List<CategoriesResponse> categories;
  List<VariantsModel> variants;

  MainProductDataResponse({this.categories, this.variants});

  MainProductDataResponse.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = new List<CategoriesResponse>();
      json['categories'].forEach((v) {
        categories.add(new CategoriesResponse.fromJson(v));
      });
    }
    if (json['variants'] != null) {
      variants = new List<VariantsModel>();
      json['variants'].forEach((v) {
        variants.add(new VariantsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    if (this.variants != null) {
      data['variants'] = this.variants.map((v) => v.toJson()).toList();
    }
    return data;
  }
}