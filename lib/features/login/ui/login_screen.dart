import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/core/helpers/extensions.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/core/theming/styles.dart';
import 'package:medical_app/core/widgets/external_google_button.dart';
import 'package:medical_app/core/widgets/med_app_generic_button.dart';
import 'package:medical_app/features/login/data/model/sign_in_model.dart';
import 'package:medical_app/features/login/logic/cubit/login_cubit.dart';
import 'package:medical_app/features/login/logic/cubit/login_state.dart';
import 'package:medical_app/features/login/ui/widgets/email_and_pass.dart';
import 'package:medical_app/features/login/ui/widgets/has_account.dart';
import 'package:medical_app/features/login/ui/widgets/terms_conditions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late SignInModel signInModel;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (context.mounted) {
              if (state is SignInSuccess) {
                context.pushReplacementNamed(
                  Routes.homeStartWithBottomNav,
                );
              } else if (state is SignInFailure) {
                //* User is registered but the account is not activated
                if (state.errorMsg ==
                    "User is registered but the account is not activated") {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Account Activation Required"),
                      content: const Text(
                        "Would you like to navigate to the verification email screen?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Navigate to the verification email screen
                            Navigator.pop(context);
                            Navigator.pushNamed(
                              context,
                              Routes.emailVerification,
                            );
                          },
                          child: const Text(
                            "Yes",
                            style: TextStyle(
                              color: ColorsProvider.primaryBink,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: const Text(
                            "No",
                            style: TextStyle(
                              color: ColorsProvider.primaryBink,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("OOops.."),
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
                }
              } else {
                const CircularProgressIndicator(
                  color: Color.fromARGB(230, 228, 99, 99),
                );
              }
            }
          },
          builder: (context, state) {
            if (!context.mounted) {
              return const SizedBox.shrink();
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back",
                      style: isDarkTheme
                          ? TextStyles.font24whiteBold2
                          : TextStyles.font24BinkBold,
                    ),
                    verticalSpace(8),
                    Text(
                      // 'Med App excited to have you back, can\'t wait to see what you\'ve been up to since you last logged in.',
                      'How long have you turned your back on us? Just Kidding :)',
                      style: isDarkTheme
                          ? TextStyles.font15whiteRegular
                          : TextStyles.font15GrayRegular,
                    ),
                    verticalSpace(27), //! was like 36
                    Column(
                      children: [
                        EmailWithPassword(),
                        verticalSpace(24),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: InkWell(
                            onTap: () {
                              context.pushNamed(Routes.forgetPasswordScreen);
                            },
                            child: Text(
                              "Forgot Password",
                              style: isDarkTheme
                                  ? TextStyles.font13whiteRegular
                                  : TextStyles.font13BinkRegular,
                            ),
                          ),
                        ),
                        verticalSpace(40),
                        state is SignInLoading
                            ? const CircularProgressIndicator(
                                color: ColorsProvider.primaryBink,
                              )
                            : MedAppButton(
                                buttonText: "Login",
                                textStyle: TextStyles.font16WhiteSemiBold,
                                onPressed: () {
                                  // context.pushReplacementNamed(
                                  //     Routes.homeStartWithBottomNav);

                                  //!!
                                  // if (formKey.currentState!.validate()) {
                                  //   context.read<LoginCubit>().signIn();
                                  // }

                                  if (context
                                      .read<LoginCubit>()
                                      .signInFormKey
                                      .currentState!
                                      .validate()) {
                                    context.read<LoginCubit>().signIn();
                                  }
                                },
                              ),
                        verticalSpace(36),
                        // Row(
                        //   children: [
                        //     const Expanded(
                        //       child: Divider(
                        //         color: ColorsProvider.veryLightGray,
                        //         thickness: 1,
                        //       ),
                        //     ),
                        //     horizontalSpace(3),
                        //     Text(
                        //       "Or sign in with",
                        //       style: isDarkTheme
                        //           ? TextStyles.font12whiteRegular
                        //           : TextStyles.font12signLightGrayRegular,
                        //     ),
                        //     horizontalSpace(3),
                        //     const Expanded(
                        //       child: Divider(
                        //         color: ColorsProvider.veryLightGray,
                        //         thickness: 1,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        //!!
                        verticalSpace(30), //! was 32
                        // GoogleButton(
                        //   imagePath: "assets/images/google.png",
                        //   onPressed: () {},
                        // ),
                        verticalSpace(20), //! was 60
                        const TermsAndConditionsText(),
                        verticalSpace(20),
                        const DontHaveAccountText(),
                      ],
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
