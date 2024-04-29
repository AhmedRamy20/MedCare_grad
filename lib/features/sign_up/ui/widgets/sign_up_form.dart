import 'package:flutter/material.dart';
import 'package:medical_app/core/helpers/regex_and_validation.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/core/widgets/general_text_form_feild.dart';
import 'package:medical_app/features/login/ui/widgets/password_with_validation.dart';

class SignUpRegisterationForm extends StatefulWidget {
  const SignUpRegisterationForm({super.key});

  @override
  State<SignUpRegisterationForm> createState() =>
      _SignUpRegisterationFormState();
}

class _SignUpRegisterationFormState extends State<SignUpRegisterationForm> {
  bool isPasswordObscureText = true;
  bool isPasswordConfirmationObscureText = true;

  bool hasLowercase = false;
  bool hasUppercase = false;
  bool withSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  late TextEditingController passwordController;

  // @override
  // void initState() {
  //   super.initState();
  //   passwordController = context.read<SignupCubit>().passwordController;
  //   setupPasswordControllerListener();
  // }

  void setupPasswordControllerListener() {
    passwordController.addListener(() {
      setState(() {
        withSpecialCharacters =
            TheRegex.hasSpecialCharacter(passwordController.text);
        hasNumber = TheRegex.hasNumber(passwordController.text);
        hasMinLength = TheRegex.hasMinLength(passwordController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      // key: ,
      child: Column(
        children: [
          MyTextFormFeild(
            hitText: 'Name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid name';
              }
            },
            // controller: context.read<SignupCubit>().nameController,
          ),
          verticalSpace(18),
          MyTextFormFeild(
            hitText: 'Phone number',
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !TheRegex.isPhoneNumberValid(value)) {
                return 'Please enter a valid phone number';
              }
            },
            // controller: context.read<SignupCubit>().phoneController,
          ),
          verticalSpace(18),
          MyTextFormFeild(
            hitText: 'Email',
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !TheRegex.isEmailValid(value)) {
                return 'Please enter a valid email';
              }
            },
            // controller: context.read<SignupCubit>().emailController,
          ),
          verticalSpace(18),
          MyTextFormFeild(
            // controller: context.read<SignupCubit>().passwordController,
            hitText: 'Password',
            isObsecureText: isPasswordObscureText,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isPasswordObscureText = !isPasswordObscureText;
                });
              },
              child: Icon(
                isPasswordObscureText ? Icons.visibility_off : Icons.visibility,
                color: ColorsProvider.primaryBink,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid password';
              }
            },
          ),
          verticalSpace(18),
          MyTextFormFeild(
            // controller:
            //     context.read<SignupCubit>().passwordConfirmationController,
            hitText: 'Password Confirmation',
            isObsecureText: isPasswordConfirmationObscureText,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isPasswordConfirmationObscureText =
                      !isPasswordConfirmationObscureText;
                });
              },
              child: Icon(
                isPasswordConfirmationObscureText
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: ColorsProvider.primaryBink,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid password';
              }
            },
          ),
          verticalSpace(24),
          PasswordWithValidation(
            withSpecialCharacters: withSpecialCharacters,
            hasNumber: hasNumber,
            hasMinLength: hasMinLength,
          ),
        ],
      ),
    );
  }

  // @override
  // void dispose() {
  //   passwordController.dispose();
  //   super.dispose();
  // }
}
