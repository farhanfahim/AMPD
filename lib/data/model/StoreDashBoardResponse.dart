class StoreDashBoardResponse{
  List<FeaturedStores> featuredStores;
  List<NewArrivals> newArrivals;
  List<MostSold> mostSold;

  StoreDashBoardResponse({this.featuredStores, this.newArrivals, this.mostSold});

  StoreDashBoardResponse.fromJson(Map<String, dynamic> json) {
    if (json['featured_stores'] != null) {
      featuredStores = new List<FeaturedStores>();
      json['featured_stores'].forEach((v) {
        featuredStores.add(new FeaturedStores.fromJson(v));
      });
    }
    if (json['new_arrivals'] != null) {
      newArrivals = new List<NewArrivals>();
      json['new_arrivals'].forEach((v) {
        newArrivals.add(new NewArrivals.fromJson(v));
      });
    }
    if (json['most_sold'] != null) {
      mostSold = new List<MostSold>();
      json['most_sold'].forEach((v) {
        mostSold.add(new MostSold.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.featuredStores != null) {
      data['featured_stores'] =
          this.featuredStores.map((v) => v.toJson()).toList();
    }
    if (this.newArrivals != null) {
      data['new_arrivals'] = this.newArrivals.map((v) => v.toJson()).toList();
    }
    if (this.mostSold != null) {
      data['most_sold'] = this.mostSold.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeaturedStores {
  int id;
  int userId;
  String name;
  String description;
  String address;
  double latitude;
  double longitude;
  Null startTime;
  Null endTime;
  bool featured;
  int inMenu;
  String image;
  String medium_image_url;
  String original_image_url;
  String createdAt;
  String updatedAt;
  int totalReviews;

  FeaturedStores(
      {this.id,
        this.userId,
        this.name,
        this.description,
        this.address,
        this.latitude,
        this.longitude,
        this.startTime,
        this.endTime,
        this.featured,
        this.inMenu,
        this.image,
        this.original_image_url,
        this.medium_image_url,
        this.createdAt,
        this.updatedAt,
        this.totalReviews,
      });

  FeaturedStores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    description = json['description'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    featured = json['featured'];
    inMenu = json['in_menu'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    medium_image_url = json['medium_image_url'];
    original_image_url = json['original_image_url'];
    totalReviews = json['total_reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['featured'] = this.featured;
    data['in_menu'] = this.inMenu;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['medium_image_url'] = this.medium_image_url;
    data['original_image_url'] = this.original_image_url;
    data['updated_at'] = this.updatedAt;
    data['total_reviews'] = this.totalReviews;

    return data;
  }
}

class NewArrivals {
  int id;
  int storeId;
  int userId;
  String featured_image;
  String name;
  Object price;
  int qty;
  int productType;
  String description;
  int categoryId;
  int subcategoryId;
  String sku;
  Null manageStock;
  int sold;
  String image;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  String categoryName;
  String subcategoryName;
  String storeName;
  String medium_image_url;
  String original_image_url;
  String aws_src;
  List<Attributes> attributes;

  NewArrivals(
      {this.id,
        this.featured_image,
        this.storeId,
        this.userId,
        this.name,
        this.price,
        this.qty,
        this.productType,
        this.description,
        this.categoryId,
        this.subcategoryId,
        this.sku,
        this.manageStock,
        this.sold,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.categoryName,
        this.original_image_url,
        this.medium_image_url,
        this.subcategoryName,
        this.aws_src,
        this.storeName,
        this.attributes});

  NewArrivals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    userId = json['user_id'];
    featured_image = json['featured_image'];
    name = json['name'];
    price = json['price'];
    qty = json['qty'];
    productType = json['product_type'];
    description = json['description'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    sku = json['sku'];
    manageStock = json['manage_stock'];
    sold = json['sold'];
    image = json['image'];
    medium_image_url = json['medium_image_url'];
    original_image_url = json['original_image_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    categoryName = json['category_name'];
    subcategoryName = json['subcategory_name'];
    aws_src = json['aws_src'];
    storeName = json['store_name'];
    if (json['attributes'] != null) {
      attributes = new List<Attributes>();
      json['attributes'].forEach((v) {
        attributes.add(new Attributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['featured_image'] = this.featured_image;
    data['store_id'] = this.storeId;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['qty'] = this.qty;
    data['product_type'] = this.productType;
    data['description'] = this.description;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['sku'] = this.sku;
    data['medium_image_url'] = this.medium_image_url;
    data['original_image_url'] = this.original_image_url;
    data['manage_stock'] = this.manageStock;
    data['sold'] = this.sold;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['category_name'] = this.categoryName;
    data['subcategory_name'] = this.subcategoryName;
    data['aws_src'] = this.aws_src;
    data['store_name'] = this.storeName;
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attributes {
  int id;
  int productId;
  int attributeId;
  int variantId;
  Null qty;

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

class MostSold {
  int id;
  int storeId;
  int userId;
  String name;
  String featured_image;
  Object price;
  int qty;
  int productType;
  String description;
  int categoryId;
  String medium_image_url;
  String original_image_url;
  String aws_src;
  int subcategoryId;
  String sku;
  bool manageStock;
  int sold;
  String image;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  String categoryName;
  String subcategoryName;
  String storeName;
  List<Attributes> attributes;

  MostSold(
      {this.id,
        this.storeId,
        this.userId,
        this.name,
        this.price,
        this.qty,
        this.productType,
        this.description,
        this.categoryId,
        this.featured_image,
        this.subcategoryId,
        this.sku,
        this.manageStock,
        this.sold,
        this.original_image_url,
        this.medium_image_url,
        this.aws_src,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.categoryName,
        this.subcategoryName,
        this.storeName,
        this.attributes});

  MostSold.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    featured_image = json['featured_image'];
    storeId = json['store_id'];
    userId = json['user_id'];
    name = json['name'];
    price = json['price'];
    medium_image_url = json['medium_image_url'];
    original_image_url = json['original_image_url'];
    aws_src = json['aws_src'];
    qty = json['qty'];
    productType = json['product_type'];
    description = json['description'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    sku = json['sku'];
    manageStock = json['manage_stock'];
    sold = json['sold'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    categoryName = json['category_name'];
    subcategoryName = json['subcategory_name'];
    storeName = json['store_name'];
    if (json['attributes'] != null) {
      attributes = new List<Attributes>();
      json['attributes'].forEach((v) {
        attributes.add(new Attributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['featured_image'] = this.featured_image;
    data['store_id'] = this.storeId;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['qty'] = this.qty;
    data['product_type'] = this.productType;
    data['description'] = this.description;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['aws_src'] = this.aws_src;
    data['sku'] = this.sku;
    data['manage_stock'] = this.manageStock;
    data['sold'] = this.sold;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['category_name'] = this.categoryName;
    data['subcategory_name'] = this.subcategoryName;
    data['store_name'] = this.storeName;
    data['medium_image_url'] = this.medium_image_url;
    data['original_image_url'] = this.original_image_url;
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}