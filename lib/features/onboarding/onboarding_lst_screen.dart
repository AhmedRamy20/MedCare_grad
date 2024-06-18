import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/features/onboarding/widgets/logo_and_name.dart';
import 'package:medical_app/features/onboarding/widgets/text_chat_descripe.dart';

class OnBoardingFirstScreen extends StatelessWidget {
  const OnBoardingFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 30.h,
            bottom: 30.h,
          ),
          child: Column(
            children: [
              const LogoName(),
              SizedBox(height: 30.h),
              Image.asset('assets/images/drug_supply.png'),
              const TextChatDescription(
                fstText: "Buying Medicine Online",
                secText: "search about medicine and buy",
                thText: "fast and easy.",
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      )),
    );
  }
}
