import 'package:dags/Common/utils/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Common/Services/global.dart';
import '../../../../Common/utils/constants.dart';
import '../../../../Common/widgets/app_button_widgets.dart';
import '../../../../Common/widgets/text_widgets.dart';
import '../../../../main.dart';
import '../../Controller/login_controller.dart';

Widget welcomeBackText() {
  return textcustomnormal(
    text: "Welcome Back",
    fontWeight: FontWeight.w500,
    fontSize: 36.w,
    color: const Color(0xff161416),
  );
}

Widget welcomeBackText02() {
  return text16normal(
    color: Colors.grey.shade500,
    text: "Sign in by entering your Phone No",
    fontWeight: FontWeight.w400,
  );
}

Widget welcomeBackText03() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const text16normal(
        text: "Don't have an account?",
        fontWeight: FontWeight.w400,
      ),
      SizedBox(
        width: 4.w,
      ),
      GestureDetector(
        onTap: () {
          Global.storageServices
              .setBool(AppConstants.userLoggedInEarlier, false);
          Global.storageServices.setBool(AppConstants.vendorRegisteredEarlier, false);
          Global.storageServices
              .setBool(AppConstants.kycDone, false);
          navKey.currentState?.pushNamedAndRemoveUntil('/register', (route) => false);
        },
        child: const text16normal(
          text: "Sign up",
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}
