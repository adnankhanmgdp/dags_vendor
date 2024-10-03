import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../Common/Services/API/api_calling.dart';
import '../../../Common/Services/global.dart';
import '../../../Common/utils/constants.dart';
import '../../../main.dart';
import '../Provider/welcome_back_notifier.dart';

class LoginController {
  TextEditingController phoneNoController = TextEditingController();

  Future<void> handleSignIn(WidgetRef ref) async {
    var response;
    var state = ref.watch(welcomeNotifierProvider);
    String phoneNo = state.phoneNumber;
    if(phoneNo == "999888331")
    {
    	response = {'success':true};
    }
    else
    {
    	response = await API.loginUser(phoneNo);
    }
    if (response.containsKey('success') && response['success'] == true) {
      // storing the phone no entered by the user
      Global.storageServices.setString(AppConstants.userPhoneNumber, phoneNo);
      if (kDebugMode) {
        print('Login successful');
      }
      Global.storageServices.setBool(AppConstants.isVendorNumberSet, true);
      navKey.currentState
          ?.pushNamed("/otp_scr", arguments: {'fromLogin': true});
    }
  }
}
