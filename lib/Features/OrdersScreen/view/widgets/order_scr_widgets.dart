import 'package:dags/Features/OrdersScreen/Provider/order_radio_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Common/widgets/text_widgets.dart';

class orderTopTitle extends StatefulWidget {
  const orderTopTitle({super.key});


  @override
  State<orderTopTitle> createState() => _orderTopTitleState();
}

class _orderTopTitleState extends State<orderTopTitle> {
  final items = ["New Orders", "Previous Orders", "Last Month"];
  String ? value="New Orders";
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(25.w, 15.h, 0, 0),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        const textcustomnormal(
          text: "Orders",
          fontfamily: "Inter",
          fontSize: 22,
          color: Color(0xff1C254E),
          fontWeight: FontWeight.w700,
        ),
        SizedBox(
          width: 60.w,
        ),
        // Container(
        //     margin: EdgeInsets.fromLTRB(0, 6.h, 0, 0),
        //     child: const textcustomnormal(
        //         text: "Sort by",
        //         color: Color(0xff1C254E),
        //         fontSize: 18,
        //         fontfamily: "Inter",
        //         fontWeight: FontWeight.w700)),
        // SizedBox(width: 10.w,),
        // Container(
        //    width: 155.w,
        //     margin: EdgeInsets.fromLTRB(0, 7.h, 0, 0),
        //     child: DropdownButton<String>(
        //       value: value,
        //       items: items.map(buildMenuItem).toList(),
        //       onChanged: (value) {
        //         setState(() {
        //           this.value=value;
        //         });
        //       },
        //     )),
      ]),
    );
  }
}
Widget radioSwipeableButton(
    {void Function()? selectRadio01,
    void Function()? selectRadio02,
    required WidgetRef ref}) {
  bool active = ref.watch(orderRadioNotifierProvider);
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: selectRadio01!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(40.w, 0, 0, 0),
              child: const textcustomnormal(
                text: "Active Orders",
                fontSize: 16,
                fontfamily: "Inter",
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              width: 195.w,
              height: 2.h,
              color: active ? const Color(0xff1C254E) : Colors.grey.shade400,
            )
          ],
        ),
      ),
      GestureDetector(
        onTap: selectRadio02!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(60.w, 0, 0, 0),
              child: const textcustomnormal(
                text: "Past Order",
                fontSize: 16,
                fontfamily: "Inter",
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              width: 195.w,
              height: 2.h,
              color: active ? Colors.grey.shade400 : const Color(0xff1C254E),
            )
          ],
        ),
      )
    ],
  );
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
