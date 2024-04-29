import 'package:flutter/material.dart';
import 'package:medical_app/core/helpers/extensions.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/styles.dart';

class AlreadyHaveAccountText extends StatelessWidget {
  const AlreadyHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: TextStyles.font13DarkMediam,
        ),
        GestureDetector(
          onTap: () {
            context.pushReplacementNamed(Routes.loginScreen);
          },
          child: Text(
            " Sign in",
            style: TextStyles.font13BinkSemiBold,
          ),
        )
      ],
    );
  }
}
