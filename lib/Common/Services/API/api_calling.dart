import 'dart:convert';
import 'package:dags/Common/utils/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../global.dart';
import '../misc_models.dart';

class API {
  static String Token = "Token";
  static String url = AppConstants.serverApiUrl;

  static Future<Map<String, dynamic>> registerUser(String phoneNumber) async {
    Map<String, dynamic> data = {'phone': phoneNumber};
    try {
      var response = await http.post(
        Uri.parse("$url/vendor/api/signup"),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: jsonEncode(data),
      );
      debugPrint('register response is -> ${jsonDecode(response.body)}');
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      }
      if (response.statusCode == 401) {
        Fluttertoast.showToast(
            msg: "Laundry account already exists",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.black,
            fontSize: 16.0);
      }
      if (response.statusCode == 502) {
        Fluttertoast.showToast(
            msg: "Check your internet connection.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.black,
            fontSize: 16.0);
      }
      return {
        'error': 'Failed to register user. Status code: ${response.statusCode}'
      };
    } catch (e) {
      if (kDebugMode) {
        print('Exception caught: $e');
      }
      return {'error': 'Exception caught: $e'};
    }
  }

  static Future<Map<String, dynamic>> loginUser(String phoneNumber) async {
    Map<String, dynamic> data = {'phone': phoneNumber};
    try {
      var response = await http.post(
        Uri.parse("$url/vendor/api/login"),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: jsonEncode(data),
      );
      if (kDebugMode) {
        print(jsonDecode(response.body));
      }
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        Fluttertoast.showToast(
            msg: "An OTP has been send to your phone number",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.black,
            fontSize: 16.0);
        return jsonResponse;
      }
      if (response.statusCode == 404) {
        Fluttertoast.showToast(
            msg: "No laundry registered with this phone number",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.black,
            fontSize: 16.0);
      }
      if (response.statusCode == 502) {
        Fluttertoast.showToast(
            msg: "Check your internet connection.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.black,
            fontSize: 16.0);
      }
      if (response.statusCode == 995) {
        Fluttertoast.showToast(
            msg: "Too many attempts! Try again later.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.black,
            fontSize: 16.0);
      } else {
        if (kDebugMode) {
          print('login response is ->${response.statusCode}');
        }
      }
      return {
        'error': 'Failed to register user. Status code: ${response.statusCode}'
      };
    } catch (e) {
      if (kDebugMode) {
        print('Exception caught: $e');
      }
      return {'error': 'Exception caught: $e'};
    }
  }

  static Future<Map<String, dynamic>> enterOtp(
      String phoneNumber, String otp) async {
    Map<String, dynamic> data = {'phone': phoneNumber, 'otp': otp};
    try {
      var response = await http.post(
        Uri.parse("$url/vendor/api/verifyOTP"),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (kDebugMode) {
          print(jsonResponse);
        }
        return jsonResponse;
      }
      if (response.statusCode == 401) {
        Fluttertoast.showToast(
            msg: "Incorrect OTP! try again.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.black,
            fontSize: 16.0);
      }
      if (response.statusCode == 502) {
        Fluttertoast.showToast(
            msg: "Could not verify OTP at this time.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.black,
            fontSize: 16.0);
      }
      if (response.statusCode == 995) {
        Fluttertoast.showToast(
            msg: "Too many attempts! try again later.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.black,
            fontSize: 16.0);
      }
      return {
        'error': 'Failed to fetch otp. Status code: ${response.statusCode}'
      };
    } catch (e) {
      if (kDebugMode) {
        print('Exception caught: $e');
      }
      return {'error': 'Exception caught: $e'};
    }
  }

  static Future<bool> updateVendor(String vendorName, String capacity,
      String address, String mail, String phoneNumber) async {
    Map<String, dynamic> data = {
      'name': vendorName,
      'capacity': capacity,
      'address': address,
      'email': mail,
      'phone': phoneNumber,
      'docs': 'test docs not needed'
    };
    try {
      var response = await http.put(
        Uri.parse("$url/vendor/api/updateDocs"),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        Fluttertoast.showToast(
            msg: "Vendor registred successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.black,
            fontSize: 16.0);
        return true;
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(
            msg: "Vendor not found",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.black,
            fontSize: 16.0);
        return false;
      } else {
        Fluttertoast.showToast(
            msg: "Vendor could not be added, please try again",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.black,
            fontSize: 16.0);
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception caught: $e');
      }
      return false;
    }
  }

  static Future<bool> uploadVendorDoc(
      {String? documentImage,
      required String phoneNumber,
      String? docType}) async {
    Map<String, dynamic> data = {
      'phone': phoneNumber,
      'docs': documentImage,
      'docType': docType
    };

    try {
      var response = await http.put(
        Uri.parse("$url/vendor/api/updateDocs"),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: jsonEncode(data),
      );
      if (kDebugMode) {
        print(jsonDecode(response.body));
      }
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        Fluttertoast.showToast(
            msg: "Documents added successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.black,
            fontSize: 16.0);
        return true;
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(
            msg: "Vendor not found",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.black,
            fontSize: 16.0);
        return false;
      } else {
        Fluttertoast.showToast(
            msg: "Could not upload documents at this moment.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.black,
            fontSize: 16.0);
        if (kDebugMode) {
          print(response.statusCode);
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception caught: $e');
      }
      return false;
    }
  }

  static Future<bool> uploadVendorProfilePic(
      {required String phoneNumber,
      String? profilePic,
      String? lat,
      String? long}) async {
    Map<String, dynamic> data = {'phone': phoneNumber};
    if (lat != null && long != null) {
      if (kDebugMode) {
        print("lat and long is not null");
      }
      data.addAll({
        'geoCoordinates': {"latitude": lat, "longitude": long}
      });
    } else if (profilePic != null) {
      if (kDebugMode) {
        print("profile Pic is not null");
      }
      data.addAll({'docs': profilePic});
    }
    try {
      var response = await http.put(
        Uri.parse("$url/vendor/api/updateProfile"),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: jsonEncode(data),
      );
      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('pictures uploaded successfully');
        }
        return true;
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(
            msg: "Vendor not found",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.black,
            fontSize: 16.0);
        return false;
      } else {
        if (kDebugMode) {
          print(response.statusCode);
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception caught: $e');
      }
      return false;
    }
  }

  static Future<Charges> fetchCharges() async {
    try {
      final response = await http.get(Uri.parse('$url/admin/api/fetchMisc'));
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("fetch charges has been successfully  hit");
        }
        return Charges.fromJson(jsonDecode(response.body)['charges']);
      } else if (response.statusCode == 404) {
        throw Exception('Resource not found');
      } else if (response.statusCode == 500) {
        throw Exception('Internal server error');
      } else {
        throw Exception(
            'Failed to load charges with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load charges: $e');
    }
  }

  static Future<bool> getLogisticPartner(
      String secretKey, String orderId) async {
    try {
      final vendorId = Global.storageServices.getString(AppConstants.vendorId);
      final data = {
        'orderId': orderId,
        'secretKey': secretKey,
        'vendorId': vendorId
      };
      final response = await http.post(
          Uri.parse('$url/vendor/api/readyForDelivery'),
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json; charset=utf-8'});

      if (kDebugMode) {
        print(jsonDecode(response.body));
      }
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("logistic partner has been assigned");
        }
        return true;
      } else {
        if (kDebugMode) {
          print('error status code is -> ${response.statusCode}');
        }
        return false;
      }
    } catch (e) {
      throw Exception('Failed to get logistic partner: $e');
    }
  }

  static Future<String> getVerificationStatus(String phoneNumber) async {
    try {
      Map<String, String> data = {'phone': phoneNumber};
      final response = await http.post(
          Uri.parse('$url/vendor/api/fetchProfile'),
          headers: {'Content-Type': 'application/json; charset=utf-8'},
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (kDebugMode) {
          print("fetch vendor profile has been successfully  hit");
        }
        UserModel.userName = jsonResponse['vendor']['name'];
        UserModel.email = jsonResponse['vendor']['email'];
        UserModel.capacity = jsonResponse['vendor']['capacity'];
        UserModel.address = jsonResponse['vendor']['address'];
        Global.storageServices.setString(
            AppConstants.vendorId, jsonResponse['vendor']['vendorId']);

        return jsonResponse['vendor']['verificationStatus'];
      } else if (response.statusCode == 404) {
        throw Exception('Resource not found');
      } else if (response.statusCode == 500) {
        throw Exception('Internal server error');
      } else {
        throw Exception(
            'Failed to load charges with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get verification Status: $e');
    }
  }
}
