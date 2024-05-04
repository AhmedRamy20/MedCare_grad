import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/core/helpers/regex_and_validation.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/core/widgets/general_text_form_feild.dart';
import 'package:medical_app/features/login/logic/cubit/login_cubit.dart';

class EmailWithPassword extends StatefulWidget {
  EmailWithPassword({super.key});

  @override
  State<EmailWithPassword> createState() => _EmailWithPasswordState();
}

class _EmailWithPasswordState extends State<EmailWithPassword> {
  bool isObsecureText = true;

  late TextEditingController _passwordController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _passwordController = context.read<LoginCubit>().signInPassword;
    _emailController = context.read<LoginCubit>().signInEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().signInFormKey,
      child: Column(
        children: [
          MyTextFormFeild(
            hitText: "Email",
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !TheRegex.isEmailValid(value)) {
                return "Please enter a valid email";
              }
            },
            controller: _emailController,
          ),
          verticalSpace(18),
          MyTextFormFeild(
            controller: _passwordController,
            hitText: "Password",
            isObsecureText: isObsecureText,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isObsecureText = !isObsecureText;
                });
              },
              child: Icon(
                isObsecureText ? Icons.visibility_off : Icons.visibility,
                color: ColorsProvider.primaryBink,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid password';
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
