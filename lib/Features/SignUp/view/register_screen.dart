import 'package:dags/Common/widgets/text_widgets.dart';
import 'package:dags/Features/SignUp/view/widgets/register_screen_widgets.dart';
import 'package:dags/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Common/utils/app_colors.dart';
import '../../../Common/utils/user_model.dart';
import '../../../Common/widgets/app_button_widgets.dart';
import '../../../Common/widgets/app_shadow.dart';
import '../../../Common/widgets/app_text_fields.dart';
import '../Controller/register_controller.dart';
import '../provider/registernotifier.dart';

class Register extends ConsumerStatefulWidget {
  const Register({super.key});

  @override
  ConsumerState<Register> createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  late RegisterController controller;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller = RegisterController(ref: ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var number = ref.watch(registrationNotifierProvider).phoneNumber;
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
                              registerText(),
                              SizedBox(
                                height: 3.h,
                              ),
                              registerText02(),
                              SizedBox(
                                height: 30.h,
                              ),
                              Form(
                                key: formKey,
                                child: textLoginBoxWithDimensions(
                                    hintText: "Phone No.",
                                    height: 50.h,
                                    width: 325.w,
                                    prefix: "+91 ",
                                    maxLength: 10,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      RegExp re = RegExp(r"^\d{10}$");
                                      if (!re.hasMatch(value!)) {
                                        return 'Please enter correct phone number.';
                                      }
                                      return null;
                                    },
                                    validateMode:
                                        AutovalidateMode.onUserInteraction,
                                    func: (value) {
                                      ref
                                          .read(registrationNotifierProvider
                                              .notifier)
                                          .onPhoneNumberChange(value);
                                    }),
                              ),
                              SizedBox(
                                height: 270.h,
                              ),
                              Container(
                                  margin:
                                      EdgeInsets.only(left: 29.w, right: 25.w),
                                  child: appButtons(
                                      buttonText: 'Next',
                                      buttonColor: AppColors.primaryElement,
                                      buttonTextColor: AppColors.primaryText,
                                      buttonBorderWidth: 2.h,
                                      anyWayDoor: () {
                                        if (formKey.currentState!.validate()) {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          controller.handleSignUp(controller);
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                      })),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    textcustomnormal(
                                      text:
                                          "By clicking on Next you are agreeing to our",
                                      align: TextAlign.center,
                                      fontSize: 14,
                                      fontfamily: "Inter",
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade500,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        navKey.currentState
                                            ?.pushNamed('/terms_scr');
                                      },
                                      child: textcustomnormal(
                                        text: "Terms and conditions.",
                                        align: TextAlign.center,
                                        fontSize: 14,
                                        fontfamily: "Inter",
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              registerText03()
                            ],
                          ),
                        ),
                      ))));
  }
}
