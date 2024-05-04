// ignore_for_file: constant_pattern_never_matches_value_type

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/core/networking/dio_consumer.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/features/bottom_navigation-bar/ui/bottom_navigation_bar.dart';
import 'package:medical_app/features/chatbot/ui/chatbot_screen.dart';
import 'package:medical_app/features/forget-password/ui/foget_password_screen.dart';
import 'package:medical_app/features/forget-password/ui/otp_screen.dart';
import 'package:medical_app/features/home/ui/home_screen.dart';
import 'package:medical_app/features/login/logic/cubit/login_cubit.dart';
import 'package:medical_app/features/login/ui/login_screen.dart';
import 'package:medical_app/features/onboarding/onboarding_screens.dart';
import 'package:medical_app/features/sign_up/ui/sign_up_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const AllOnboardingScreens(),
        );
      //! Just been modified with bloc
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(DioConsumer(dio: Dio())),
            child: const LoginScreen(),
          ),
        );

      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => const SignupScreen(),
        );

      case Routes.forgetPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => ForgetPassword(),
        );
      case Routes.otpScreen:
        return MaterialPageRoute(
          builder: (_) => OtpScreen(),
        );
      //! old v
      // case Routes.homeScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => LoginCubit(DioConsumer(dio: Dio())),
      //       child: const HomeScreen(),
      //     ),
      //   );
      //! new v
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      //! has been modified down
      case Routes.homeStartWithBottomNav:
        return MaterialPageRoute(
          builder: (_) => const HomeStartWithBottomNav(),
        );

      //* Chatbot Screen
      case Routes.chatbotScreen:
        return MaterialPageRoute(
          builder: (_) => const ChatbotScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("No route defined for ${settings.name}"),
            ),
          ),
        );
    }
  }
}
