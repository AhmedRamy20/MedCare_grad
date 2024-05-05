import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/theming/styles.dart';
import 'package:medical_app/core/widgets/general_text_form_feild.dart';
import 'package:medical_app/core/widgets/med_app_generic_button.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 130.h, left: 17.w, right: 17.w),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Email Verification",
                style: TextStyles.font18BlackRegular,
              ),
              // Text(
              //     "Take your time verifing your Email, Don't exit without verifing the Email "),

              verticalSpace(6),
              Center(
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 14.sp),
                    children: [
                      TextSpan(
                        text: "Take your time verifying your Email, ",
                        style: TextStyles.font14GrayRegular,
                      ),
                      TextSpan(
                        text: "Don't",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 17.sp,
                        ),
                      ),
                      TextSpan(
                        text: " exit without verifying the Email...",
                        style: TextStyles.font14GrayRegular,
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpace(50),
              MyTextFormFeild(
                hitText: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid Email';
                  }
                },
              ),
              verticalSpace(15),
              MyTextFormFeild(
                hitText: 'Enter verification code',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid code';
                  }
                },
              ),

              // verticalSpace(20),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: MedAppButton(
                  buttonText: 'Send',
                  textStyle: TextStyles.font16WhiteSemiBold,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
