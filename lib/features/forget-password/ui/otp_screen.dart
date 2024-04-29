import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/core/helpers/extensions.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/core/theming/styles.dart';
import 'package:medical_app/core/widgets/med_app_generic_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  late String otpCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   title: Text("Verification", style: TextStyles.font13DarkMediam),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verify your phone number',
                  style: TextStyles.font24BlackBold,
                ),
                verticalSpace(30),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  child: RichText(
                    text: TextSpan(
                      text: 'Enter your 6 digit code numbers sent to ',
                      style: TextStyles.font18BlackRegular,
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'phoneNumber',
                          style: TextStyle(color: ColorsProvider.primaryBink),
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpace(80),
                PinCodeTextField(
                  appContext: context,
                  autoFocus: true,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.scale,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    borderWidth: 1,
                    activeColor: ColorsProvider.primaryBink,
                    inactiveColor: ColorsProvider.gray,
                    inactiveFillColor: Colors.white,
                    activeFillColor: Colors.white,
                    selectedColor: ColorsProvider.primaryBink,
                    selectedFillColor: Colors.white,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.white,
                  enableActiveFill: true,
                  // onCompleted: (submitedCode) {
                  //   otpCode = submitedCode;
                  //   print("Completed");
                  // },
                  onChanged: (value) {
                    print(value);
                  },
                ),
                verticalSpace(60),
                MedAppButton(
                  buttonText: "Send",
                  textStyle: TextStyles.font16WhiteSemiBold,
                  onPressed: () {},
                ),
                verticalSpace(36),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Don’t have an account?",
                    style: TextStyles.font14GreyMediam,
                  ),
                ),
                verticalSpace(12),
                MedAppButton(
                  buttonText: "Sign Up",
                  textStyle: TextStyles.font10GrayRegular,
                  backgroundColor: ColorsProvider.feildWhite,
                  borderColor: ColorsProvider.gray,
                  onPressed: () {
                    context.pushReplacementNamed(Routes.signUpScreen);
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
