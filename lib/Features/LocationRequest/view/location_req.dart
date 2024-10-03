import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location/location.dart';
import '../../../Common/Services/global.dart';
import '../../../Common/utils/constants.dart';
import '../../../Common/utils/image_res.dart';
import '../../../Common/widgets/app_button_widgets.dart';
import '../../../main.dart';

class LocationRequestScreen extends ConsumerStatefulWidget {
  const LocationRequestScreen({super.key});

  @override
  ConsumerState<LocationRequestScreen> createState() =>
      _LocationRequestScreenState();
}

class _LocationRequestScreenState extends ConsumerState<LocationRequestScreen> {
  Location location =  Location();

  Future<LocationData> _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Future.error('Location services  are not enabled');
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return Future.error('Location permissions are denied');
      }
    }
    _locationData = await location.getLocation();
    return _locationData;
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    String lat = "";
    String long = "";
    return Scaffold(
      body: (isLoading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: EdgeInsets.fromLTRB(20.w, 50.h, 20.w, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageRes.logo,
                    height: 45.h,
                  ),
                  SizedBox(height: 50.h),
                  Image.asset(
                    ImageRes.locationimage,
                    height: 300.h,
                  ),
                  SizedBox(height: 50.h),
                  const Text(
                    'Enable location',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Inter"),
                  ),
                  SizedBox(height: 16.h),
                  const Text(
                    'Dags collects location data to show you nearest Logistic Partners. Allow Dags to access this device’s location.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 40.h),
                  appButtons(
                      buttonText: "Turn on location",
                      buttonTextColor: Colors.black,
                      height: 54.h,
                      width: 340.w,
                      buttonBorderWidth: 2.h,
                      anyWayDoor: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await _getLocation().then((value) async {
                          lat = "${value.latitude}";
                          long = "${value.longitude}";
                          Global.storageServices
                              .setString(AppConstants.latitude, lat);
                          Global.storageServices
                              .setString(AppConstants.longitude, long);
                          if (kDebugMode) {
                            print("latitude is $lat, longitude is $long");
                          }
                          Global.storageServices
                              .setBool(AppConstants.locationGranted, true);
                          navKey.currentState?.pushNamedAndRemoveUntil(
                              "/application_scr", (routes) => false);
                        });
                      })
                ],
              ),
            ),
    );
  }
}
