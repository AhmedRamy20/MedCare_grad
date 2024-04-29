import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/core/theming/styles.dart';
import 'package:medical_app/core/helpers/spacing.dart';

class TextChatDescription extends StatelessWidget {
  const TextChatDescription(
      {super.key,
      required this.fstText,
      required this.secText,
      required this.thText});

  final String fstText;
  final String secText;
  final String thText;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 32.h),
        Text(
          // "Online Chatbot.",
          fstText,
          style: TextStyles.font16GreyMediam,
        ),
        verticalSpace(80),
        Text(
          // 'Predicting the disease based on',
          secText,
          style: TextStyles.font14GreyMediam,
        ),
        Text(
          // 'specific entered symptoms.',
          thText,
          style: TextStyles.font14GreyMediam,
        ),
        SizedBox(height: 35.h),
      ],
    );
  }
}
