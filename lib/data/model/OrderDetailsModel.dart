class OrderDetailsModel{
  Order order;
  Items items;

  OrderDetailsModel({this.order, this.items});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    items = json['items'] != null ? new Items.fromJson(json['items']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items.toJson();
    }
    return data;
  }
}

class Order {
  int id;
  String orderNo;
  int userId;
  Object subtotal;
  Object total;
  Object address;
  Object address2;
  Object country;
  Object state;
  Object zip;
  Object sameShippingAddr;
  String shippingAddress;
  String shippingCountry;
  Object shippingState;
  String shippingCity;
  Object phone;
  int paymentMethod;
  int paymentStatus;
  int orderStatus;
  Object gatewayResponse;
  String createdAt;
  String updatedAt;
  Object deletedAt;

  Order(
      {this.id,
        this.orderNo,
        this.userId,
        this.subtotal,
        this.total,
        this.address,
        this.address2,
        this.country,
        this.state,
        this.zip,
        this.sameShippingAddr,
        this.shippingAddress,
        this.shippingCountry,
        this.shippingState,
        this.shippingCity,
        this.phone,
        this.paymentMethod,
        this.paymentStatus,
        this.orderStatus,
        this.gatewayResponse,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNo = json['order_no'];
    userId = json['user_id'];
    subtotal = json['subtotal'];
    total = json['total'];
    address = json['address'];
    address2 = json['address_2'];
    country = json['country'];
    state = json['state'];
    zip = json['zip'];
    sameShippingAddr = json['same_shipping_addr'];
    shippingAddress = json['shipping_address'];
    shippingCountry = json['shipping_country'];
    shippingState = json['shipping_state'];
    shippingCity = json['shipping_city'];
    phone = json['phone'];
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    gatewayResponse = json['gateway_response'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_no'] = this.orderNo;
    data['user_id'] = this.userId;
    data['subtotal'] = this.subtotal;
    data['total'] = this.total;
    data['address'] = this.address;
    data['address_2'] = this.address2;
    data['country'] = this.country;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['same_shipping_addr'] = this.sameShippingAddr;
    data['shipping_address'] = this.shippingAddress;
    data['shipping_country'] = this.shippingCountry;
    data['shipping_state'] = this.shippingState;
    data['shipping_city'] = this.shippingCity;
    data['phone'] = this.phone;
    data['payment_method'] = this.paymentMethod;
    data['payment_status'] = this.paymentStatus;
    data['order_status'] = this.orderStatus;
    data['gateway_response'] = this.gatewayResponse;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Items {
  Object total;
  List<Stores> stores;

  Items({this.total, this.stores});

  Items.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['stores'] != null) {
      stores = new List<Stores>();
      json['stores'].forEach((v) {
        stores.add(new Stores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.stores != null) {
      data['stores'] = this.stores.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stores {
  bool refund_requested;
  bool is_reviewed;
  int storeId;
  String storeName;
  Object total;
  int orderStatus;
  String orderStatusText;
  List<Products> products;

  Stores(
      {this.storeId,
        this.storeName,
        this.is_reviewed,
        this.total,
        this.orderStatus,
        this.orderStatusText,
        this.products});

  Stores.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    storeName = json['store_name'];
    is_reviewed = json['is_reviewed'];
    refund_requested = json['refund_requested'];
    total = json['total'];
    orderStatus = json['order_status'];
    orderStatusText = json['order_status_text'];
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
    data['refund_requested'] = this.refund_requested;
    data['is_reviewed'] = this.is_reviewed;
    data['store_name'] = this.storeName;
    data['total'] = this.total;
    data['order_status'] = this.orderStatus;
    data['order_status_text'] = this.orderStatusText;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int id;
  int orderId;
  int storeId;
  int productId;
  String productTitle;
  String image;
  String description;
  Object price;
  int qty;
  int status;
  String attributeName;
  String variantName;

  Products(
      {this.id,
        this.orderId,
        this.storeId,
        this.productId,
        this.productTitle,
        this.image,
        this.price,
        this.description,
        this.qty,
        this.status,
        this.attributeName,
        this.variantName});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    storeId = json['store_id'];
    image = json['image'];
    description = json['description'];
    productId = json['product_id'];
    productTitle = json['product_title'];
    price = json['price'];
    qty = json['qty'];

    status = json['status'];
    attributeName = json['attribute_name'];
    variantName = json['variant_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['description'] = this.description;
    data['image'] = this.image;
    data['store_id'] = this.storeId;
    data['product_id'] = this.productId;
    data['product_title'] = this.productTitle;
    data['price'] = this.price;
    data['qty'] = this.qty;

    data['status'] = this.status;
    data['attribute_name'] = this.attributeName;
    data['variant_name'] = this.variantName;
    return data;
  }
}
