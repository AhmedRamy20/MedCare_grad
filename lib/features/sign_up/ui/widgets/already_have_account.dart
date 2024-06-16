import 'package:flutter/material.dart';
import 'package:medical_app/core/helpers/extensions.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/styles.dart';

class AlreadyHaveAccountText extends StatelessWidget {
  const AlreadyHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: isDarkTheme
              ? TextStyles.font13whiteMediam
              : TextStyles.font13DarkMediam,
        ),
        GestureDetector(
          onTap: () {
            context.pushReplacementNamed(Routes.loginScreen);
          },
          child: Text(
            " Sign in",
            style: isDarkTheme
                ? TextStyles.font13BinkSemiBold
                : TextStyles.font13BinkSemiBold,
          ),
        )
      ],
    );
  }
}
