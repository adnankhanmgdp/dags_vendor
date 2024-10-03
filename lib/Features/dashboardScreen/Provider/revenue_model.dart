class RevenueData {
  final dynamic dayOfWeek;
  final dynamic totalRevenue;
  final dynamic count;
  final dynamic date;
  final dynamic id;

  RevenueData({
    required this.dayOfWeek,
    required this.totalRevenue,
    required this.count,
    required this.date,
    this.id,
  });

  factory RevenueData.fromJson(Map<String, dynamic> json) {
    return RevenueData(
      dayOfWeek: json['dayOfWeek'],
      totalRevenue: json['totalRevenue'],
      count: json['count'],
      date: DateTime.parse(json['date']),
      id: json['_id'],
    );
  }

  static List<RevenueData> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => RevenueData.fromJson(json)).toList();
  }
}
