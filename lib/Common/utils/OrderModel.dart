class Order {
  final dynamic id;
  final dynamic orderDate;
  final List<OrderStatus> orderStatus;
  final dynamic amount;
  final dynamic deliveryFee;
  final double vendorFee;
  final dynamic taxes;
  final dynamic paymentMode;
  final dynamic transactionId;
  final dynamic userId;
  final dynamic vendorId;
  final dynamic pickupDate;
  final dynamic deliveryDate;
  final List<dynamic> logisticId;
  final dynamic secretKey;
  final dynamic orderLocation;
  final List<Item> items;
  final List<dynamic>? orderPics;
  final dynamic notes;
  final dynamic orderId;
  final dynamic deliveryType;
  double? feedbackRating;
  String feedbackProvided;

  Order(
      {required this.id,
      required this.orderDate,
      required this.orderStatus,
      required this.amount,
      required this.deliveryFee,
      required this.vendorFee,
      required this.taxes,
      required this.paymentMode,
      required this.transactionId,
      required this.userId,
      required this.vendorId,
      required this.pickupDate,
      required this.deliveryDate,
      required this.logisticId,
      required this.secretKey,
      required this.orderLocation,
      required this.items,
      required this.orderPics,
      required this.notes,
      required this.orderId,
      required this.deliveryType,
      required this.feedbackRating,
      required this.feedbackProvided});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      orderDate: json['orderDate'],
      orderStatus: (json['orderStatus'] as List)
          .map((e) => OrderStatus.fromJson(e))
          .toList(),
      amount: json['amount'],
      deliveryFee: json['deliveryFee'],
      vendorFee: double.parse("${json['vendorFee']}"),
      taxes: json['taxes'],
      paymentMode: json['paymentMode'],
      transactionId: json['transactionId'],
      userId: json['userId'],
      vendorId: json['vendorId'],
      pickupDate: json['pickupDate'],
      deliveryDate: json['deliveryDate'],
      logisticId: json['logisticId'],
      secretKey: json['secretKey'],
      orderLocation: json['orderLocation'],
      items: (json['items'] as List).map((e) => Item.fromJson(e)).toList(),
      orderPics: json['orderPics'],
      notes: json['notes'],
      orderId: json['orderId'],
      deliveryType: json['deliveryType'],
      feedbackRating: double.parse(json['feedbackRating'] ?? '0'),
      feedbackProvided: json['feedbackProvided'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'orderDate': orderDate,
      'orderStatus': orderStatus.map((e) => e.toJson()).toList(),
      'amount': amount,
      'deliveryFee': deliveryFee,
      'vendorFee': vendorFee,
      'taxes': taxes,
      'paymentMode': paymentMode,
      'transactionId': transactionId,
      'userId': userId,
      'vendorId': vendorId,
      'pickupDate': pickupDate,
      'deliveryDate': deliveryDate,
      'logisticId': logisticId,
      'secretKey': secretKey,
      'orderLocation': orderLocation,
      'items': items.map((e) => e.toJson()).toList(),
      'orderPics': orderPics,
      'notes': notes,
      'orderId': orderId,
    };
  }
}

class OrderStatus {
  final dynamic status;
  final dynamic time;
  final dynamic id;

  OrderStatus({
    required this.status,
    required this.time,
    required this.id,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) {
    return OrderStatus(
      status: json['status'],
      time: json['time'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'time': time,
      '_id': id,
    };
  }
}

class Item {
  final dynamic serviceName;
  final dynamic itemName;
  final dynamic itemId;
  final dynamic serviceId;
  final dynamic unitPrice;
  final dynamic qty;
  final dynamic id;

  Item({
    required this.serviceName,
    required this.itemName,
    required this.itemId,
    required this.serviceId,
    required this.unitPrice,
    required this.qty,
    required this.id,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      serviceName: json['serviceNAME'],
      itemName: json['itemNAME'],
      itemId: json['itemId'],
      serviceId: json['serviceId'],
      unitPrice: json['unitPrice'],
      qty: json['qty'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceNAME': serviceName,
      'itemNAME': itemName,
      'itemId': itemId,
      'serviceId': serviceId,
      'unitPrice': unitPrice,
      'qty': qty,
      '_id': id,
    };
  }
}
