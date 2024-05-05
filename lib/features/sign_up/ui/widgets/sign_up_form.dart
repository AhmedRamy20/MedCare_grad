import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/core/helpers/regex_and_validation.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/core/theming/styles.dart';
import 'package:medical_app/core/widgets/general_text_form_feild.dart';
import 'package:medical_app/features/login/ui/widgets/password_with_validation.dart';
import 'package:medical_app/features/sign_up/logic/cubit/sign_up_cubit.dart';

class SignUpRegisterationForm extends StatefulWidget {
  const SignUpRegisterationForm({super.key});

  @override
  State<SignUpRegisterationForm> createState() =>
      _SignUpRegisterationFormState();
}

class _SignUpRegisterationFormState extends State<SignUpRegisterationForm> {
  bool isPasswordObscureText = true;
  bool isPasswordConfirmationObscureText = true;
  String? selectedGender;

  bool hasLowercase = false;
  bool hasUppercase = false;
  bool withSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  //**  */

  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    passwordController = context.read<SignUpCubit>().signUpPassword;
    setupPasswordControllerListener();
  }

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
      key: context.read<SignUpCubit>().signUpFormKey,
      child: Column(
        children: [
          MyTextFormFeild(
            hitText: 'Name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid name';
              }
            },
            controller: context.read<SignUpCubit>().signUpName,
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
            controller: context.read<SignUpCubit>().signUpPhoneNumber,
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
            controller: context.read<SignUpCubit>().signUpEmail,
          ),
          verticalSpace(18),
          MyTextFormFeild(
            hitText: 'Birthday',
            keyboardType: TextInputType.number,
            showDatePicker: true,
            controller:
                context.read<SignUpCubit>().signUpbirthday, //! put in cubit
            // width: 143.w,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter Your Birthday";
              }
              return null;
            },
          ),
          verticalSpace(18),
          DropdownButtonFormField<String>(
            value: selectedGender,
            onChanged: (String? newValue) {
              setState(() {
                selectedGender = newValue;
                context.read<SignUpCubit>().genderController.text =
                    newValue ?? '';
              });
            },
            items: <String>['Male', 'Female']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Select Gender',
              hintStyle: TextStyles.font14GrayRegular,
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: ColorsProvider.lGray),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: ColorsProvider.lGray),
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: ColorsProvider.primaryBink,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a gender';
              }
              return null;
            },
          ),
          verticalSpace(18),
          MyTextFormFeild(
            controller: context.read<SignUpCubit>().signUpPassword,
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
            controller: context.read<SignUpCubit>().confirmPassword,
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
