import 'package:dags/Common/utils/constants.dart';
import 'package:dags/Common/utils/image_res.dart';
import 'package:dags/Common/utils/user_model.dart';
import 'package:dags/Common/widgets/app_bar.dart';
import 'package:dags/Common/widgets/app_button_widgets.dart';
import 'package:dags/Common/widgets/app_shadow.dart';
import 'package:dags/Common/widgets/image_widgets.dart';
import 'package:dags/Common/widgets/text_widgets.dart';
import 'package:dags/Features/AccountsScreen/provider/vendor_profile_provider.dart';
import 'package:dags/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Common/Services/global.dart';
import '../../../Common/utils/app_colors.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  String name = '';
  String email = '';
  String profileUrl = '';

  @override
  void initState() {
    ref.read(vendorProvider.notifier).fetchVendorProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vendorProfile = ref.watch(vendorProvider);
    if (vendorProfile != null) {
      profileUrl = vendorProfile.profilePic;
      if (vendorProfile.name.isEmpty) {
        name = Global.storageServices.getString(AppConstants.userName);
      } else {
        name = vendorProfile.name;
      }
      if (vendorProfile.email.isEmpty) {
        email = Global.storageServices.getString(AppConstants.userEmail);
      } else {
        email = vendorProfile.email;
      }
      if (kDebugMode) {
        print('name is ->$name and email is ->$email');
      }
    }
    final String phoneNumber =
        Global.storageServices.getString(AppConstants.userPhoneNumber);
    return WillPopScope(
      onWillPop: () async {
        navKey.currentState
            ?.pushNamedAndRemoveUntil("/application_scr", (routes) => false);
        return false;
      },
      child: Scaffold(
        appBar: buildAppBarWithoutActionAndLeading(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.h,
              ),
              (vendorProfile == null)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 15.w,
                        ),
                        circularProfileImage(
                            radius: 50.h, imagePath: profileUrl),
                        SizedBox(
                          width: 15.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            textcustomnormal(
                              text: name,
                              fontWeight: FontWeight.w600,
                              fontfamily: "Poppins",
                              color: Colors.black,
                              fontSize: 22,
                            ),
                            textcustomnormal(
                              text: "+91 $phoneNumber",
                              fontWeight: FontWeight.w400,
                              fontfamily: "Poppins",
                              color: const Color(0xff6E6F79),
                              fontSize: 16,
                            ),
                            SizedBox(
                              width: 240.w,
                              child: Text(email,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Color(0xff6E6F79),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      fontFamily: "Inter")),
                            ),
                          ],
                        )
                      ],
                    ),
              SizedBox(
                height: 30.h,
              ),
              dashLine(width: 200.w, height: 1.h, color: Colors.grey.shade300),
              SizedBox(
                height: 15.h,
              ),
              documentsButtons(
                  buttonText: "Profile",
                  buttonIcon: Icons.perm_identity_outlined,
                  anyWayDoor: () {
                    navKey.currentState?.pushNamed("/accounts_scr");
                  }),
              SizedBox(
                height: 15.h,
              ),
              documentsButtons(
                  buttonText: "Terms and Conditions",
                  buttonIcon: Icons.rule_sharp,
                  anyWayDoor: () {
                    navKey.currentState?.pushNamed("/terms_scr");
                  }),
              SizedBox(
                height: 15.h,
              ),
              documentsButtons(
                  buttonText: "Help & Support",
                  buttonIcon: Icons.help_outline,
                  anyWayDoor: () {
                    navKey.currentState?.pushNamed("/help_scr");
                  }),
              SizedBox(
                height: 15.h,
              ),
              documentsButtons(
                  buttonText: "Sign Out",
                  buttonIcon: Icons.logout,
                  anyWayDoor: () {
                    Global.storageServices
                        .setBool(AppConstants.userLoggedInEarlier, false);
                    Global.storageServices
                        .setBool(AppConstants.userRegisteredEarlier, false);
                    Global.storageServices
                        .setBool(AppConstants.vendorVerified, false);
                    Global.storageServices
                        .setBool(AppConstants.vendorRegisteredEarlier, false);
                    Global.storageServices.setBool(AppConstants.kycDone, false);

                    Global.storageServices
                        .setBool(AppConstants.locationGranted, false);
                    Global.storageServices
                        .setBool(AppConstants.isImageDone, false);
                    Global.storageServices
                        .setBool(AppConstants.isDocumentDone, false);
                    Global.storageServices
                        .setBool(AppConstants.isVendorNumberSet, false);
                    navKey.currentState?.pushNamedAndRemoveUntil(
                        "/welcome_back_scr", (route) => false);
                  }),
              SizedBox(
                height: 40.h,
              ),
              Center(
                child: Text("© DAGS Technology V1.0.0"),
              ),
              SizedBox(
                height: 50.h,
              ),
              GestureDetector(
                onTap: () {
                  navKey.currentState?.pushNamedAndRemoveUntil(
                      "/application_scr", (route) => false);
                },
                child: Container(
                    height: 60.h,
                    width: 60.w,
                    alignment: Alignment.center,
                    decoration: appBoxDecoration(
                        radius: 20.h,
                        color: AppColors.documentButtonBg,
                        borderColor: AppColors.primaryElement),
                    child: Image.asset(ImageRes.crossIcon)),
              ),
              SizedBox(
                height: 60.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
