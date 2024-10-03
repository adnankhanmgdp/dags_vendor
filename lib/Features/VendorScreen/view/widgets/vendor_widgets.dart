import 'package:dags/Common/utils/app_colors.dart';
import 'package:dags/Common/widgets/app_shadow.dart';
import 'package:dags/Common/widgets/app_text_fields.dart';
import 'package:dags/Features/VendorScreen/Controller/VendorController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Common/widgets/app_button_widgets.dart';
import '../../../../Common/widgets/text_widgets.dart';
import '../../../../main.dart';

Widget vendorText() {
  return textcustomnormal(
    text: "Vendor Partner Details",
    fontWeight: FontWeight.w500,
    fontSize: 36.w,
    color: const Color(0xff161416),
  );
}

Widget vendorText02() {
  return text16normal(
    color: Colors.grey.shade500,
    text: "Enter your business details",
    fontWeight: FontWeight.w400,
  );
}

Widget vendorDetailBox(
    {String hint = " ", required TextEditingController controller}) {
  return Container(
    decoration: appBoxDecoration(
        color: Colors.grey.shade200,
        radius: 10.w,
        borderColor: AppColors.primaryFourElementText,
        borderWidth: 1.0.h),
    child:
        textLoginBoxWithDimensions(hintText: hint, height: 45.h, width: 325.w),
  );
}

