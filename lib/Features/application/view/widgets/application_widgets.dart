import 'package:dags/Common/widgets/app_shadow.dart';
import 'package:dags/Features/OrdersScreen/view/orders_scr.dart';
import 'package:dags/Features/ScanScreen/view/scanscreen.dart';
import 'package:dags/Features/TransactionScreen/view/transaction_screen.dart';
import 'package:dags/Features/dashboardScreen/view/dashboard_scr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Common/utils/app_colors.dart';


var bottomTabs = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
      icon: SizedBox(
          width: 25.w,
          height: 25.h,
          child: const Icon(
            Icons.dashboard,
            color: Color(0xff1C254E),
          )),
      activeIcon: Container(
          alignment: Alignment.center,
          height: 35.h,
          width: 80.w,
          decoration:
              appBoxDecoration(radius: 30.h, borderColor: Colors.grey.shade300),
          child: const Icon(
            Icons.dashboard,
            color: Color(0xff1C254E),
          )),
      backgroundColor: AppColors.primaryBackground,
      label: "dashboard"),
  BottomNavigationBarItem(
      icon: SizedBox(
          width: 25.w,
          height: 25.h,
          child: const Icon(
            Icons.shopping_cart,
            color: Color(0xff1C254E),
          )),
      activeIcon: Container(
          alignment: Alignment.center,
          height: 35.h,
          width: 80.w,
          decoration:
              appBoxDecoration(radius: 30.h, borderColor: Colors.grey.shade300),
          child: const Icon(
            Icons.shopping_cart,
            color: Color(0xff1C254E),
          )),
      backgroundColor: AppColors.primaryBackground,
      label: "Order"),
  BottomNavigationBarItem(
      icon: SizedBox(
        width: 25.w,
        height: 25.h,
        child: Icon(
          Icons.my_library_books_outlined,
          color: const Color(0xff1C254E),
          size: 22.h,
        ),
      ),
      activeIcon: Container(
        alignment: Alignment.center,
        height: 35.h,
        width: 80.w,
        decoration:
            appBoxDecoration(radius: 30.h, borderColor: Colors.grey.shade300),
        child: Icon(
          Icons.my_library_books_outlined,
          color: const Color(0xff1C254E),
          size: 22.h,
        ),
      ),
      backgroundColor: AppColors.primaryBackground,
      label: "Settlement"),
  BottomNavigationBarItem(
      icon: SizedBox(
          width: 25.w,
          height: 25.h,
          child: const Icon(
            Icons.qr_code_sharp,
            color: Color(0xff1C254E),
          )),
      activeIcon: Container(
          alignment: Alignment.center,
          height: 35.h,
          width: 80.w,
          decoration:
              appBoxDecoration(radius: 30.h, borderColor: Colors.grey.shade300),
          child: const Icon(
            Icons.qr_code_sharp,
            color: Color(0xff1C254E),
          )),
      backgroundColor: AppColors.primaryBackground,
      label: "Profile"),
];

Widget appScreens({int index = 0}) {
  List<Widget> screens = [
    const DashBoardScreen(),
    const OrdersScreen(),
    const TransactionHistoryScreen(),
    const ScanScreen()
  ];
  return screens[index];
}
