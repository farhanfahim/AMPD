class MyStoreOrderRequestsModel{
  List<OrderRequests> orderRequests;
  int pages;

  MyStoreOrderRequestsModel({this.orderRequests, this.pages});

  MyStoreOrderRequestsModel.fromJson(Map<String, dynamic> json) {
    if (json['order_requests'] != null) {
      orderRequests = new List<OrderRequests>();
      json['order_requests'].forEach((v) {
        orderRequests.add(new OrderRequests.fromJson(v));
      });
    }
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderRequests != null) {
      data['order_requests'] =
          this.orderRequests.map((v) => v.toJson()).toList();
    }
    data['pages'] = this.pages;
    return data;
  }
}

class OrderRequests {
  String date;
  List<Orders> orders;

  OrderRequests({this.date, this.orders});

  OrderRequests.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['orders'] != null) {
      orders = new List<Orders>();
      json['orders'].forEach((v) {
        orders.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
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
  Object shippingAddress;
  Object shippingCountry;
  Object shippingState;
  Object shippingCity;
  Object phone;
  Object note;
  int paymentMethod;
  int paymentStatus;
  int orderStatus;
  int requestStatus;
  Object gatewayResponse;
  String createdAt;
  String updatedAt;
  String date;
  String requestStatusText;

  Orders(
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
        this.date,
        this.requestStatusText});

  Orders.fromJson(Map<String, dynamic> json) {
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
    date = json['date'];
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
    data['date'] = this.date;
    data['request_status_text'] = this.requestStatusText;
    return data;
  }
}