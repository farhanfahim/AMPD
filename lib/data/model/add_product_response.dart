class AddProductResponse {
  int storeId;
  String name;
  Object price;
  String categoryId;
  String subcategoryId;
  int productType;
  String description;
  String sku;
  int userId;
  String updatedAt;
  String createdAt;
  int id;
  String categoryName;
  String subcategoryName;

  AddProductResponse(
      {this.storeId,
        this.name,
        this.price,
        this.categoryId,
        this.subcategoryId,
        this.productType,
        this.description,
        this.sku,
        this.userId,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.categoryName,
        this.subcategoryName});

  AddProductResponse.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    name = json['name'];
    price = json['price'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    productType = json['product_type'];
    description = json['description'];
    sku = json['sku'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    categoryName = json['category_name'];
    subcategoryName = json['subcategory_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_id'] = this.storeId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['product_type'] = this.productType;
    data['description'] = this.description;
    data['sku'] = this.sku;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['subcategory_name'] = this.subcategoryName;
    return data;
  }
}