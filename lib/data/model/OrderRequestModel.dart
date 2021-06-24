class OrderRequestModel {
  OrderRequest orderRequest;
  List<OrderRequestItems> orderRequestItems;

  OrderRequestModel({this.orderRequest, this.orderRequestItems});

  OrderRequestModel.fromJson(Map<String, dynamic> json) {
    orderRequest = json['order_request'] != null
        ? new OrderRequest.fromJson(json['order_request'])
        : null;
    if (json['order_request_items'] != null) {
      orderRequestItems = new List<OrderRequestItems>();
      json['order_request_items'].forEach((v) {
        orderRequestItems.add(new OrderRequestItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderRequest != null) {
      data['order_request'] = this.orderRequest.toJson();
    }
    if (this.orderRequestItems != null) {
      data['order_request_items'] =
          this.orderRequestItems.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderRequest {
  int id;
  String orderNo;
  int storeId;
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
  String phone;
  String note;
  int paymentMethod;
  int paymentStatus;
  int orderStatus;
  int requestStatus;
  Object gatewayResponse;
  String createdAt;
  String updatedAt;
  String customer;
  String requestStatusText;

  OrderRequest(
      {this.id,
      this.orderNo,
      this.storeId,
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
      this.note,
      this.paymentMethod,
      this.paymentStatus,
      this.orderStatus,
      this.requestStatus,
      this.gatewayResponse,
      this.createdAt,
      this.updatedAt,
      this.customer,
      this.requestStatusText});

  OrderRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNo = json['order_no'];
    storeId = json['store_id'];
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
    note = json['note'];
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    requestStatus = json['request_status'];
    gatewayResponse = json['gateway_response'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer = json['customer'];
    requestStatusText = json['request_status_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_no'] = this.orderNo;
    data['store_id'] = this.storeId;
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
    data['note'] = this.note;
    data['payment_method'] = this.paymentMethod;
    data['payment_status'] = this.paymentStatus;
    data['order_status'] = this.orderStatus;
    data['request_status'] = this.requestStatus;
    data['gateway_response'] = this.gatewayResponse;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['customer'] = this.customer;
    data['request_status_text'] = this.requestStatusText;
    return data;
  }
}

class OrderRequestItems {
  int id;
  int orderRequestId;
  int productId;
  String productTitle;
  Object price;
  int qty;
  Attributes attributes;
  String image;
  String description;
  String attributeName;
  String variantName;

  OrderRequestItems(
      {this.id,
      this.orderRequestId,
      this.productId,
      this.productTitle,
      this.price,
      this.qty,
      this.attributes,
      this.image,
      this.description,
      this.attributeName,
      this.variantName});

  OrderRequestItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderRequestId = json['order_request_id'];
    productId = json['product_id'];
    productTitle = json['product_title'];
    price = json['price'];
    qty = json['qty'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
    image = json['image'];
    description = json['description'];
    attributeName = json['attribute_name'];
    variantName = json['variant_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_request_id'] = this.orderRequestId;
    data['product_id'] = this.productId;
    data['product_title'] = this.productTitle;
    data['price'] = this.price;
    data['qty'] = this.qty;
    if (this.attributes != null) {
      data['attributes'] = this.attributes.toJson();
    }
    data['image'] = this.image;
    data['description'] = this.description;
    data['attribute_name'] = this.attributeName;
    data['variant_name'] = this.variantName;
    return data;
  }
}

class Attributes {
  Attribute attribute;
  Attribute variant;

  Attributes({this.attribute, this.variant});

  Attributes.fromJson(Map<String, dynamic> json) {
    attribute = json['attribute'] != null
        ? new Attribute.fromJson(json['attribute'])
        : null;
    variant = json['variant'] != null
        ? new Attribute.fromJson(json['variant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attribute != null) {
      data['attribute'] = this.attribute.toJson();
    }
    if (this.variant != null) {
      data['variant'] = this.variant.toJson();
    }
    return data;
  }
}

class Attribute {
  int id;
  String displayName;

  Attribute({this.id, this.displayName});

  Attribute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['display_name'] = this.displayName;
    return data;
  }
}
