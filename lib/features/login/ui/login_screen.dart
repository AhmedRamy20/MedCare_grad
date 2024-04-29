import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/core/helpers/extensions.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/core/theming/styles.dart';
import 'package:medical_app/core/widgets/external_google_button.dart';
import 'package:medical_app/core/widgets/med_app_generic_button.dart';
import 'package:medical_app/features/login/ui/widgets/email_and_pass.dart';
import 'package:medical_app/features/login/ui/widgets/has_account.dart';
import 'package:medical_app/features/login/ui/widgets/terms_conditions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  // bool isObsecureText = true;
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
                Text(
                  "Welcome Back",
                  style: TextStyles.font24BinkBold,
                ),
                verticalSpace(8),
                Text(
                  // 'Med App excited to have you back, can\'t wait to see what you\'ve been up to since you last logged in.',
                  'How long have you turned your back on us? Just Kidding :)',
                  style: TextStyles.font15GrayRegular,
                ),
                verticalSpace(27), //! was like 36
                Column(
                  children: [
                    EmailWithPassword(formKey: formKey),
                    verticalSpace(24),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: InkWell(
                        onTap: () {
                          context.pushNamed(Routes.forgetPasswordScreen);
                        },
                        child: Text(
                          "Forgot Password",
                          style: TextStyles.font13BinkRegular,
                        ),
                      ),
                    ),
                    verticalSpace(40),
                    MedAppButton(
                      buttonText: "Login",
                      textStyle: TextStyles.font16WhiteSemiBold,
                      onPressed: () {
                        // context.pushReplacementNamed(
                        //     Routes.homeStartWithBottomNav);
                        if (formKey.currentState!.validate()) {
                          context.pushReplacementNamed(
                              Routes.homeStartWithBottomNav);
                        }
                      },
                    ),
                    verticalSpace(36),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: ColorsProvider.veryLightGray,
                            thickness: 1,
                          ),
                        ),
                        horizontalSpace(3),
                        Text(
                          "Or sign in with",
                          style: TextStyles.font12signLightGrayRegular,
                        ),
                        horizontalSpace(3),
                        const Expanded(
                          child: Divider(
                            color: ColorsProvider.veryLightGray,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(30), //! was 32
                    GoogleButton(
                      imagePath: "assets/images/google.png",
                      onPressed: () {},
                    ),
                    verticalSpace(20), //! was 60
                    const TermsAndConditionsText(),
                    verticalSpace(20),
                    const DontHaveAccountText(),
                    // const LoginBlocWithListener(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
