class SettlementHistory {
  final String message;
  final List<History> history;
  final List<DueAmount> dueAmount;
  final List<TotalAmount> totalAmount;
  final double amountEarned;

  SettlementHistory({
    required this.message,
    required this.history,
    required this.dueAmount,
    required this.totalAmount,
    required this.amountEarned,
  });

  factory SettlementHistory.fromJson(Map<String, dynamic> json) {
    return SettlementHistory(
      message: json['message'],
      history: (json['history'] as List)
          .map((historyItem) => History.fromJson(historyItem))
          .toList(),
      dueAmount: (json['dueAmount'] as List)
          .map((dueAmountItem) => DueAmount.fromJson(dueAmountItem))
          .toList(),
      totalAmount: (json['totalAmount'] as List)
          .map((totalAmountItem) => TotalAmount.fromJson(totalAmountItem))
          .toList(),
      amountEarned: json['amountEarned'].toDouble(),
    );
  }
}

class History {
  final String id;
  final String orderId;
  final double amount;
  final List<String> orderIds;
  final DateTime date;

  History({
    required this.id,
    required this.orderId,
    required this.amount,
    required this.orderIds,
    required this.date,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      id: json['_id'],
      orderId: json['Id'],
      amount: json['amount'].toDouble(),
      orderIds: List<String>.from(json['orderIds']),
      date: DateTime.parse(json['date']),
    );
  }
}

class DueAmount {
  final String? id;
  final double totalAmount;

  DueAmount({required this.id, required this.totalAmount});

  factory DueAmount.fromJson(Map<String, dynamic> json) {
    return DueAmount(
      id: json['_id'],
      totalAmount: json['totalAmount'].toDouble(),
    );
  }
}

class TotalAmount {
  final String? id;
  final double totalAmount;

  TotalAmount({required this.id, required this.totalAmount});

  factory TotalAmount.fromJson(Map<String, dynamic> json) {
    return TotalAmount(
      id: json['_id'],
      totalAmount: json['totalAmount'].toDouble(),
    );
  }
}
