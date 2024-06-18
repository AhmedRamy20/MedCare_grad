import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/features/onboarding/widgets/get_started_button.dart';
import 'package:medical_app/features/onboarding/widgets/logo_and_name.dart';
import 'package:medical_app/features/onboarding/widgets/text_chat_descripe.dart';

class OnBoardingThirdScreen extends StatelessWidget {
  const OnBoardingThirdScreen({super.key});

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
              Image.asset('assets/images/pana60.png'),
              const TextChatDescription(
                fstText: "Online Chatbot",
                secText: "Predicting the disease based on",
                thText: "specific entered symptoms.",
              ),
              // SizedBox(height: 2.h),
              const GestStartedButton(),
            ],
          ),
        ),
      )),
    );
  }
}
