class CategoriesResponse {
  int id;
  int parentId;
  String name;
  String image;
  String createdAt;
  String updatedAt;
  String deletedAt;
  List<Subcategories> subcategories;

  CategoriesResponse(
      {this.id,
        this.parentId,
        this.name,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.subcategories});

  CategoriesResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['subcategories'] != null) {
      subcategories = new List<Subcategories>();
      json['subcategories'].forEach((v) {
        subcategories.add(new Subcategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.subcategories != null) {
      data['subcategories'] =
          this.subcategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategories {
  int id;
  String name;

  Subcategories({this.id, this.name});

  Subcategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
