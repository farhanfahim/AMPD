class MyOrdersModel {
  List<Orders> orders;
  int pages;

  MyOrdersModel({this.orders, this.pages});

  MyOrdersModel.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = new List<Orders>();
      json['orders'].forEach((v) {
        orders.add(new Orders.fromJson(v));
      });
    }
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    data['pages'] = this.pages;
    return data;
  }
}

  class Orders {
    int id;
    String orderNo;
    int userId;
    Object subtotal;
    Object total;
    int paymentMethod;
    int paymentStatus;
    int orderStatus;
    Object gatewayResponse;
    String createdAt;
    String updatedAt;

    Orders({this.id,
      this.orderNo,
      this.userId,
      this.subtotal,
      this.total,

      this.paymentMethod,
      this.paymentStatus,
      this.orderStatus,
      this.gatewayResponse,
      this.createdAt,
      this.updatedAt,
    });

    Orders.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      orderNo = json['order_no'];
      userId = json['user_id'];
      subtotal = json['subtotal'];
      total = json['total'];
      paymentMethod = json['payment_method'];
      paymentStatus = json['payment_status'];
      orderStatus = json['order_status'];
      gatewayResponse = json['gateway_response'];
      createdAt = json['created_at'];
      updatedAt = json['updated_at'];
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['id'] = this.id;
      data['order_no'] = this.orderNo;
      data['user_id'] = this.userId;
      data['subtotal'] = this.subtotal;
      data['total'] = this.total;
      data['payment_method'] = this.paymentMethod;
      data['payment_status'] = this.paymentStatus;
      data['order_status'] = this.orderStatus;
      data['gateway_response'] = this.gatewayResponse;
      data['created_at'] = this.createdAt;
      data['updated_at'] = this.updatedAt;
      return data;
    }
  }