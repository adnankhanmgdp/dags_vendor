import 'package:dags/Common/widgets/app_bar.dart';
import 'package:dags/Common/widgets/app_button_widgets.dart';
import 'package:dags/Features/OrderdetailScreen/view/widgets/order_det_widgets.dart';
import 'package:dags/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../../../Common/Services/API/api_calling.dart';
import '../../../Common/utils/OrderModel.dart';
import '../../../Common/utils/app_colors.dart';
import '../../../Common/utils/image_res.dart';
import '../../../Common/utils/user_model.dart';
import '../../../Common/widgets/text_widgets.dart';

class OrderDetailsScreen extends ConsumerStatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  ConsumerState<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends ConsumerState<OrderDetailsScreen> {
  String setCorrectGrammer(String status) {
    String corrected = '';
    switch (status) {
      case 'pending':
        {
          corrected = "Pending";
        }
        break;
      case 'initiated':
        {
          corrected = "Initiated";
        }
        break;
      case 'readyToPickup':
        {
          corrected = "Ready To Pickup";
        }
        break;
      case 'pickedUp':
        {
          corrected = "Picked Up";
        }
        break;
      case 'readyToDelivery':
        {
          corrected = "Ready For Delivery";
        }
        break;
      case 'outForDelivery':
        {
          corrected = "Out For Delivery";
        }
        break;
      case 'delivered':
        {
          corrected = "Delivered";
        }
        break;
      case 'cancelled':
        {
          corrected = "Cancelled";
        }
        break;
      case 'refunded':
        {
          corrected = "Refunded";
        }
        break;
      case 'cleaning':
        {
          corrected = "Laundry In Progress";
        }
      default:
        {
          corrected = " ";
        }
        break;
    }
    return corrected;
  }

//RegExp regex = RegExp(
//                                 r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
//                             if (!regex.hasMatch(value!)) {
//                               return 'Please enter correct email address';
//                             }
//                             return null;
  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final Order order = data['order']!;
    final fromPast = data['fromPast'];
    final newDate = DateTime.parse(order.orderDate);
    final orderStatus = setCorrectGrammer(order.orderStatus.last.status);
    final deliveryType = order.deliveryType;
    String? orderPic = null;
    if (kDebugMode) {
      print(order.orderPics);
    }
    if (order.orderPics!.isNotEmpty && order.orderPics != null) {
      orderPic = order.orderPics![0];
    }
    final orderDate = DateFormat('E, d MMM yyyy h:mm a').format(newDate);
    final List<Item> items = order.items;
    Color statusColor = Colors.grey.shade500;
    if (orderStatus == 'Cancelled') {
      statusColor = Colors.redAccent;
    } else {
      statusColor = Color.fromARGB(255, 0, 160, 83);
    }
    return WillPopScope(
      onWillPop: () async {
        navKey.currentState
            ?.pushNamedAndRemoveUntil("/order_scr", (routes) => false);
        return false;
      },
      child: Scaffold(
        appBar: buildAppBarWithCustomLeadingNavigation(
            context: context,
            goToApplication: () {
              navKey.currentState
                  ?.pushNamedAndRemoveUntil('/order_scr', (route) => false);
            }),
        body: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                titleRow(orderDate, orderStatus, context),
                SizedBox(
                  height: 5.h,
                ),
                dashLine(
                  color: Colors.grey.shade400,
                ),
                Container(
                  color: Color.fromARGB(255, 245, 201, 5),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  // height: 20,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20.w),
                        child: const textcustomnormal(
                          text: "Order Id:",
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontfamily: "Inter",
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      textcustomnormal(
                        text: "#${order.orderId}",
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        fontfamily: "Inter",
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 120.w,
                      ),
                      (deliveryType == 'express')
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Image.asset(
                                ImageRes.expressicon,
                                height: 30.h,
                                width: 30.h,
                              ))
                          : SizedBox()
                    ],
                  ),
                ),
                // SizedBox(height: 20.h),

