import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/core/helpers/extensions.dart';
import 'package:medical_app/core/helpers/regex_and_validation.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/styles.dart';
import 'package:medical_app/core/widgets/general_text_form_feild.dart';
import 'package:medical_app/core/widgets/med_app_generic_button.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(40),
                Image.asset("assets/images/reset-password.png"),
                verticalSpace(63),
                Text(
                  "Forgot Password",
                  style: TextStyles.font24BinkBold,
                ),
                verticalSpace(8),
                Text(
                  "Please enter your signed in Phone ",
                  style: TextStyles.font14GrayRegular,
                ),
                Text(
                  "to reset... :)",
                  style: TextStyles.font14GrayRegular,
                ),
                verticalSpace(32),
                Form(
                  key: formKey,
                  child: MyTextFormFeild(
                    controller: phoneController,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !TheRegex.isPhoneNumberValid(value)) {
                        return "Enter a valid Phone Number";
                      }
                    },
                    hitText: "Enter Phone",
                    keyboardType: TextInputType.phone,
                  ),
                ),
                verticalSpace(60),
                MedAppButton(
                  buttonText: "Reset Password",
                  textStyle: TextStyles.font16WhiteSemiBold,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.pushNamed(Routes.otpScreen);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
