import 'package:dags/Common/utils/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Common/Services/API/api_calling.dart';
import '../../../Common/Services/global.dart';
import '../../../Common/utils/constants.dart';
import '../../../main.dart';
import '../provider/registernotifier.dart';

class RegisterController {
  late WidgetRef ref;
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  RegisterController({required this.ref});

  Future<void> handleSignUp(RegisterController controller) async {
    var state = ref.watch(registrationNotifierProvider);
    String phoneNo = state.phoneNumber;

    var response = await API.registerUser(phoneNo);
    if (response.containsKey('success') && response['success'] == true) {
      // storing the phone no  and username entered by the user
      Global.storageServices.setString(AppConstants.userPhoneNumber, phoneNo);
      if (kDebugMode) {
        print('Registration successful');
      }
      await Fluttertoast.showToast(
          msg: "An OTP has been sent to your phone number",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.primaryElement,
          textColor: Colors.black,
          fontSize: 16.0);

      navKey.currentState
          ?.pushNamed("/otp_scr", arguments: {'fromLogin': false});
    }
  }
}
