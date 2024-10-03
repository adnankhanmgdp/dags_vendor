import 'package:dags/Common/utils/constants.dart';
import 'package:dags/Features/VendorScreen/Provider/vendor_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Common/Services/API/api_calling.dart';
import '../../../Common/Services/global.dart';
import '../../../main.dart';

class VendorController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController capacityController = TextEditingController();

  Future<void> addVendor(WidgetRef ref) async {
    final state = ref.watch(vendorNotifierProvider);
    final vendorName = state.userName;
    final capacity = state.capacity;
    final address = state.address;
    final vendorEmail = state.email;
    final phoneNumber =
        Global.storageServices.getString(AppConstants.userPhoneNumber);

    var response = await API.updateVendor(
        vendorName, capacity, address, vendorEmail, phoneNumber);
    if (response) {
      Global.storageServices.setString(AppConstants.userName, vendorName);
      Global.storageServices.setString(AppConstants.userEmail, vendorEmail);
      Global.storageServices
          .setBool(AppConstants.vendorRegisteredEarlier, true);
      navKey.currentState
          ?.pushNamedAndRemoveUntil('/kyc_scr', (route) => false);
    } else {
      if (kDebugMode) {
        print("some error occurred while adding vendor");
      }
    }
  }
}
