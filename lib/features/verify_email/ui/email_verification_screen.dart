import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/core/helpers/extensions.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/core/theming/styles.dart';
import 'package:medical_app/core/widgets/general_text_form_feild.dart';
import 'package:medical_app/core/widgets/med_app_generic_button.dart';
import 'package:medical_app/features/verify_email/logic/cubit/verify_email_cubit.dart';
import 'package:medical_app/features/verify_email/logic/cubit/verify_email_state.dart';

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
        child: BlocConsumer<VerifyEmailCubit, VerifyEmailState>(
          listener: (context, state) {
            if (state is VerifyEmailFailure) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text(state.errorMsg),
              //     backgroundColor: const Color.fromARGB(255, 26, 21, 21),
              //   ),
              // );
              //* Message when failure
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    "Email or Code not right..",
                    style: TextStyle(fontSize: 20),
                  ),
                  content: Text(state.errorMsg),
                  actions: [
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text(
                        "Got it",
                        style: TextStyle(
                          color: ColorsProvider.primaryBink,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is VerifyEmailSuccess) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(
              //     content: Text("Success :)"),
              //   ),
              // );
              //* When success
              context.pushReplacementNamed(Routes.loginScreen);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(top: 130.h, left: 17.w, right: 17.w),
              child: Form(
                key: context.read<VerifyEmailCubit>().verifyKey,
                child: Column(
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
                          style:
                              TextStyle(color: Colors.black, fontSize: 14.sp),
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
                      controller: context.read<VerifyEmailCubit>().verifyEmail,
                    ),
                    verticalSpace(15),
                    MyTextFormFeild(
                      hitText: 'Enter verification code',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid code';
                        }
                      },
                      controller:
                          context.read<VerifyEmailCubit>().verificationCode,
                    ),

                    // verticalSpace(20),
                    const Spacer(),
                    state is VerifyEmailLoading
                        ? const CircularProgressIndicator(
                            color: ColorsProvider.primaryBink,
                          )
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: MedAppButton(
                              buttonText: 'Send',
                              textStyle: TextStyles.font16WhiteSemiBold,
                              onPressed: () {
                                if (context
                                    .read<VerifyEmailCubit>()
                                    .verifyKey
                                    .currentState!
                                    .validate()) {
                                  context
                                      .read<VerifyEmailCubit>()
                                      .verifyEmailRequest();
                                }
                              },
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
