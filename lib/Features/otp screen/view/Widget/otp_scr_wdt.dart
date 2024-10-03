import 'package:dags/Common/utils/app_colors.dart';
import 'package:dags/Common/widgets/app_shadow.dart';
import 'package:dags/Common/widgets/app_text_fields.dart';
import 'package:dags/Features/otp%20screen/Controller/otp_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Common/Services/global.dart';
import '../../../../Common/utils/constants.dart';
import '../../../../Common/widgets/app_button_widgets.dart';
import '../../../../Common/widgets/text_widgets.dart';
import '../../../../main.dart';

Widget otpText() {
  return textcustomnormal(
    text: "OTP Verification",
    fontWeight: FontWeight.w500,
    fontSize: 36.w,
    color: const Color(0xff161416),
  );
}

Widget otpText02() {
  return text14normal(
    color: Colors.grey.shade500,
    text:
        "Please enter the 6-digit code sent to your phone Number.",
    fontWeight: FontWeight.w400,
  );
}

Widget otpBoxes() {
  return Container(
    decoration: appBoxDecoration(
        color: Colors.grey.shade200,
        radius: 4.w,
        borderColor: AppColors.primaryFourElementText,
        borderWidth: 1.0.h),
    child: textLoginBoxWithDimensions(hintText: "3", height: 40.h, width: 40.w),
  );
}

Widget verifyButton(OtpController controller, WidgetRef ref,bool fromLogin) {
  return Container(
      margin: EdgeInsets.only(left: 29.w, right: 25.w),
      child: appButtons(
          buttonText: "Verify",
          buttonColor: AppColors.primaryElement,
          buttonTextColor: AppColors.primaryText,
          buttonBorderWidth: 2.h,
          anyWayDoor: () {
            controller.handleOtp(ref,fromLogin);
          }
          ));
}

Widget otpText03() {
  return const text16normal(
    text: "Didn’t receive any code?",
    fontWeight: FontWeight.w600,
  );
}
