import 'package:dags/Common/widgets/app_shadow.dart';
import 'package:dags/Features/OrderdetailScreen/Provider/order_detail_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Common/utils/app_colors.dart';
import '../../../../Common/widgets/text_widgets.dart';

Widget titleRow(String orderDate, String orderStatus, BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              const textcustomnormal(
                text: "Order Date:",
                color: Colors.black,
                fontSize: 16,
                fontfamily: "Inter",
                fontWeight: FontWeight.w600,
              ),
              textcustomnormal(
                text: orderDate,
                color: Colors.grey.shade500,
                fontSize: 14,
                fontfamily: "Inter",
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: textcustomnormal(
              text: orderStatus,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontfamily: "Inter",
              color: (orderStatus == "Cancelled")
                  ? Colors.redAccent
                  : Color.fromARGB(255, 0, 160, 83),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget itemRow(String serviceName, String itemName, int itemQuantity,
    BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.89,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: textcustomnormal(
                          text: itemName,
                          align: TextAlign.start,
                          color: Colors.black,
                          fontSize: 16,
                          fontfamily: "Inter",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      textcustomnormal(
                        text: "Quantity: $itemQuantity       ",
                        color: Colors.black,
                        fontSize: 13,
                        fontfamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                textcustomnormal(
                  text: "$serviceName",
                  color: Colors.grey.shade500,
                  fontSize: 13,
                  fontfamily: "Inter",
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        dashLine(
          color: Colors.grey.shade400,
          height: 1.h,
        ),
      ],
    ),
  );
}

Widget itemRow02({String title = "", String price = '0'}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      textcustomnormal(
        text: title,
        color: Colors.black,
        fontSize: 18,
        fontfamily: "Inter",
        fontWeight: FontWeight.w600,
      ),
      SizedBox(
        width: 200.w,
      ),
      Container(
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 5.h),
        child: textcustomnormal(
          text: "₹ $price",
          color: Colors.black,
          fontSize: 16,
          fontfamily: "Inter",
          fontWeight: FontWeight.w600,
        ),
      )
    ],
  );
}

Widget descContainer(String instructions) {
  return Container(
    margin: EdgeInsets.only(left: 20.h),
    width: 355.w,
    decoration: appBoxDecoration(
        radius: 10.h, borderColor: Color.fromARGB(255, 2, 0, 134)),
    child: Container(
      margin: EdgeInsets.fromLTRB(10.h, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          const textcustomnormal(
            text: "Instructions From Customer:",
            fontSize: 18,
            fontfamily: "Inter",
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
          SizedBox(
            height: 5.h,
          ),
          SelectableText(
            instructions.toUpperCase(),
            maxLines: 5,
            minLines: 3,
            style: const TextStyle(
              fontSize: 15,
              fontFamily: "Inter",
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          )
        ],
      ),
    ),
  );
}

class Task {
  String name;
  bool isCompleted;
  Task(this.name, this.isCompleted);
}
