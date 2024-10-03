import 'package:dags/Common/Services/API/api_calling.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Common/Services/global.dart';
import '../../../Common/utils/constants.dart';
import '../../../main.dart';
import 'Widgets/splash_scree_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String verificationStatus = '';
  @override
  Future<void> didChangeDependencies() async {
    final bool isNumberSet = Global.storageServices.getUserNumberSet();
    if (!isNumberSet) {
      /// user is coming first time to the app...
      if (kDebugMode) {
        print('user came to platform first time');
      }
      Future.delayed(const Duration(seconds: 3), () {
        navKey.currentState
            ?.pushNamedAndRemoveUntil('/register', (route) => false);
      });
    }
    else {
      /// user has opened app earlier also and a member of app...
      final phoneNumber =
      Global.storageServices.getString(AppConstants.userPhoneNumber);
      verificationStatus = await API.getVerificationStatus(phoneNumber);
      if (verificationStatus == 'active') {
        Global.storageServices.setBool(AppConstants.vendorVerified, true);
        navKey.currentState
            ?.pushNamedAndRemoveUntil('/register', (route) => false);
      }
      else{
        Global.storageServices.setBool(AppConstants.vendorVerified, false);
        navKey.currentState
            ?.pushNamedAndRemoveUntil('/verify_scr', (route) => false);
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ScreenHeight = MediaQuery.of(context).size.height;
    final ScreenWidth = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
        designSize: Size(ScreenWidth, ScreenHeight),
        builder: (context, child) => SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: Column(
                  children: [
                    logoContainer(size),
                    SizedBox(
                      height: 7.h,
                    ),
                    titleText(),
                    imageStack(size)
                  ],
                ),
              ),
            ));
  }
}
