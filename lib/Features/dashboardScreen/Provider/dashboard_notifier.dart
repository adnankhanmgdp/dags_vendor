import 'package:dags/Common/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../Common/Services/global.dart';
import 'dashboard_model.dart';

class OrdersNotifier extends StateNotifier<OrdersData?> {
  OrdersNotifier() : super(null) {
    fetchOrders();
  }

  String url = AppConstants.serverApiUrl;

  Future<void> fetchOrders() async {
    try {
      final vendorId = Global.storageServices.getString(AppConstants.vendorId);

      Map<String, dynamic> data = {"vendorId": vendorId};

      final response = await http.post(Uri.parse('$url/vendor/api/dashboard'),
          headers: {'Content-Type': 'application/json; charset=utf-8'},
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("successfully hit the api... ");
        }
        final jsonResponse = json.decode(response.body);
        final ordersData = OrdersData.fromJson(jsonResponse);
        state = ordersData;
      } else {
        if (kDebugMode) {
          print(
              "Some error occurred while fetching vendors dashboard, status code -> ${response.statusCode}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("error is $e");
      }
    }
  }
}

final ordersProvider =
    StateNotifierProvider<OrdersNotifier, OrdersData?>((ref) {
  return OrdersNotifier();
});
