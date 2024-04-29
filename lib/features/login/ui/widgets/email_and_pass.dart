import 'package:flutter/material.dart';
import 'package:medical_app/core/helpers/regex_and_validation.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/core/widgets/general_text_form_feild.dart';

class EmailWithPassword extends StatefulWidget {
  EmailWithPassword({super.key, required this.formKey});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  State<EmailWithPassword> createState() => _EmailWithPasswordState();
}

class _EmailWithPasswordState extends State<EmailWithPassword> {
  // final formKey = GlobalKey<FormState>();
  bool isObsecureText = true;

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
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
            controller: emailController,
          ),
          verticalSpace(18),
          MyTextFormFeild(
            controller: passwordController,
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
    super.dispose();
    passwordController.dispose();
  }
}
