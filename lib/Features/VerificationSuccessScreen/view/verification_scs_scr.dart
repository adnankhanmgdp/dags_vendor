import 'package:dags/Common/utils/image_res.dart';
import 'package:dags/Common/widgets/app_button_widgets.dart';
import 'package:dags/Common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Common/utils/app_colors.dart';
import '../../../main.dart';
import '../../SplashScreen/view/Widgets/splash_scree_widgets.dart';

class VerifyingSuccessScreen extends StatefulWidget {
  const VerifyingSuccessScreen({super.key});

  @override
  State<VerifyingSuccessScreen> createState() => _VerifyingSuccessScreenState();
}

class _VerifyingSuccessScreenState extends State<VerifyingSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    final ScreenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final ScreenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return ScreenUtilInit(
      designSize: Size(ScreenWidth, ScreenHeight),
      builder: (context, child) =>
          SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                  children: [
                  SizedBox(
                  height: 500.h,
                  width: 600.w,
                  child: Image.asset(
                    ImageRes.women_02,
                    fit: BoxFit.contain,
                  )),
                    logoContainer(size),
              SizedBox(
                height: 7.h,
              ),
              Column(
                children: [
                SizedBox(
                height: 500.h,
              ),
              Container(
                  alignment: Alignment.center,
                  child: const text24normal(
                    text:
                    "Your KYC has                                                                      been Verified",
                    fontWeight: FontWeight.w700,
                    fontfamily: "Inter",
                  )),
              SizedBox(
                height: 50.h,
              ),
              Container(
                  margin: EdgeInsets.only(left: 29.w, right: 25.w),
                  child: appButtons(
                      buttonText: "Home",
                      buttonColor: AppColors.primaryElement,
                      buttonTextColor: AppColors.primaryText,
                      buttonBorderWidth: 2.h,
                      anyWayDoor: () {
                        navKey.currentState
                            ?.pushNamedAndRemoveUntil("/location_scr", (route) => false);
                      }))
              ],
            )
            ],
          ),
    ),)
    );
  }
}
