class CartModel{
  Object total;
  Object sales_tax;
  List<CartItemsModel> items;

  CartModel({this.total, this.items});

  CartModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    sales_tax = json['sales_tax'];
    if (json['items'] != null) {
      items = new List<CartItemsModel>();
      json['items'].forEach((v) {
        items.add(new CartItemsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['sales_tax'] = this.sales_tax;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartItemsModel{
  int storeId;
  String storeName;
  List<Products> products;

  CartItemsModel({this.storeId, this.storeName, this.products});

  CartItemsModel.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    storeName = json['store_name'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_id'] = this.storeId;
    data['store_name'] = this.storeName;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int id;
  int userId;
  int storeId;
  int productId;
  int attributeId;
  int variantId;
  int qty;
  String description;
  String createdAt;
  String image;
  String updatedAt;
  String storeName;
  String productName;
  String attributeName;
  String variantName;
  Object price;

  Products(
      {this.id,
        this.userId,
        this.storeId,
        this.image,
        this.productId,
        this.attributeId,
        this.description,
        this.variantId,
        this.qty,
        this.createdAt,
        this.updatedAt,
        this.storeName,
        this.productName,
        this.price,
        this.attributeName,
        this.variantName});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    userId = json['user_id'];
    storeId = json['store_id'];
    productId = json['product_id'];
    attributeId = json['attribute_id'];
    variantId = json['variant_id'];
    description = json['description'];
    qty = json['qty'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    storeName = json['store_name'];
    productName = json['product_name'];
    price = json['price'];
    attributeName = json['attribute_name'];
    variantName = json['variant_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['user_id'] = this.userId;
    data['store_id'] = this.storeId;
    data['description'] = this.description;
    data['product_id'] = this.productId;
    data['attribute_id'] = this.attributeId;
    data['variant_id'] = this.variantId;
    data['qty'] = this.qty;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['store_name'] = this.storeName;
    data['product_name'] = this.productName;
    data['price'] = this.price;
    data['attribute_name'] = this.attributeName;
    data['variant_name'] = this.variantName;
    return data;
  }
}