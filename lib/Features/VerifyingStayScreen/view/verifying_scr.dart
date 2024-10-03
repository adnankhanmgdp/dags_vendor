import 'package:dags/Common/utils/constants.dart';
import 'package:dags/Common/utils/image_res.dart';
import 'package:dags/Common/widgets/text_widgets.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Common/Services/API/api_calling.dart';
import '../../../Common/Services/global.dart';
import '../../../main.dart';
import '../../SplashScreen/view/Widgets/splash_scree_widgets.dart';

class VerifyingScreen extends StatefulWidget {
  const VerifyingScreen({super.key});

  @override
  State<VerifyingScreen> createState() => _VerifyingScreenState();
}

class _VerifyingScreenState extends State<VerifyingScreen> {
  String verificationStatus = '';
  @override
  Future<void> didChangeDependencies() async {
    final phoneNumber =
        Global.storageServices.getString(AppConstants.userPhoneNumber);
    verificationStatus = await API.getVerificationStatus(phoneNumber);
    if (verificationStatus == 'active') {
      Global.storageServices.setBool(AppConstants.vendorVerified, true);
      navKey.currentState
          ?.pushNamedAndRemoveUntil('/verify_scs_scr', (routes) => false);
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
                body: DoubleBackToCloseApp(
                  snackBar: const SnackBar(
                      content: Text(
                    'Tap back again to leave',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
                  child: Stack(
                    children: [
                      SizedBox(
                          height: 500.h,
                          width: 600.w,
                          child: Image.asset(
                            ImageRes.women_01,
                            fit: BoxFit.contain,
                          )),
                      logoContainer(size),
                      SizedBox(
                        height: 7.h,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 530.h,
                          ),
                          Container(
                              alignment: Alignment.center,
                              child: const text24normal(
                                text: "Verifying Details",
                                fontWeight: FontWeight.w600,
                                fontfamily: "Inter",
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          const textcustomnormal(
                            fontSize: 18,
                            text: "We are verifying your documents. "
                                "                          We will notify you when approved.",
                            fontfamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
