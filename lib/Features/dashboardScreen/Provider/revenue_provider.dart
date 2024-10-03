import 'dart:convert';

import 'package:dags/Common/utils/constants.dart';
import 'package:dags/Features/dashboardScreen/Provider/revenue_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../Common/Services/global.dart';

final revenueProvider =
    StateNotifierProvider<RevenueNotifier, List<RevenueData>>((ref) {
  return RevenueNotifier();
});

class RevenueNotifier extends StateNotifier<List<RevenueData>> {
  RevenueNotifier() : super([]);

  Future<void> fetchRevenueData(DateTime startDate, DateTime endDate) async {
    try {
      final actualStartDate = startDate.toUtc().toIso8601String();
      final actualEndDate = endDate.toUtc().toIso8601String();
      final vendorId = Global.storageServices.getString(AppConstants.vendorId);

      final response = await http
          .post(Uri.parse('https://dagstechnology.in/vendor/api/week'),
              body: jsonEncode({
                'vendorId': vendorId,
                'startDate': actualStartDate, //actualStartDate,
                'endDate': actualEndDate //actualEndDate
              }),
              headers: {'Content-Type': 'application/json; charset=utf-8'});

      final jsonRes = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Fetched graph successfully');
          print(jsonRes);
        }
        final data = jsonRes
            as List<dynamic>; // Ensure jsonRes is treated as List<dynamic>
        state = RevenueData.fromJsonList(
            data); // Assuming data is a list of RevenueData JSON objects
      } else {
        throw Exception('Failed to load revenue data');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error occurred while fetching revenue data -> $e");
      }
    }
  }
}
