import 'package:dags/Common/utils/app_colors.dart';
import 'package:dags/Common/widgets/app_shadow.dart';
import 'package:dags/Common/widgets/app_text_fields.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../Common/utils/image_res.dart';
import '../../../../Common/widgets/app_button_widgets.dart';
import '../../../../Common/widgets/text_widgets.dart';
import '../../../../main.dart';
import '../../Controller/register_controller.dart';

Widget logoNew(Size size) {
  return ScreenUtilInit(
      designSize: Size(size.width, size.height),
      builder: (context, child) => SizedBox(child: Image.asset(ImageRes.logo)));
}

Widget registerText() {
  return textcustomnormal(
    text: "Register",
    fontWeight: FontWeight.w500,
    fontSize: 36.w,
    color: const Color(0xff161416),
  );
}

Widget registerText02() {
  return text16normal(
    color: Colors.grey.shade500,
    text: "By entering your Phone No.",
    fontWeight: FontWeight.w400,
  );
}

Widget phoneNoBox() {
  TextEditingController controller =TextEditingController();
  final text=controller.value;
  print(text);
  return Container(
    decoration: appBoxDecoration(
        color: Colors.grey.shade200,
        radius: 10.w,
        borderColor: AppColors.primaryFourElementText,
        borderWidth: 0.0.h),
    child: textLoginBoxWithDimensions(
        hintText: "Phone No.", height: 50.h, width: 325.w,keyboardType: TextInputType.number,controller: controller,
    ),
  );
}

Widget registerText03() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const text16normal(
        text: "Already a member?",
        fontWeight: FontWeight.w400,
      ),
      SizedBox(
        width: 4.w,
      ),
      GestureDetector(
        onTap: () {
          navKey.currentState?.pushNamed("/welcome_back_scr");
        },
        child: const text16normal(
          text: "Sign In",
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}
