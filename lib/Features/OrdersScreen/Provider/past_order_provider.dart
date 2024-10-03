import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../Common/Services/global.dart';
import '../../../Common/utils/OrderModel.dart';
import '../../../Common/utils/constants.dart';

class PastOrderNotifier extends StateNotifier<List<Order>> {
  PastOrderNotifier() : super([]);

  Future<void> fetchPastOrders() async {
    try {
      final vendorId = Global.storageServices.getString(AppConstants.vendorId);
      if (kDebugMode) {
        print('in past orders api');
      }
      final response = await http
          .post(Uri.parse('https://dagstechnology.in/vendor/api/pastOrders'),
              body: jsonEncode(
                {'vendorId': vendorId},
              ),
              headers: {'Content-Type': 'application/json; charset=utf-8'});
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['orders'];
        state = data.map((orderJson) => Order.fromJson(orderJson)).toList();
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      if (kDebugMode) {
        print('error occurred while getting past orders -> $e');
      }
    }
  }
}

final pastOrderProvider =
    StateNotifierProvider<PastOrderNotifier, List<Order>>((ref) {
  return PastOrderNotifier();
});
