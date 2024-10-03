class OrdersData {
  final dynamic totalAmountToday;
  final dynamic totalCompletedOrders;
  final dynamic totalNoOfOrdersToday;
  final List<dynamic> todayOrders; // Define proper types if available
  final List<dynamic> previousDaysOrders; // Define proper types if available

  OrdersData({
    required this.totalAmountToday,
    required this.totalCompletedOrders,
    required this.todayOrders,
    required this.previousDaysOrders,
    required this.totalNoOfOrdersToday
  });

  factory OrdersData.fromJson(Map<String, dynamic> json) {
    return OrdersData(
      totalAmountToday: json['totalAmountToday'],
      totalCompletedOrders: json['totalCompletedOrders'],
      totalNoOfOrdersToday: json['totalNumberOfOrders'],
      todayOrders: List<dynamic>.from(json['todayOrders']),
      previousDaysOrders: List<dynamic>.from(json['previousDaysOrders']),
    );
  }
}
