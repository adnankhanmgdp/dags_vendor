import 'package:dags/Common/utils/user_model.dart';
import 'package:dags/Common/widgets/app_text_fields.dart';
import 'package:dags/Features/VendorScreen/Controller/VendorController.dart';
import 'package:dags/Features/VendorScreen/Provider/vendor_notifier.dart';
import 'package:dags/Features/VendorScreen/view/widgets/vendor_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Common/utils/app_colors.dart';
import '../../../Common/widgets/app_button_widgets.dart';
import '../../SignUp/view/widgets/register_screen_widgets.dart';

class VendorScreen extends ConsumerStatefulWidget {
  const VendorScreen({super.key});

  @override
  ConsumerState<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends ConsumerState<VendorScreen> {
  late VendorController controller;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    // it will make sure that the SignInController is initialized...
    controller = VendorController();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ScreenHeight = MediaQuery.of(context).size.height;
    final ScreenWidth = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
        designSize: Size(ScreenWidth, ScreenHeight),
        builder: (context, child) => SafeArea(
            child: Scaffold(
                backgroundColor: Colors.white,
                body: isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 60.h,
                                ),
                                logoNew(size),
                                SizedBox(
                                  height: 5.h,
                                ),
                                vendorText(),
                                vendorText02(),
                                SizedBox(
                                  height: 30.h,
                                ),
                                textLoginBoxWithDimensions(
                                    height: 45.h,
                                    width: 325.w,
                                    hintText: "Vendor Name",
                                    capitalization: TextCapitalization.words,
                                    validateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value!.startsWith(" ") ||
                                          value.endsWith(" "))
                                        return "Enter full name";
                                      RegExp re = RegExp(r"^[A-Za-z ]{3,}$");
                                      if (!re.hasMatch(value))
                                        return "Enter your full name.";
                                      return null;
                                    },
                                    func: (value) => ref
                                        .read(vendorNotifierProvider.notifier)
                                        .onUserNameChange(value)),
                                SizedBox(
                                  height: 15.h,
                                ),
                                textLoginBoxWithDimensions(
                                    height: 45.h,
                                    width: 325.w,
                                    hintText: "Complete Shop Address",
                                    capitalization: TextCapitalization.words,
                                    validateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value!.startsWith(" ") ||
                                          value.endsWith(" "))
                                        return "Enter a valid address";
                                      RegExp regex =
                                          RegExp(r'^[a-zA-Z0-9\/,\- ]{10,}$');
                                      if (!regex.hasMatch(value!)) {
                                        return "Enter your complete shop address.";
                                      }
                                      return null;
                                    },
                                    func: (value) => ref
                                        .read(vendorNotifierProvider.notifier)
                                        .onUserAddressChange(value)),
                                SizedBox(
                                  height: 15.h,
                                ),
                                textLoginBoxWithDimensions(
                                    height: 45.h,
                                    width: 325.w,
                                    capitalization: TextCapitalization.none,
                                    keyboardType: TextInputType.emailAddress,
                                    validateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value!.startsWith(" ") ||
                                          value.endsWith(" "))
                                        return "Enter a valid email";
                                      if (value!.isEmpty)
                                        return "Enter your business/personal email address.";
                                      RegExp regex = RegExp(
                                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                      if (!regex.hasMatch(value)) {
                                        return 'Please enter correct email address';
                                      }
                                      return null;
                                    },
                                    hintText: "Email Id",
                                    func: (value) => ref
                                        .read(vendorNotifierProvider.notifier)
                                        .onUserEmailChange(value)),
                                SizedBox(
                                  height: 15.h,
                                ),
                                textLoginBoxWithDimensions(
                                    height: 45.h,
                                    width: 325.w,
                                    hintText: "Daily Capacity (Orders per day)",
                                    keyboardType: TextInputType.number,
                                    validateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value!.startsWith(" ") ||
                                          value.endsWith(" "))
                                        return "Enter a valid capacity";
                                      if (value!.isEmpty)
                                        return "Enter max number of orders you can process daily.";
                                      if (value.contains('-'))
                                        return "Enter a valid value";
                                      return null;
                                    },
                                    func: (value) => ref
                                        .read(vendorNotifierProvider.notifier)
                                        .onUserCapacityChange(value)),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                  height: 70.h,
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        left: 29.w, right: 25.w),
                                    child: appButtons(
                                        buttonText: "Next",
                                        buttonColor: AppColors.primaryElement,
                                        buttonTextColor: AppColors.primaryText,
                                        buttonBorderWidth: 2.h,
                                        anyWayDoor: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            controller.addVendor(ref);
                                          }
                                        })),
                                SizedBox(
                                  height: 5.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))));
  }
}
