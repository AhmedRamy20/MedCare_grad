import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/core/helpers/extensions.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/styles.dart';
import 'package:medical_app/core/widgets/med_app_generic_button.dart';
import 'package:medical_app/features/sign_up/ui/widgets/already_have_account.dart';
import 'package:medical_app/features/sign_up/ui/widgets/sign_up_form.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  bool isObsecureText = true;
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
                  "Create Account",
                  style: TextStyles.font24BinkBold,
                ),
                verticalSpace(8),
                Text(
                  // 'Sign up now and start exploring all that our app has to offer. We\'re excited to welcome you to our Medcare!.',
                  'With you Signing up . We\'re excited to welcome you to our Healthcare!',
                  style: TextStyles.font15GrayRegular,
                ),
                verticalSpace(30),
                Column(
                  children: [
                    const SignUpRegisterationForm(),
                    verticalSpace(25),
                    MedAppButton(
                      buttonText: "Sign up",
                      textStyle: TextStyles.font16WhiteSemiBold,
                      onPressed: () {
                        context.pop();
                        context.pushNamed(Routes.loginScreen);
                        // validateThenDoSignup(context);
                      },
                    ),
                    verticalSpace(32),

                    // verticalSpace(60),
                    //! const TermsAndConditionsText(),
                    //! verticalSpace(20),
                    const AlreadyHaveAccountText(),
                    // const SignupBlocListener(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void validateThenDoSignup(BuildContext context) {
  //   if (context.read<SignupCubit>().formKey.currentState!.validate()) {
  //     context.read<SignupCubit>().emitSignupStates();
  //   }
  // }
}