                // SizedBox(
                //   height: 20.h,
                // // ),
                // dashLine(
                //   color: Colors.grey.shade400,
                // ),
                // SizedBox(
                //   height: 20.h,
                // ),
                Container(
                  margin: EdgeInsets.only(left: 20.w, top: 10.h),
                  child: const textcustomnormal(
                    text: "Items:",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontfamily: "Inter",
                    color: Colors.black,
                  ),
                ),
                // SizedBox(height: 10.h),
                // dashLine(
                //   color: Colors.black,
                //   height: 1.h,
                // ),
                ListView.builder(
                  itemBuilder: (_, index) {
                    final item = items[index];
                    return itemRow(
                        item.serviceName, item.itemName, item.qty, context);
                  },
                  itemCount: items.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
                SizedBox(
                  height: 20.h,
                ),
                descContainer(order.notes ?? ''),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: (orderPic == null)
                      ? Center(
                          child: textcustomnormal(
                            text: "No image provided by customer",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontfamily: "Inter",
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 0.w),
                              child: textcustomnormal(
                                text: "Picture uploaded by user:",
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                fontfamily: "Inter",
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Image.network(
                              orderPic,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.w),
                  child: const textcustomnormal(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    text: "Order Amount",
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                dashLine(
                  height: 1.h,
                  color: Colors.grey.shade400,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: itemRow02(
                      title: "Total:",
                      price: order.vendorFee.toStringAsFixed(2) ?? '0'),
                ),
                SizedBox(
                  height: 10.h,
                ),
                dashLine(
                  height: 1.h,
                  color: Colors.grey.shade400,
                ),
                SizedBox(
                  height: 20.h,
                ),
                if (order.feedbackRating != 0)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 5.h),
                              child: textcustomnormal(
                                color: const Color(0xff1C254E),
                                text:
                                    "You got ${order.feedbackRating} feedback ratings on this Order",
                                fontWeight: FontWeight.w600,
                                fontfamily: "Poppins",
                                fontSize: 16,
                              ),
                            ),
                            PannableRatingBar(
                              enablePixelsCompensation: false,
                              minRating: 1,
                              maxRating: 5,
                              rate: order.feedbackRating!,
                              items: List.generate(
                                  5,
                                  (index) => RatingWidget(
                                        selectedColor:
                                            Color.fromARGB(255, 255, 186, 59),
                                        unSelectedColor: Colors.grey.shade300,
                                        child: Icon(
                                          Icons.star,
                                          size: 20,
                                        ),
                                      )),
                            ),
                            if (order.feedbackProvided.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 5.h),
                                child: textcustomnormal(
                                  color: const Color(0xff1C254E),
                                  text: "\"${order.feedbackProvided}\"",
                                  fontWeight: FontWeight.w600,
                                  fontfamily: "Poppins",
                                  fontSize: 16,
                                ),
                              ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  height: 30.h,
                ),
                (!fromPast)
                    ? (order.orderStatus.last.status == 'cleaning' &&
                            order.secretKey != null)
                        ? Center(
                            child: appButtons(
                                width: 345.w,
                                height: 54.h,
                                anyWayDoor: () async {
                                  final secretKey = UserModel.secretKey;
                                  final orderId = order.orderId;
                                  bool isSuccess = await API.getLogisticPartner(
                                      secretKey, orderId);
                                  if (isSuccess) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Delivery partner has been assigned.",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor:
                                            AppColors.primaryElement,
                                        textColor: Colors.black,
                                        fontSize: 16.0);
                                    navKey.currentState
                                        ?.pushNamedAndRemoveUntil(
                                            '/application_scr',
                                            (route) => false);
                                  }
                                },
                                buttonBorderWidth: 2.h,
                                buttonText: "Ready for delivery",
                                buttonTextColor: Colors.black),
                          )
                        : const SizedBox()
                    : const SizedBox(),
                SizedBox(
                  height: 40.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// return Container(
// margin: EdgeInsets.symmetric(vertical: 3.h),
// child: GestureDetector(
// onTap: () {
//
// },
// child: Row(
// children: [
// SizedBox(
// width: 20.w,
// ),
// isActive
// ? const Icon(
// Icons.check_box,
// color: Colors.greenAccent,
// )
//     : const Icon(Icons.check_box_outline_blank),
// SizedBox(
// width: 10.w,
// ),
// textcustomnormal(
// text: tasks[index],
// fontSize: 16,
// fontWeight: FontWeight.w400,
// fontfamily: "Inter",
// color: Colors.black,
// ),
// ],
// ),
// ),
// );
