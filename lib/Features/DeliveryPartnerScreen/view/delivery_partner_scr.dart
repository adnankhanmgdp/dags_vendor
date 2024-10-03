import 'package:dags/Common/utils/image_res.dart';
import 'package:dags/Common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../main.dart';

class DeliveryPartnerScreen extends StatefulWidget {
  const DeliveryPartnerScreen({super.key});

  @override
  State<DeliveryPartnerScreen> createState() => _DeliveryPartnerScreenState();
}

class _DeliveryPartnerScreenState extends State<DeliveryPartnerScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      navKey.currentState
          ?.pushNamedAndRemoveUntil('/application_scr', (route) => false);    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    body: SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80.h,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                textcustomnormal(
                  fontSize: 23,
                  text: "Delivery Partner has",
                  fontWeight: FontWeight.w700,
                  fontfamily: "Inter",
                  color: Colors.black,
                ),
                textcustomnormal(
                  fontSize: 23,
                  text: "been Assigned ✅",
                  fontWeight: FontWeight.w700,
                  fontfamily: "Inter",
                  color: Colors.black,
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            SizedBox(
                height: 400.h,
                width: 400.h,
                child: Image.asset(ImageRes.deliverypartner,
                    fit: BoxFit.scaleDown)),
            Container(
              height: 2.h,
              width: 400.w,
              color: const Color(0xffd4d5dd),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  margin: EdgeInsets.all(7.h),
                  child: CircleAvatar(
                    radius: 20.w,
                    child: Image.asset(ImageRes.deliverymanicon),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    const Text(
                      "Uday Verma",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const Text("Delivery Partner Assigned",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                            color: Color(0xff606060))),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 7.h,
            ),
            const dashLine()
          ],
        ),
      ),
    ));
  }
}
