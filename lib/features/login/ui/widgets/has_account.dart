import 'package:flutter/material.dart';
import 'package:medical_app/core/helpers/extensions.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/styles.dart';

class DontHaveAccountText extends StatelessWidget {
  const DontHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "don't have an account?",
          style: TextStyles.font13DarkMediam,
        ),
        GestureDetector(
          onTap: () {
            context.pushNamed(Routes.signUpScreen);
          },
          child: Text(
            " Sign Up",
            style: TextStyles.font13BinkSemiBold,
          ),
        )
      ],
    );
  }
}