import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/core/theming/styles.dart';

class LogoName extends StatelessWidget {
  const LogoName({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/logo30.png'),
        SizedBox(width: 10.w),
        Text(
          "HealthCare",
          style: TextStyles.font24BinkBold,
        )
      ],
    );
  }
}
