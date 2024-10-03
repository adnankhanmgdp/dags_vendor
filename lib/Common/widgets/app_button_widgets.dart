import 'package:dags/Common/utils/image_res.dart';
import 'package:dags/Common/widgets/text_widgets.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import 'app_shadow.dart';

Widget appButtons(
    {String buttonText = "Next",
    Color buttonColor = AppColors.primaryElement,
    Color buttonTextColor = AppColors.primaryElementText,
    double buttonBorderWidth = 0.0,
    double height = 55,
    double width = 370,
    BuildContext? context,
    void Function()?
        anyWayDoor // a call back function  designed to make navigation....
    }) {
  return GestureDetector(
    onTap: anyWayDoor!,
    /* we are calling any way door func when this button is pressed
    and this func will be executed in the file from where this button has been called.*/
    child: Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      decoration: appBoxDecoration(
          color: buttonColor,
          borderWidth: buttonBorderWidth,
          radius: 10,
          borderColor: Colors.black),
      child: text20normal(
        text: buttonText,
        color: buttonTextColor,
        fontfamily: "Inter",
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget appButtonswithoutaction({
  String buttonText = "Next",
  Color buttonColor = AppColors.primaryElement,
  Color buttonTextColor = AppColors.primaryElementText,
  double buttonBorderWidth = 0.0,
}) {
  return Container(
    alignment: Alignment.center,
    height: 50.h,
    width: 345.w,
    decoration: appBoxDecoration(
        color: buttonColor, borderWidth: buttonBorderWidth, radius: 10),
    child: text20normal(
      text: buttonText,
      color: buttonTextColor,
      fontWeight: FontWeight.w500,
    ),
  );
}

Widget documentsButtons(
    {String buttonText = "Next",
    Color buttonColor = AppColors.documentButtonBg,
    Color buttonTextColor = AppColors.primaryElementText,
    IconData buttonIcon = Icons.error,
    double buttonBorderWidth = 1.0,
    Color iconColor = const Color(0xfffff0ce),
    void Function()?
        anyWayDoor // a call back function  designed to make navigation....
    }) {
  return GestureDetector(
    onTap: anyWayDoor!,
    child: Container(
      alignment: Alignment.center,
      height: 55,
      width: 350,
      decoration: appBoxDecoration(
          color: buttonColor,
          borderWidth: buttonBorderWidth,
          radius: 10.w,
          borderColor: Colors.grey.shade400),
      child: Row(
        children: [
          Container(
              height: 40.h,
              width: 40.w,
              decoration: appBoxDecoration(
                  color: iconColor,
                  radius: 7.w,
                  borderWidth: 0.0,
                  borderColor: Colors.white),
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10.w),
              child: Icon(buttonIcon)),
          SizedBox(
            width: 5.w,
          ),
          Text(
            buttonText,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                color: Colors.black),
          ),
          SizedBox(
            width: 5.w,
          ),
          Icon(
            Icons.keyboard_arrow_right_outlined,
            size: 3.h,
          )
        ],
      ),
    ),
  );
}

Widget customIconAppButton(
    {String buttonText = "Next",
    Color buttonColor = AppColors.primaryElement,
    Color buttonTextColor = AppColors.primaryElementText,
    double buttonTextSize = 16,
    double buttonRadius = 15,
    Color borderColor = Colors.black,
    double buttonBorderWidth = 0.0,
    IconData buttonIcon = Icons.edit_calendar_rounded,
    double height = 55,
    double width = 370,
    BuildContext? context,
    void Function()?
        anyWayDoor // a call back function  designed to make navigation....
    }) {
  return GestureDetector(
    onTap: anyWayDoor!,
    /* we are calling any way door func when this button is pressed
    and this func will be executed in the file from where this button has been called.*/
    child: Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      decoration: appBoxDecoration(
          color: buttonColor,
          borderWidth: buttonBorderWidth,
          radius: buttonRadius,
          borderColor: borderColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(buttonIcon),
          SizedBox(
            width: 10.w,
          ),
          textcustomnormal(
            fontSize: buttonTextSize,
            fontWeight: FontWeight.w600,
            fontfamily: "Poppins",
            text: buttonText,
            color: buttonTextColor,
          )
        ],
      ),
    ),
  );
}

Widget orderCardCommon(
    {String vendorFee = "",
    String status = "",
    String orderNumber = '1234',
    String orderDate = "",
    int itemLength = 0,
    String deliveryType = '',
    void Function()? goToDetails,
    double orderRating = 0.0}) {
  Color color;
  if (status == "Cancelled") {
    color = const Color(0xffF14B4B);
  } else {
    color = Color.fromARGB(255, 33, 168, 51);
  }
  return GestureDetector(
    onTap: goToDetails!,
    child: Container(
      width: double.maxFinite,
      margin: EdgeInsets.fromLTRB(15.w, 0, 15.w, 5),
      child: Card(
          shadowColor: Colors.grey.shade400,
          elevation: 2.0,
          clipBehavior: Clip.hardEdge,
          child: Container(
            alignment: Alignment.center,
            decoration: appBoxDecoration(
                color: (status == "Delivered")
                    ? Color.fromARGB(255, 212, 255, 193)
                    : (status == "Cancelled" || status == "Refunded")
                        ? Color.fromARGB(255, 255, 193, 193)
                        : Color.fromARGB(255, 255, 241, 193),
                // color: Colors.white,
                radius: 10,
                borderWidth: 0,
                borderColor: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const textcustomnormal(
                            text: "Order Date",
                            color: Colors.black,
                            fontSize: 16,
                            fontfamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),
                          textcustomnormal(
                            text: "Payment:  ₹$vendorFee.00",
                            color: Colors.black,
                            fontSize: 16,
                            fontfamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textcustomnormal(
                            text: orderDate,
                            color: Colors.grey.shade600,
                            fontSize: 14,
                            fontfamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                          (deliveryType == 'express')
                              ? Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Image.asset(
                                    ImageRes.expressicon,
                                    height: 30.h,
                                    width: 30.h,
                                  ))
                              : SizedBox()
                        ],
                      ),
                      if (orderRating != null && orderRating != 0)
                        PannableRatingBar(
                          enablePixelsCompensation: false,
                          minRating: 1,
                          maxRating: 5,
                          rate: orderRating,
                          items: List.generate(
                              5,
                              (index) => const RatingWidget(
                                    selectedColor:
                                        Color.fromARGB(255, 255, 186, 59),
                                    unSelectedColor: Colors.white,
                                    child: Icon(
                                      Icons.star,
                                      size: 20,
                                    ),
                                  )),
                        ),
                    ],
                  ),
                ),
                dashLine(
                  color: Colors.grey.shade400,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textcustomnormal(
                        text: "#$orderNumber",
                        color: Colors.grey.shade700,
                        fontSize: 14,
                        fontfamily: "Inter",
                        fontWeight: FontWeight.w700,
                      ),
                      textcustomnormal(
                        text: "$itemLength Items",
                        color: Colors.grey.shade700,
                        fontSize: 14,
                        fontfamily: "Inter",
                        fontWeight: FontWeight.w700,
                      ),
                      textcustomnormal(
                        text: status,
                        color: color,
                        fontSize: 14,
                        fontfamily: "Inter",
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          )),
    ),
  );
}
