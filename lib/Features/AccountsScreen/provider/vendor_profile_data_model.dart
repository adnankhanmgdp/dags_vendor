import 'package:flutter/foundation.dart';

class GeoCoordinates {
  final String latitude;
  final String longitude;

  GeoCoordinates({required this.latitude, required this.longitude});

  factory GeoCoordinates.fromJson(Map<String, dynamic> json) {
    return GeoCoordinates(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class BankDetails {
  dynamic accountHolderName;
  dynamic bankName;
  dynamic accountNumber;
  dynamic ifsc;
  dynamic branch;

  BankDetails(
      {required this.accountHolderName,
      required this.bankName,
      required this.branch,
      required this.ifsc,
      required this.accountNumber});

  factory BankDetails.fromJson(dynamic json) {
    if (kDebugMode) {
      print(json);
    }
    if (json != null) {
      return BankDetails(
        accountHolderName: json['accountHolderName'] ?? '',
        bankName: json['bankName'] ?? '',
        accountNumber: json['accountNumber'] ?? '',
        ifsc: json['IFSC'] ?? '',
        branch: json['branch'] ?? '',
      );
    } else {
      return BankDetails(
        accountHolderName: '',
        bankName: '',
        accountNumber: '',
        ifsc: '',
        branch: '',
      );
    }
  }
}

class Vendor {
  final String address;
  final int capacity;
  final String email;
  final String name;
  final String document;
  final dynamic profilePic;
  final String vendorId;
  final dynamic bankDetails;

  Vendor({
    required this.address,
    required this.capacity,
    required this.email,
    required this.name,
    required this.document,
    required this.profilePic,
    required this.vendorId,
    required this.bankDetails,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
        address: json['vendor']['address'],
        capacity: json['vendor']['capacity'],
        email: json['vendor']['email'],
        name: json['vendor']['name'],
        document: json['vendor']['document'],
        profilePic: json['vendor']['profilePic'] ?? '',
        vendorId: json['vendor']['vendorId'] ?? '',
        bankDetails: BankDetails.fromJson(json['bankDetails']));
  }
}
