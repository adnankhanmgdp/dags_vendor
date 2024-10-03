import 'package:dags/Common/AppRoutes/appRoutes.dart';
import 'package:dags/Common/Services/global.dart';
import 'package:dags/Common/utils/constants.dart';
import 'package:dags/Features/TransactionScreen/Provider/settlement_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SettlementHistoryNotifier extends StateNotifier<SettlementHistory?> {
  SettlementHistoryNotifier() : super(null);

  Future<void> fetchSettlementHistory() async {
    try {
      final vendorId = Global.storageServices.getString(AppConstants.vendorId);
      final response = await http.post(
          Uri.parse('https://dagstechnology.in/vendor/api/settlement'),
          body: jsonEncode({'vendorId': vendorId}),
          headers: {'Content-Type': 'application/json; charset=utf-8'});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (kDebugMode) print(data);
        state = SettlementHistory.fromJson(data);
      } else {
        state = null;
        throw Exception('Failed to load settlement history');
      }
    } catch (e) {
      if (kDebugMode) {
        print('error occurred while getting settlement history -> $e');
      }
    }
  }
}

final settlementHistoryProvider =
    StateNotifierProvider<SettlementHistoryNotifier, SettlementHistory?>((ref) {
  return SettlementHistoryNotifier();
});
