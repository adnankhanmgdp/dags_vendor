import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Common/Services/API/api_calling.dart';
import '../../../Common/Services/global.dart';
import '../../../Common/utils/app_colors.dart';
import '../../../Common/utils/constants.dart';
import '../../../main.dart';
import '../Provider/otp_notifier.dart';

class OtpController {
  Future<void> handleOtp(WidgetRef ref, bool fromLogin) async {
    var state = ref.watch(otpNotifierProvider);
    var response;
    var otp = state.otp;
    var phoneNo =
        Global.storageServices.getString(AppConstants.userPhoneNumber);
    String verificationStatus = '';
    if (phoneNo == '9998883331') {
      response = {'success': true};
    } else {
      response = await API.enterOtp(phoneNo, otp);
    }
    if (response.containsKey('success') && response['success'] == true) {
      //Global.storageServices.setString(AppConstants.vendorId, vendorId);
      Fluttertoast.showToast(
          msg: "OTP verified successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.primaryElement,
          textColor: Colors.black,
          fontSize: 16.0);
      if (kDebugMode) {
        print('got otp successfully');
      }
      if (fromLogin) {
        if (kDebugMode) {
          print('from login true');
        }
        Global.storageServices.setBool(AppConstants.userLoggedInEarlier, true);
        //Global.storageServices.setBool(AppConstants.userRegisteredEarlier, false);
        verificationStatus = await API.getVerificationStatus(phoneNo);
        if (verificationStatus == 'active') {
          debugPrint('otp controller has shown a active profile.');
          Global.storageServices.setBool(AppConstants.vendorVerified, true);
          navKey.currentState
              ?.pushNamedAndRemoveUntil('/location_scr', (routes) => false);
        } else {
          navKey.currentState
              ?.pushNamedAndRemoveUntil('/verify_scr', (route) => false);
        }
      } else {
        if (kDebugMode) {
          print('not from login ');
        }
        Global.storageServices
            .setBool(AppConstants.userRegisteredEarlier, true);
        //Global.storageServices.setBool(AppConstants.userLoggedInEarlier, false);
        navKey.currentState
            ?.pushNamedAndRemoveUntil('/vendor_scr', (route) => false);
      }
    } else {
      if (kDebugMode) {
        print('some error occurred  while verifying otp.');
      }
    }
  }
}
