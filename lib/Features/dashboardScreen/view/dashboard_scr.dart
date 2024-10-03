import 'dart:async';
import 'package:dags/Common/utils/app_colors.dart';
import 'package:dags/Common/utils/constants.dart';
import 'package:dags/Common/utils/user_model.dart';
import 'package:dags/Common/widgets/app_bar.dart';
import 'package:dags/Common/widgets/app_button_widgets.dart';
import 'package:dags/Features/dashboardScreen/Provider/dashboard_notifier.dart';
import 'package:dags/Features/dashboardScreen/Provider/revenue_provider.dart';
import 'package:dags/Features/dashboardScreen/view/widgets/Orderdata.dart';
import 'package:dags/Features/dashboardScreen/view/widgets/dashboard_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import '../../../Common/Services/API/api_calling.dart';
import '../../../Common/Services/global.dart';
import '../../../Common/widgets/text_widgets.dart';
import '../Provider/revenue_model.dart';

class DashBoardScreen extends ConsumerStatefulWidget {
  const DashBoardScreen({super.key});

  @override
  ConsumerState<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends ConsumerState<DashBoardScreen> {
  List<OrderData> orders = [];
  List<RevenueGenerated> revenue = [];
  Location location = Location();
  String leftDate = "12/05/2004";
  String rightDate = "31/06/2024";
  bool isLoading = false;

  Future<LocationData> _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Future.error('Location services  are not enabled');
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return Future.error('Location permissions are denied');
      }
    }
    _locationData = await location.getLocation();
    return _locationData;
  }

  @override
  void initState() {
    super.initState();
  }

  // Future<void> selectLeftDate() async {
  //   DateTime? datePicked = await showDatePicker(
  //       context: context,
  //       firstDate: DateTime(2000),
  //       lastDate: DateTime(2100),
  //       initialDate: DateTime.now());
  //   if (datePicked != null) {
  //     setState(() {
  //       leftDate = datePicked.toString().split(" ")[0];
  //     });
  //   }
  // }
  //
  // Future<void> selectRightDate() async {
  //   DateTime? datePicked = await showDatePicker(
  //       context: context,
  //       firstDate: DateTime(2000),
  //       lastDate: DateTime(2100),
  //       initialDate: DateTime.now());
  //   if (datePicked != null) {
  //     setState(() {
  //       rightDate = datePicked.toString().split(" ")[0];
  //     });
  //   }
  // }

  void setGraphData(List<RevenueData> revenueResponse) {
    for (var rev in revenueResponse) {
      final dayName = rev.dayOfWeek.toString().substring(0, 3);
      orders.add(OrderData(dayName, rev.count.toDouble()));
      revenue.add(RevenueGenerated(dayName, rev.totalRevenue.toDouble()));
    }
  }

  @override
  Future<void> didChangeDependencies() async {
    String lat = '';
    String long = '';
    String appOpen = UserModel.isAppOpen;
    if (appOpen.isEmpty) {
      if (kDebugMode) {
        print('screen is opened first time.');
      }
      setState(() {
        isLoading = true;
      });
      await _getLocation().then((value) async {
        lat = "${value.latitude}";
        long = "${value.longitude}";
        final String phoneNumber =
            Global.storageServices.getString(AppConstants.userPhoneNumber);
        if (kDebugMode) {
          print("latitude is $lat, longitude is $long");
        }
        bool isSuccess = await API.uploadVendorProfilePic(
            phoneNumber: phoneNumber, lat: lat, long: long);
        if (isSuccess) {
          if (kDebugMode) {
            print('location is confirmed added from dashboard also.');
          }
        }
      });
    }
    ref.read(ordersProvider.notifier).fetchOrders();
    final dateToday = DateTime.now();
    final endDate = dateToday.subtract(const Duration(days: 1));
    final startDate = dateToday.subtract(const Duration(days: 7));
    ref.read(revenueProvider.notifier).fetchRevenueData(startDate, endDate);
    UserModel.isAppOpen = "true value";
    setState(() {
      isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final orderResponse = ref.watch(ordersProvider);
    final revenueResponse = ref.watch(revenueProvider);
    setGraphData(revenueResponse);
    return Scaffold(
      appBar: buildAppBarWithAction(),
      body: (isLoading)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(child: CircularProgressIndicator()),
                SizedBox(
                  height: 15.h,
                ),
                const textcustomnormal(
                  text: "Fetching location And getting things ready",
                  fontSize: 20,
                  fontfamily: "Inter",
                  fontWeight: FontWeight.w600,
                )
              ],
            )
          : (orderResponse != null)
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const topTitle(),
                      SizedBox(
                        height: 5.h,
                      ),
                      dashLine(
                        color: Colors.grey.shade300,
                      ),
                      // calenderRow(
                      //     leftdate: leftDate,
                      //     rightdate: rightDate,
                      //     leftdatePick: () => selectLeftDate(),
                      //     rightdatePick: () => selectRightDate()),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                          alignment: Alignment.center,
                          color: Colors.grey.shade200,
                          height: 170.h,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    orderRow(
                                        "Total Orders Today",
                                        orderResponse.totalNoOfOrdersToday
                                            .toString(),
                                        context,
                                        Color.fromARGB(255, 255, 241, 162)),
                                    orderRow(
                                        "Total Order Completed",
                                        orderResponse.totalCompletedOrders
                                            .toString(),
                                        context,
                                        Color.fromARGB(255, 165, 197, 255)),
                                    orderRow(
                                        "Payment Generated",
                                        "₹ ${orderResponse.totalAmountToday.round()}"
                                            .toString(),
                                        context,
                                        Color.fromARGB(255, 175, 255, 175)),
                                    SizedBox(width: 10.w)
                                  ],
                                ),
                              ))),
                      SizedBox(
                        height: 30.h,
                      ),
                      Container(
                          margin: EdgeInsets.only(right: 10),
                          child:
                              dashboardChart(orders: orders, revenue: revenue)),
                      SizedBox(
                        height: 10.h,
                      ),
                      Center(
                        child: appButtons(
                          height: 54.h,
                          width: 330.w,
                          buttonBorderWidth: 2.h,
                          anyWayDoor: () {
                            Fluttertoast.showToast(
                                msg:
                                    "This feature will be released after beta testing.",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: AppColors.primaryElement,
                                textColor: Colors.black,
                                fontSize: 16.0);
                          },
                          buttonTextColor: Colors.black,
                          buttonText: "Share Report",
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
    );
  }
}
