import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Common/Services/global.dart';
import '../../../Common/utils/OrderModel.dart';
import 'package:http/http.dart' as http;

import '../../../Common/utils/app_colors.dart';
import '../../../Common/utils/constants.dart';

class ScannerNotifier extends StateNotifier<Order?> {
  ScannerNotifier() : super(null);

  Future<void> updateOrderStatus(String secretKey) async {
    try {
      final vendorId = Global.storageServices.getString(AppConstants.vendorId);
      if (kDebugMode) {
        print(vendorId);
      }
      if (kDebugMode) {
        print('secretKey is ->$secretKey');
      }
      final response = await http.post(
          Uri.parse('https://dagstechnology.in/vendor/api/acceptOrder'),
          body: jsonEncode({'vendorId': vendorId, 'secretKey': secretKey}),
          headers: {'Content-Type': 'application/json; charset=utf-8'});

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('inside  nice block');
        }
        final order = jsonDecode(response.body)['order'];
        state = Order.fromJson(order);
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(
            msg: "Vendor not found",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (response.statusCode == 403) {
        Fluttertoast.showToast(
            msg: "Order does not belong to you.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(
            msg: "Secret key is not valid, Please scan another order.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(
            msg: "Could not scan this order at this time.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        throw Exception('Failed to update status');
      }
    } catch (e) {
      if (kDebugMode) {
        print("error occurred while updating status-> $e");
      }
    }
  }
}

final scannerProvider = StateNotifierProvider<ScannerNotifier, Order?>((ref) {
  return ScannerNotifier();
});
