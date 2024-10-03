import 'package:dags/Common/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../Common/utils/image_res.dart';
import '../../../../Common/widgets/app_shadow.dart';
import '../../../../Common/widgets/text_widgets.dart';
import 'Orderdata.dart';

class topTitle extends StatefulWidget {
  const topTitle({super.key});

  @override
  State<topTitle> createState() => _topTitleState();
}

class _topTitleState extends State<topTitle> {
  final items = ["This Week", "Last Week", "Next Week"];
  String? value = "This Week";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(25.w, 10.h, 0, 0),
      child: const Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        textcustomnormal(
          text: "Dashboard",
          fontfamily: "Inter",
          fontSize: 22,
          color: Color(0xff1C254E),
          fontWeight: FontWeight.w700,
        ),
        // SizedBox(
        //   width: 80.w,
        // ),
        // DropdownButton<String>(
        //           value: value,
        //           items: items.map(buildMenuItem).toList(),
        //           onChanged: (value) {
        // setState(() {
        //   this.value = value;
        // });
        //           },
        //         ),
        // const textcustomnormal(
        //     text: "2024",
        //     color: Color(0xff1C254E),
        //     fontSize: 15,
        //     fontfamily: "Inter",
        //     fontWeight: FontWeight.w700),
      ]),
    );
  }
}

Widget calenderRow(
    {String leftdate = "April 8, 2024",
    String rightdate = "April 8, 2024",
    void Function()? leftdatePick,
    void Function()? rightdatePick}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        width: 10.w,
      ),
      GestureDetector(
          onTap: leftdatePick!, child: Image.asset(ImageRes.calenderimage)),
      SizedBox(
        width: 7.w,
      ),
      textcustomnormal(
        text: leftdate,
        color: const Color(0xff1C254E),
        fontSize: 16,
        fontfamily: "Inter",
        fontWeight: FontWeight.w600,
      ),
      SizedBox(
        width: 7.w,
      ),
      Image.asset(ImageRes.arrowimage),
      SizedBox(
        width: 7.w,
      ),
      GestureDetector(
          onTap: rightdatePick, child: Image.asset(ImageRes.calenderimage)),
      SizedBox(
        width: 7.w,
      ),
      textcustomnormal(
        text: rightdate,
        color: const Color(0xff1C254E),
        fontSize: 16,
        fontfamily: "Inter",
        fontWeight: FontWeight.w600,
      ),
      SizedBox(
        width: 10.w,
      ),
    ],
  );
}

Widget graphImage() {
  return Image.asset(ImageRes.graphimage);
}

Widget listHeadingRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        width: 20.w,
      ),
      const textcustomnormal(
        text: "Settlement History",
        fontfamily: "Inter",
        fontSize: 20,
        color: Color(0xff1C254E),
        fontWeight: FontWeight.w700,
      ),
      SizedBox(
        width: 80.w,
      ),
      const Icon(Icons.keyboard_double_arrow_down),
      SizedBox(
        width: 5.w,
      ),
      const textcustomnormal(
        text: "Sort by",
        color: Color(0xff1C254E),
        fontSize: 14,
        fontfamily: "Inter",
        fontWeight: FontWeight.w600,
      ),
    ],
  );
}

class OrdersHeading extends StatefulWidget {
  const OrdersHeading({super.key});

  @override
  State<OrdersHeading> createState() => _OrdersHeadingState();
}

class _OrdersHeadingState extends State<OrdersHeading> {
  final items = ["Amount", "Date"];
  String? value = "Date";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 20.w,
        ),
        const textcustomnormal(
          text: "Orders History",
          fontfamily: "Inter",
          fontSize: 20,
          color: Color(0xff1C254E),
          fontWeight: FontWeight.w700,
        ),
        SizedBox(
          width: 100.w,
        ),
        Container(
            margin: EdgeInsets.only(top: 2.h),
            child: DropdownButton<String>(
              value: value,
              items: items.map(buildMenuItem).toList(),
              onChanged: (value) {
                setState(() {
                  this.value = value;
                });
              },
            )),
      ],
    );
  }
}

Widget orderRow(
    String cardText, String amount, BuildContext context, Color col) {
  return Container(
    margin: EdgeInsets.fromLTRB(10.h, 0, 0, 0),
    child: Card(
        margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
        shadowColor: Colors.grey.shade400,
        elevation: 5.0,
        clipBehavior: Clip.hardEdge,
        child: Container(
          alignment: Alignment.center,
          width: (MediaQuery.of(context).size.width / 3) * 0.9,
          decoration: appBoxDecoration(
              color: col,
              radius: 10,
              borderWidth: 0,
              borderColor: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: 100.h,
                child: textcustomnormal(
                  text: cardText,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontfamily: "Inter",
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: 100.h,
                child: textcustomnormal(
                  text: amount,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontfamily: "Inter",
                  color: Colors.black,
                ),
              ),
            ],
          ),
        )),
  );
}

double findMaxRevenue(List<RevenueGenerated> revenue) {
  double maxRevenue = 0;
  for (int i = 0; i < revenue.length; i++) {
    if (revenue[i].revenue > maxRevenue) maxRevenue = revenue[i].revenue;
  }
  return maxRevenue + 50;
}

Widget dashboardChart(
    {required List<OrderData> orders,
    required List<RevenueGenerated> revenue}) {
  return SizedBox(
      height: 300.h,
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(
          title: AxisTitle(text: "Week days"),
          majorGridLines: MajorGridLines(width: 0.0),
        ),
        primaryYAxis: NumericAxis(
          title: AxisTitle(text: "Number of orders"),
          minimum: 0,
          maximum: findMaxRevenue(revenue),
          majorGridLines: MajorGridLines(width: 0.3),
        ),
        tooltipBehavior: TooltipBehavior(
          enable: true,
        ),
        series: [
          ColumnSeries<OrderData, String>(
              dataSource: orders,
              xValueMapper: (OrderData data, _) => data.day,
              yValueMapper: (OrderData data, _) => data.noOfOrders,
              width: 0.7,
              name: 'Orders placed',
              color: AppColors.primaryElement),
          ColumnSeries<RevenueGenerated, String>(
            dataSource: revenue,
            xValueMapper: (RevenueGenerated data, _) => data.day,
            yValueMapper: (RevenueGenerated data, _) => data.revenue,
            color: const Color(0xff1d254e),
            width: 0.7,
            name: "Revenue Generated",
          )
        ],
      ));
}

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: textcustomnormal(
      text: item,
      color: const Color(0xff1C254E),
      fontSize: 15,
      fontfamily: "Inter",
      fontWeight: FontWeight.w700,
    ));
