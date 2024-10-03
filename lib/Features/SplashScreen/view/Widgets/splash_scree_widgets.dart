import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Common/utils/image_res.dart';
import '../../../../Common/widgets/text_widgets.dart';


Widget logoContainer(Size size) {
  return ScreenUtilInit(
      designSize: Size(size.width, size.height),
      builder: (context, child) => Container(
            margin: EdgeInsets.fromLTRB(0, 80.h, 0, 0),
            alignment: Alignment.topCenter,
            child: SizedBox(child: Image.asset(ImageRes.logo)),
          ));
}

Widget titleText() {
  return textcustomnormal(
    text: "Connecting Vendors & Customers together",
    fontWeight: FontWeight.bold,
    fontSize: 26.w,
  );
}

Widget imageStack(Size size) {
  return ScreenUtilInit(
      designSize: Size(size.width, size.height),
      builder: (context,child)=>Stack(
    children: [
      Container(
          padding: const EdgeInsets.all(2),
          alignment: Alignment.center,
          child: Image.asset(ImageRes.two_per)),
      Container(
        margin: EdgeInsets.fromLTRB(0, 285.h, 0, 0),
        child: Image.asset(
          ImageRes.stairs,
          fit: BoxFit.scaleDown,
          height: 250.h,
        ),
      )
    ],
  ));
}
