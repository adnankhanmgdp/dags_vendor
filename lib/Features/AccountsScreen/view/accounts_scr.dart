import 'package:dags/Common/widgets/app_bar.dart';
import 'package:dags/Common/widgets/app_shadow.dart';
import 'package:dags/Common/widgets/image_widgets.dart';
import 'package:dags/Common/widgets/text_widgets.dart';
import 'package:dags/Features/AccountsScreen/Controller/vendor_profile_controllers.dart';
import 'package:dags/Features/AccountsScreen/provider/vendor_profile_data_model.dart';
import 'package:dags/Features/AccountsScreen/provider/vendor_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountsScreen extends ConsumerStatefulWidget {
  const AccountsScreen({super.key});

  @override
  ConsumerState<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends ConsumerState<AccountsScreen> {
  String vendorId = '';
  late VendorProfileControllers controllers;
  String profilePicPath = '';
  BankDetails? bankDetails;
  TextEditingController accountHolderController = TextEditingController();
  TextEditingController bankAddressController = TextEditingController();

  @override
  void initState() {
    ref.read(vendorProvider.notifier).fetchVendorProfile();
    controllers = VendorProfileControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vendorProfile = ref.watch(vendorProvider);
    if (vendorProfile != null) {
      controllers.vendorAddressController.text = vendorProfile.address;
      controllers.vendorEmailController.text = vendorProfile.email;
      profilePicPath = vendorProfile.profilePic;
      vendorId = vendorProfile.vendorId;
      if (vendorProfile.bankDetails != null) {
        bankDetails = vendorProfile.bankDetails;
        accountHolderController.text = bankDetails?.accountHolderName;
        bankAddressController.text = bankDetails?.branch;
      }
    } else {
      controllers.vendorAddressController.text = "";
      controllers.vendorEmailController.text = "";
    }

    return Scaffold(
        appBar: buildAppBar(context: context),
        body: (vendorProfile == null)
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(20.w, 15.h, 0, 0),
                      child: const textcustomnormal(
                        text: "My Profile",
                        fontfamily: "Inter",
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    dashLine(
                      color: Colors.grey.shade300,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 40.h, 0, 0),
                      alignment: Alignment.topCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          circularProfileImage(
                              radius: 80.h, imagePath: profilePicPath),
                          SizedBox(
                            height: 10.h,
                          ),
                          textcustomnormal(
                            fontfamily: "Inter",
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.black,
                            text: "Vendor: #$vendorId",
                          ),
                          // customIconAppButton(
                          //     width: 220.w,
                          //     height: 50.h,
                          //     buttonRadius: 20,
                          //     buttonColor: Colors.grey.shade200,
                          //     buttonText: "Edit Profile Picture",
                          //     buttonTextColor: const Color(0xffF14B4B),
                          //     borderColor: AppColors.primaryElement,
                          //     anyWayDoor: () {
                          //
                          //     }),
                          SizedBox(
                            height: 10.h,
                          ),
                          dashLine(
                            width: 200.w,
                            color: Colors.grey.shade300,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const textcustomnormal(
                            fontfamily: "Inter",
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: Colors.black,
                            text: "Delivery Partner Info:",
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Center(
                            child: Container(
                              padding: EdgeInsets.only(top: 0.h, left: 15.w),
                              width: double.maxFinite,
                              height: 45.h,
                              decoration: appBoxDecoration(
                                  color: Colors.grey.shade200,
                                  radius: 10.h,
                                  borderColor: Colors.grey.shade400),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  textcustomnormal(
                                    text: "Name:",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontfamily: "Inter",
                                    color: Colors.grey.shade600,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  textcustomnormal(
                                    text: vendorProfile.name,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontfamily: "Inter",
                                    color: Colors.grey.shade600,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Center(
                            child: Container(
                              padding: EdgeInsets.only(top: 0.h, left: 15.w),
                              width: double.maxFinite,
                              height: 45.h,
                              decoration: appBoxDecoration(
                                  color: Colors.grey.shade200,
                                  radius: 10.h,
                                  borderColor: Colors.grey.shade400),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  textcustomnormal(
                                    text: "Email:",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontfamily: "Inter",
                                    color: Colors.grey.shade600,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  SizedBox(
                                    width: 250.w,
                                    height: 45.h,
                                    child: TextField(
                                      keyboardType: TextInputType.emailAddress,
                                      controller:
                                          controllers.vendorEmailController,
                                      // this is for decorating the text field
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              5.h, 3.h, 0, 3),
                                          border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent)),

                                          ///this is the default border active when not focused
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .transparent)),

                                          /// this is the focused border
                                          focusedBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .transparent)),

                                          ///this will be used when a text field in disabled
                                          disabledBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.transparent))),
                                      maxLines: 1,
                                      autocorrect: false,
                                      readOnly: true,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Inter",
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Center(
                            child: Container(
                              padding: EdgeInsets.only(top: 0.h, left: 15.w),
                              width: double.maxFinite,
                              decoration: appBoxDecoration(
                                  color: Colors.grey.shade200,
                                  radius: 10.h,
                                  borderColor: Colors.grey.shade400),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  textcustomnormal(
                                    text: "Address:",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontfamily: "Inter",
                                    color: Colors.grey.shade600,
                                  ),
                                  SizedBox(
                                    width: 230.w,
                                    child: TextField(
                                      minLines: 1,

                                      keyboardType: TextInputType.emailAddress,
                                      controller:
                                          controllers.vendorAddressController,
                                      //this is for decorating the text field
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              5.w, 3.h, 0, 3),
                                          border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent)),

                                          ///this is the default border active when not focused
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .transparent)),

                                          /// this is the focused border
                                          focusedBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .transparent)),

                                          ///this will be used when a text field in disabled
                                          disabledBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.transparent))),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Inter",
                                        color: Colors.grey.shade600,
                                      ),
                                      maxLines: 10,
                                      autocorrect: false,
                                      readOnly: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Center(
                            child: Container(
                              padding: EdgeInsets.only(top: 0.h, left: 15.w),
                              width: double.maxFinite,
                              height: 45.h,
                              decoration: appBoxDecoration(
                                  color: Colors.grey.shade200,
                                  radius: 10.h,
                                  borderColor: Colors.grey.shade400),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  textcustomnormal(
                                    text: "Capacity:",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontfamily: "Inter",
                                    color: Colors.grey.shade600,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  textcustomnormal(
                                    text:
                                        "upto ${vendorProfile.capacity} orders/day",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontfamily: "Inter",
                                    color: Colors.grey.shade600,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Center(
                            child: dashLine(
                              width: 200.w,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          const textcustomnormal(
                            fontfamily: "Inter",
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: Colors.black,
                            text: "Bank Details:",
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const textcustomnormal(
                                    fontfamily: "Inter",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: Colors.black,
                                    text: "Account holder name:",
                                  ),
                                  Expanded(
                                    child: Text(
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                        color: Colors.black,
                                      ),
                                      "${bankDetails?.accountHolderName}",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const textcustomnormal(
                                    fontfamily: "Inter",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    align: TextAlign.start,
                                    color: Colors.black,
                                    text: "Account number:",
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Expanded(
                                    child: textcustomnormal(
                                      fontfamily: "Inter",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Colors.black,
                                      text: bankDetails?.accountNumber,
                                      align: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const textcustomnormal(
                                    fontfamily: "Inter",
                                    fontWeight: FontWeight.w500,
                                    align: TextAlign.start,
                                    fontSize: 17,
                                    color: Colors.black,
                                    text: "Bank name:",
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Expanded(
                                    child: textcustomnormal(
                                      align: TextAlign.start,
                                      fontfamily: "Inter",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Colors.black,
                                      text: bankDetails?.bankName,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const textcustomnormal(
                                    fontfamily: "Inter",
                                    align: TextAlign.start,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: Colors.black,
                                    text: "Branch:",
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Expanded(
                                    child: textcustomnormal(
                                        align: TextAlign.start,
                                        fontfamily: "Inter",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                        color: Colors.black,
                                        text: "${bankDetails?.branch}"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const textcustomnormal(
                                    fontfamily: "Inter",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    align: TextAlign.start,
                                    color: Colors.black,
                                    text: "IFSC code:",
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Expanded(
                                    child: textcustomnormal(
                                      align: TextAlign.start,
                                      fontfamily: "Inter",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Colors.black,
                                      text: bankDetails?.ifsc,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          dashLine(
                            width: MediaQuery.of(context).size.width * 0.9,
                            color: Colors.grey.shade300,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                              textAlign: TextAlign.center,
                              "Your payments will be settled in the above bank account. 💸"),
                          SizedBox(
                            height: 20.h,
                          ),
                          Center(
                            child: Text(
                                textAlign: TextAlign.center,
                                "To update bank details kindly contact"),
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () async {
                                await launchUrl(Uri.parse(
                                    'mailto:admin@dagstechnology.in'));
                              },
                              child: Text(
                                textAlign: TextAlign.center,
                                "admin@dagstechnology.in",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50.h,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ));
  }
}
