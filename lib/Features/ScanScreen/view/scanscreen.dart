import 'package:dags/Common/utils/user_model.dart';
import 'package:dags/Common/widgets/app_bar.dart';
import 'package:dags/Common/widgets/app_button_widgets.dart';
import 'package:dags/Common/widgets/text_widgets.dart';
import 'package:dags/Features/ScanScreen/Provider/scan_scr_provider.dart';
import 'package:dags/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Common/utils/image_res.dart';

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  String _scanBarcode = 'Unknown';

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      if (barcodeScanRes == '-1') {
        if (kDebugMode) {
          debugPrint('User canceled the scan');
        }
        return; // Exit the function as no valid barcode was scanned
      }
      UserModel.secretKey = barcodeScanRes;
      await ref
          .read(scannerProvider.notifier)
          .updateOrderStatus(barcodeScanRes);

      final order = ref.watch(scannerProvider);
      if (order != null) {
        navKey.currentState?.pushNamed("/order_det_scr",
            arguments: {'order': order, 'fromPast': false});
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
      if (kDebugMode) {
        print(_scanBarcode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.fromLTRB(0, 30.h, 0, 0),
                child: const textcustomnormal(
                  text: "Scan your Bar Code",
                  fontSize: 26,
                  fontfamily: "Inter",
                  fontWeight: FontWeight.w800,
                )),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              height: 270.h,
              width: 400.w,
              child: Image.asset(
                ImageRes.barcodeimage,
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            appButtons(
                height: 65.h,
                width: 330.w,
                buttonText: "SCAN BAR CODE",
                buttonTextColor: Colors.black,
                buttonBorderWidth: 2.h,
                anyWayDoor: () async {
                  await scanBarcodeNormal();
                })
          ],
        ),
      ),
    );
  }
}
