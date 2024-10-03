import 'package:dags/Features/SignIn/view/widgets/wb_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Common/utils/app_colors.dart';
import '../../../Common/widgets/app_button_widgets.dart';
import '../../../Common/widgets/app_text_fields.dart';
import '../../SignUp/view/widgets/register_screen_widgets.dart';
import '../Controller/login_controller.dart';
import '../Provider/welcome_back_notifier.dart';

class WelcomeBackScreen extends ConsumerStatefulWidget {
  const WelcomeBackScreen({super.key});

  @override
  ConsumerState<WelcomeBackScreen> createState() => _WelcomeBackScreenState();
}

class _WelcomeBackScreenState extends ConsumerState<WelcomeBackScreen> {
  late LoginController controller;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller = LoginController();
    super.initState();
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
                                welcomeBackText(),
                                SizedBox(
                                  height: 3.h,
                                ),
                                welcomeBackText02(),
                                SizedBox(
                                  height: 30.h,
                                ),
                                textLoginBoxWithDimensions(
                                    hintText: "Phone No.",
                                    height: 50.h,
                                    width: 325.w,
                                    keyboardType: TextInputType.number,
                                    prefix: "+91 ",
                                    maxLength: 10,
                                    validateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      RegExp re = RegExp(r"^\d{10}$");
                                      if (!re.hasMatch(value!)) {
                                        return 'Please enter correct phone number.';
                                      }
                                      return null;
                                    },
                                    func: (value) {
                                      ref
                                          .read(
                                              welcomeNotifierProvider.notifier)
                                          .onPhoneNumberChange(value);
                                    }),
                                SizedBox(
                                  height: 310.h,
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
                                            controller.handleSignIn(ref);
                                            setState(() {
                                              isLoading = false;
                                            });
                                          }
                                        })),
                                SizedBox(
                                  height: 5.h,
                                ),
                                welcomeBackText03()
                              ],
                            ),
                          ),
                        ),
                      ))));
  }
}
