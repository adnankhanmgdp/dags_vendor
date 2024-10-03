import 'package:dags/Common/widgets/app_bar.dart';
import 'package:dags/Features/TransactionScreen/Provider/settlement_model.dart';
import 'package:dags/Features/TransactionScreen/Provider/settlement_provider.dart';
import 'package:dags/Features/TransactionScreen/view/widgets/transaction_scr_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../Common/widgets/text_widgets.dart';
import '../../../main.dart';

class TransactionHistoryScreen extends ConsumerStatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  ConsumerState<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState
    extends ConsumerState<TransactionHistoryScreen> {
  String totalEarning = '';
  String dueSettlementAmount = '0';
  List<History> historyList = [];
  bool isLoading = false;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    ref.read(settlementHistoryProvider.notifier).fetchSettlementHistory();
    setState(() {
      isLoading = false;
    });
    super.initState();
  }

  void setSettlementData(SettlementHistory? response) {
    final history = response?.history;
    final amountEarned = response?.amountEarned;
    final dueAmount = response?.dueAmount;
    if (kDebugMode) {
      print(dueAmount);
    }
    totalEarning = amountEarned!.truncate().toString();
    if (dueAmount!.isNotEmpty) {
      dueSettlementAmount = dueAmount[0].totalAmount.truncate().toString();
    }
    if (history!.isNotEmpty) {
      historyList = history;
    }
  }

  @override
  Widget build(BuildContext context) {
    final settlementData = ref.watch(settlementHistoryProvider);
    if (settlementData != null) {
      setSettlementData(settlementData);
    }
    return WillPopScope(
      onWillPop: () async {
        navKey.currentState
            ?.pushNamedAndRemoveUntil("/application_scr", (routes) => false);
        return false;
      },
      child: Scaffold(
          appBar: buildAppBarWithActionAndLeading(
              context: context,
              goToApplication: () {
                navKey.currentState?.pushNamedAndRemoveUntil(
                    "/application_scr", (route) => false);
              }),
          body: (isLoading)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : (settlementData == null)
                  ? const Center(
                      child: textcustomnormal(
                      text: "No settlement history available",
                      fontSize: 20,
                      fontfamily: "Inter",
                      fontWeight: FontWeight.w600,
                    ))
                  : SafeArea(
                      child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            settlementCardContainer(
                                totalEarning, dueSettlementAmount),
                            SizedBox(
                              height: 30.h,
                            ),
                            const listHeading(),
                            SizedBox(
                              height: 7.h,
                            ),
                            historyList.isEmpty
                                ? Container(
                                  margin: EdgeInsets.only(top: 150.h),
                                  child: const Center(
                                      child: textcustomnormal(
                                      text: "No settlement history available",
                                      fontSize: 20,
                                      fontfamily: "Inter",
                                      fontWeight: FontWeight.w600,
                                    )),
                                )
                                : ListView.builder(
                                    itemBuilder: (_, index) {
                                      final currentHistory = historyList[index];
                                      final date = currentHistory.date;
                                      final orderDate =
                                          DateFormat('E, d MMM yyyy h:mm a')
                                              .format(date);
                                      final amount = currentHistory.amount
                                          .truncate()
                                          .toString();
                                      return transactionOrderCardCommon(
                                          amount: amount,
                                          dateAndTime: orderDate);
                                    },
                                    itemCount: historyList.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                  ),
                            SizedBox(
                              height: 100.h,
                            )
                          ]),
                    ))),
    );
  }
}
