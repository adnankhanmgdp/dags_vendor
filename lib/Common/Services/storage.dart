import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

class StorageServices {
  late final SharedPreferences _pref;

  Future<StorageServices> init() async {
    _pref = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setString(String key, String value) async {
    return await _pref.setString(key, value);
  }

  String getString(String key) {
    return _pref.getString(key) ?? " ";
  }

  Future<bool> setBool(String key, bool value) async {
    return await _pref.setBool(key, value);
  }

  bool getUserLoggedInEarlier() {
    // give the value of bool if it has been set early and if it is not set then give false as the value
    return _pref.getBool(AppConstants.userLoggedInEarlier) ?? false;
  }
  bool getVendorRegisteredEarlier() {
    // give the value of bool if it has been set early and if it is not set then give false as the value
    return _pref.getBool(AppConstants.vendorRegisteredEarlier) ?? false;
  }
  bool getUserRegisteredEarlier() {
    // give the value of bool if it has been set early and if it is not set then give false as the value
    return _pref.getBool(AppConstants.userRegisteredEarlier) ?? false;
  }

  bool getKycDoneEarlier() {
    // give the value of bool if it has been set early and if it is not set then give false as the value
    return _pref.getBool(AppConstants.kycDone) ?? false;
  }
  bool getVendorVerified() {
    // give the value of bool if it has been set early and if it is not set then give false as the value
    return _pref.getBool(AppConstants.vendorVerified) ?? false;
  }

  bool getImageDone() {
    // give the value of bool if it has been set early and if it is not set then give false as the value
    return _pref.getBool(AppConstants.isImageDone) ?? false;
  }

  bool getDocumentDone() {
    // give the value of bool if it has been set early and if it is not set then give false as the value
    return _pref.getBool(AppConstants.isDocumentDone) ?? false;
  }
  bool getLocationGranted() {
    // give the value of bool if it has been set early and if it is not set then give false as the value
    return _pref.getBool(AppConstants.locationGranted) ?? false;
  }
  bool getUserNumberSet() {
    // give the value of bool if it has been set early and if it is not set then give false as the value
    return _pref.getBool(AppConstants.isVendorNumberSet) ?? false;
  }
}
