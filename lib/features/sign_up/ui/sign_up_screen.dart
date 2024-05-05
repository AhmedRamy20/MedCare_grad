import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/core/helpers/extensions.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/core/theming/styles.dart';
import 'package:medical_app/core/widgets/med_app_generic_button.dart';
import 'package:medical_app/features/sign_up/logic/cubit/sign_up_cubit.dart';
import 'package:medical_app/features/sign_up/logic/cubit/sign_up_state.dart';
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
        child: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Success")));
            } else if (state is SignUpFailure) {
              // ScaffoldMessenger.of(context)
              //     .showSnackBar(SnackBar(content: Text(state.errorMsg)));
              //* Failure message
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
          },
          builder: (context, state) {
            return Padding(
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
                        state is SignUpLoading
                            ? const CircularProgressIndicator(
                                color: Colors.amber,
                              )
                            : MedAppButton(
                                buttonText: "Sign up",
                                textStyle: TextStyles.font16WhiteSemiBold,
                                onPressed: () {
                                  // validateThenDoSignup(context);
                                  // context.pop();
                                  // context.pushNamed(Routes.loginScreen);

                                  if (context
                                      .read<SignUpCubit>()
                                      .signUpFormKey
                                      .currentState!
                                      .validate()) {
                                    context.read<SignUpCubit>().signUp();
                                  }
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
            );
          },
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
