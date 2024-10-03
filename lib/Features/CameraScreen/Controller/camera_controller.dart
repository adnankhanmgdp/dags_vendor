import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Common/Services/API/api_calling.dart';
import '../../../Common/Services/global.dart';
import '../../../Common/utils/constants.dart';
import '../../../main.dart';

class CameraController {
  late WidgetRef ref;

  CameraController({required this.ref});

  Future<void> uploadProfilePic(String profilePic) async {
    final phoneNumber = Global.storageServices.getString(AppConstants.userPhoneNumber);
    var response = await API.uploadVendorProfilePic(profilePic:profilePic,phoneNumber:  phoneNumber);
    if(response) {
      Global.storageServices.setBool(AppConstants.isImageDone, true);
      ///going back to kyc screen
      navKey.currentState?.pushNamedAndRemoveUntil('/kyc_scr',(route) => false);
    } else {
      if (kDebugMode) {
        print("some error occurred while adding pictures to the backend");
      }
    }
  }

}