import 'package:flutter/material.dart';
import 'package:medical_app/core/helpers/extensions.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GestStartedButton extends StatelessWidget {
  const GestStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          context.pushNamed(Routes.loginScreen);
        },
        child: Container(
          width: 311.w,
          height: 52.h,
          decoration: BoxDecoration(
            color: ColorsProvider.primaryBink,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Center(
            child: Text(
              'Get Started',
              style: TextStyles.font16WhiteSemiBold,
            ),
          ),
        ),
      ),
    );
  }
}
