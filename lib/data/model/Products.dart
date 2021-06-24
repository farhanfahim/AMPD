import 'VariantsModel.dart';

class Products {
  int id;
  int storeId;
  int userId;
  String name;
  String featured_image;
  Object price;
  int status;
  int qty;
  int productType;
  String description;
  int categoryId;
  int subcategoryId;
  String sku;
  Object manageStock;
  int sold;
  String image;
  String createdAt;
  String updatedAt;
  Object deletedAt;
  String categoryName;
  String subcategoryName;
  String storeName;
  List<VariantsModel> attributes;
  List<Attachments> attachments;

  Products({this.id,
    this.storeId,
    this.featured_image,
    this.userId,
    this.name,
    this.price,
    this.qty,
    this.productType,
    this.description,
    this.categoryId,
    this.subcategoryId,
    this.sku,
    this.status,
    // this.sold,
    this.image,
    // this.createdAt,
    // this.updatedAt,
    // this.deletedAt,
    this.categoryName,
    this.subcategoryName,
    this.storeName,
    this.attributes,
    this.attachments});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    featured_image = json['featured_image'];
    userId = json['user_id'];
    name = json['name'];
    price = json['price'];
    qty = json['qty'];
    productType = json['product_type'];
    description = json['description'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    sku = json['sku'];
    status = json['status'];
    // sold = json['sold'];
    image = json['image'];
    // createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
    // deletedAt = json['deleted_at'];
    categoryName = json['category_name'];
    subcategoryName = json['subcategory_name'];
    storeName = json['store_name'];
    if (json['attributes'] != null) {
      attributes = new List<VariantsModel>();
      json['attributes'].forEach((v) {
        attributes.add(new VariantsModel.fromJson(v));
      });
    }
    if (json['attachments'] != null) {
      attachments = new List<Attachments>();
      json['attachments'].forEach((v) {
        attachments.add(new Attachments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['featured_image'] = this.featured_image;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['qty'] = this.qty;
    data['product_type'] = this.productType;
    data['description'] = this.description;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['sku'] = this.sku;
    data['status'] = this.status;
    // data['sold'] = this.sold;
    data['image'] = this.image;
    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    // data['deleted_at'] = this.deletedAt;
    data['category_name'] = this.categoryName;
    data['subcategory_name'] = this.subcategoryName;
    data['store_name'] = this.storeName;
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    if (this.attachments != null) {
      data['attachments'] = this.attachments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Attributes {
  int id;
  int productId;
  int attributeId;
  int variantId;
  Object qty;

  Attributes(
      {this.id, this.productId, this.attributeId, this.variantId, this.qty});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    attributeId = json['attribute_id'];
    variantId = json['variant_id'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['attribute_id'] = this.attributeId;
    data['variant_id'] = this.variantId;
    data['qty'] = this.qty;
    return data;
  }
}

class Attachments {
  int id;
  String small_image_url;
  String medium_image_url;
  String original_image_url;
  String aws_src;
  int instanceId;
  int instanceType;
  String mimeType;
  String file;
  String likes;
  Object createdAt;
  Object updatedAt;
  Object deletedAt;
  String imageUrl;

  Attachments(
      {this.id,
        this.original_image_url,
        this.small_image_url,
        this.medium_image_url,
        this.aws_src,
        this.instanceId,
        this.instanceType,
        this.mimeType,
        this.file,
        this.likes,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.imageUrl});

  Attachments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    small_image_url = json['small_image_url'];
    medium_image_url = json['medium_image_url'];
    original_image_url = json['original_image_url'];
    aws_src = json['aws_src'];
    instanceId = json['instance_id'];
    instanceType = json['instance_type'];
    mimeType = json['mime_type'];
    file = json['file'];
    likes = json['likes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['small_image_url'] = this.small_image_url;
    data['medium_image_url'] = this.medium_image_url;
    data['original_image_url'] = this.original_image_url;
    data['aws_src'] = this.aws_src;
    data['instance_id'] = this.instanceId;
    data['instance_type'] = this.instanceType;
    data['mime_type'] = this.mimeType;
    data['file'] = this.file;
    data['likes'] = this.likes;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['image_url'] = this.imageUrl;
    return data;
  }
}

