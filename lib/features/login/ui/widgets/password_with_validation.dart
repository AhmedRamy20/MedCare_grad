//! This code was for making some text for the password did not use this file for now..
import 'package:flutter/material.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/core/theming/styles.dart';

class PasswordWithValidation extends StatelessWidget {
  const PasswordWithValidation({
    super.key,
    required this.withSpecialCharacters,
    required this.hasNumber,
    required this.hasMinLength,
  });

  final bool withSpecialCharacters;
  final bool hasNumber;
  final bool hasMinLength;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        validationText('At least 1 number', hasNumber),
        verticalSpace(2),
        validationText('At least 1 special character', withSpecialCharacters),
        verticalSpace(2),
        validationText('At least 6 characters long', hasMinLength),
      ],
    );
  }
}

Widget validationText(String text, bool hasValidated) {
  return Row(
    children: [
      const CircleAvatar(
        radius: 2.5,
        backgroundColor: ColorsProvider.gray,
      ),
      horizontalSpace(6),
      Text(
        text,
        style: TextStyles.font13BinkRegular.copyWith(
          decoration: hasValidated ? TextDecoration.lineThrough : null,
          decorationColor: ColorsProvider.primaryBink,
          decorationThickness: 2,
          color: hasValidated ? ColorsProvider.gray : ColorsProvider.darkGray,
        ),
      )
    ],
  );
}
