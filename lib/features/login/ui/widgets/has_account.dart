import 'package:flutter/material.dart';
import 'package:medical_app/core/helpers/extensions.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/styles.dart';

class DontHaveAccountText extends StatelessWidget {
  const DontHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "don't have an account?",
          style: isDarkTheme
              ? TextStyles.font13whiteMediam
              : TextStyles.font13DarkMediam,
        ),
        GestureDetector(
          onTap: () {
            context.pushNamed(Routes.signUpScreen); //signUpScreen
          },
          child: Text(
            " Sign Up",
            style: isDarkTheme
                ? TextStyles.font13BinkSemiBold
                : TextStyles.font13BinkSemiBold,
          ),
        )
      ],
    );
  }
}
