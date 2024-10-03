import 'package:dags/Common/utils/constants.dart';
import 'package:dags/Features/AccountsScreen/provider/vendor_profile_data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../Common/Services/global.dart';

// Define the Notifier
class VendorNotifier extends StateNotifier<Vendor?> {
  VendorNotifier() : super(null) {
    fetchVendorProfile();
  }

  final url = AppConstants.serverApiUrl;

  Future<void> fetchVendorProfile() async {
    try {
      final vendorId = Global.storageServices.getString(AppConstants.vendorId);
      final phoneNumber =
          Global.storageServices.getString(AppConstants.userPhoneNumber);
      Map<String, dynamic> data = {'phone': phoneNumber, 'vendorId': vendorId};
      final response = await http.post(
          Uri.parse('$url/vendor/api/fetchProfile'),
          headers: {'Content-Type': 'application/json; charset=utf-8'},
          body: jsonEncode(data));
      if (kDebugMode) {
        print(jsonDecode(response.body));
      }
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        final vendor = Vendor.fromJson(responseData);
        state = vendor;
      } else {
        if (kDebugMode) {
          print("Error occurred while fetching vendor profile");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("error while fetching profile is-> $e");
      }
    }
  }
}

// Define the provider
final vendorProvider = StateNotifierProvider<VendorNotifier, Vendor?>((ref) {
  return VendorNotifier();
});
