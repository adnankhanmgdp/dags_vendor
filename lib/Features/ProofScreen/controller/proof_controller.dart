import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Common/Services/API/api_calling.dart';
import '../../../Common/Services/global.dart';
import '../../../Common/utils/constants.dart';
import '../../../main.dart';

class ProofController {
  late WidgetRef ref;

  ProofController({required this.ref});

  Future<void> uploadDocuments(String documentImage,String? docType) async {
    final phoneNumber = Global.storageServices.getString(AppConstants.userPhoneNumber);
    var response = await API.uploadVendorDoc(documentImage: documentImage, phoneNumber:  phoneNumber,docType: docType);
    if(response) {
      Global.storageServices.setBool(AppConstants.isDocumentDone, true);
      ///going back to the kyc screen
      navKey.currentState?.pushNamedAndRemoveUntil('/kyc_scr',(route) => false);
    } else {
      if (kDebugMode) {
        print("some error occurred while adding pictures to the backend");
      }
    }
  }

}