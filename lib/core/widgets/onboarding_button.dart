import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/core/cache/cache_helper.dart';
import 'package:medical_app/core/helpers/extensions.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/core/theming/styles.dart';

class SkipButton extends StatelessWidget {
  final PageController controller;

  const SkipButton({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // if (controller.page != 2) {
        //   controller.jumpToPage(2);
        // }
        ChacheHelper().saveData(key: 'onboarding_seen', value: true);
        context.pushReplacementNamed(Routes.loginScreen);
      },
      child: Container(
        width: 75.0.w,
        height: 41.0.h,
        decoration: BoxDecoration(
          color: ColorsProvider.primaryBink,
          borderRadius: BorderRadius.circular(23.0),
        ),
        child: Center(
          child: Text(
            'Skip',
            style: TextStyles.font14WhiteMediam,
          ),
        ),
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  final PageController controller;
  final Function onTap;

  const NextButton({Key? key, required this.controller, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (controller.page != 2) {
          onTap();
        }
      },
      child: Container(
        width: 75.0.w,
        height: 41.0.h,
        decoration: BoxDecoration(
          color: ColorsProvider.primaryBink,
          borderRadius: BorderRadius.circular(23.0),
        ),
        child: Center(
          child: Text(
            'Next',
            style: TextStyles.font14WhiteMediam,
          ),
        ),
      ),
    );
  }
}

//! another type of button if  you want to use it in the middle of page
class DoneButton extends StatelessWidget {
  final PageController controller;

  const DoneButton({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (controller.page != 2) {
          controller.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        }
      },
      child: Container(
        width: 75.0.w,
        height: 41.0.h,
        decoration: BoxDecoration(
          color: ColorsProvider.primaryBink,
          borderRadius: BorderRadius.circular(23.0),
        ),
        child: Center(
          child: Text(
            'Done',
            style: TextStyles.font14WhiteMediam,
          ),
        ),
      ),
    );
  }
}
