import 'package:flutter/material.dart';
import 'package:medical_app/core/theming/styles.dart';

class TermsAndConditionsText extends StatelessWidget {
  const TermsAndConditionsText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'By logging, you agree to our',
            style: isDarkTheme
                ? TextStyles.font13whiteRegular
                : TextStyles.font13GrayRegular,
          ),
          TextSpan(
            text: ' Terms & Conditions',
            style: isDarkTheme
                ? TextStyles.font14WhiteMediam
                : TextStyles.font13DarkMediam,
          ),
          TextSpan(
            text: ' and',
            style: isDarkTheme
                ? TextStyles.font13whiteRegular
                : TextStyles.font13GrayRegular.copyWith(height: 1.5),
          ),
          TextSpan(
            text: ' Privacy Policy.',
            style: isDarkTheme
                ? TextStyles.font14WhiteMediam
                : TextStyles.font13DarkMediam,
          ),
        ],
      ),
    );
  }
}
