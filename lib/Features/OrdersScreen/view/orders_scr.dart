import 'package:dags/Common/widgets/app_bar.dart';
import 'package:dags/Common/widgets/app_button_widgets.dart';
import 'package:dags/Common/widgets/text_widgets.dart';
import 'package:dags/Features/OrdersScreen/Provider/active_order_provider.dart';
import 'package:dags/Features/OrdersScreen/Provider/order_radio_notifier.dart';
import 'package:dags/Features/OrdersScreen/Provider/past_order_provider.dart';
import 'package:dags/Features/OrdersScreen/view/widgets/order_scr_widgets.dart';
import 'package:dags/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  @override
  void didChangeDependencies() {
    ref.read(activeOrderProvider.notifier).fetchActiveOrders();
    ref.read(pastOrderProvider.notifier).fetchPastOrders();
    super.didChangeDependencies();
  }

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

  @override
  Widget build(BuildContext context) {
    bool isActive = ref.watch(orderRadioNotifierProvider);
    final activeOrders = ref.watch(activeOrderProvider);
    final pastOrders = ref.watch(pastOrderProvider);
    return WillPopScope(
      onWillPop: () async {
        navKey.currentState
            ?.pushNamedAndRemoveUntil("/application_scr", (routes) => false);
        return false;
      },
      child: Scaffold(
        appBar: buildAppBarWithActionAndLeading(
            context: context,
            goToApplication: () => navKey.currentState?.pushNamedAndRemoveUntil(
                "/application_scr", (route) => false)),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const orderTopTitle(),
              SizedBox(
                height: 10.h,
              ),
              dashLine(
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 10.h,
              ),
              radioSwipeableButton(
                  ref: ref,
                  selectRadio01: () {
                    setState(() {
                      ref
                          .read(orderRadioNotifierProvider.notifier)
                          .changeBool(true);
                    });
                  },
                  selectRadio02: () {
                    setState(() {
                      ref
                          .read(orderRadioNotifierProvider.notifier)
                          .changeBool(false);
                    });
                  }),
              SizedBox(
                height: 10.h,
              ),
              (isActive)
                  ? Container(
                      child: (activeOrders.isEmpty)
                          ? Padding(
                              padding: EdgeInsets.only(top: 250.h),
                              child: const Center(
                                  child: textcustomnormal(
                                text: "No active orders available",
                                fontSize: 20,
                                fontfamily: "Inter",
                                fontWeight: FontWeight.w600,
                              )),
                            )
                          : ListView.builder(
                              itemBuilder: (_, index) {
                                final order = activeOrders[index];
                                final vendorFee = order.vendorFee.toString();
                                final deliveryType = order.deliveryType;
                                final status = setCorrectGrammer(
                                    order.orderStatus.last.status);
                                final orderNumber = order.orderId;
                                final newDate = DateTime.parse(
                                    order.pickupDate ?? order.orderDate);
                                final orderDate =
                                    DateFormat('E, d MMM yyyy h:mm a')
                                        .format(newDate);
                                final itemLength = order.items.length;
                                print(order.pickupDate);
                                return orderCardCommon(
                                    vendorFee: double.parse(vendorFee)
                                        .round()
                                        .toString(),
                                    status: status,
                                    orderNumber: orderNumber,
                                    orderDate: orderDate,
                                    itemLength: itemLength,
                                    deliveryType: deliveryType,
                                    goToDetails: () {
                                      navKey.currentState?.pushNamed(
                                          "/order_det_scr",
                                          arguments: {
                                            'order': order,
                                            'fromPast': false
                                          });
                                    });
                              },
                              itemCount: activeOrders.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                            ))
                  : Container(
                      child: (pastOrders.isEmpty)
                          ? Padding(
                              padding: EdgeInsets.only(top: 250.h),
                              child: const Center(
                                  child: textcustomnormal(
                                text: "No past orders available",
                                fontSize: 20,
                                fontfamily: "Inter",
                                fontWeight: FontWeight.w600,
                              )),
                            )
                          : ListView.builder(
                              itemBuilder: (_, index) {
                                final order = pastOrders[index];
                                final vendorFee = order.vendorFee;
                                final status = setCorrectGrammer(
                                    order.orderStatus.last.status);
                                final deliveryType = order.deliveryType;
                                final orderNumber = order.orderId;
                                final newDate02 =
                                    DateTime.parse(order.orderDate);
                                final orderRating = order.feedbackRating;
                                final orderDate =
                                    DateFormat('E, d MMM yyyy h:mm a')
                                        .format(newDate02);
                                final itemLength = order.items.length;
                                print(order.orderDate);
                                return orderCardCommon(
                                    vendorFee: vendorFee.round().toString(),
                                    status: status,
                                    orderNumber: orderNumber,
                                    orderDate: orderDate,
                                    itemLength: itemLength,
                                    deliveryType: deliveryType,
                                    goToDetails: () {
                                      navKey.currentState?.pushNamed(
                                          "/order_det_scr",
                                          arguments: {
                                            'order': order,
                                            'fromPast': true
                                          });
                                    },
                                    orderRating: orderRating!);
                              },
                              itemCount: pastOrders.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                            )),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
