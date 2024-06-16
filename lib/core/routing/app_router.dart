// ignore_for_file: constant_pattern_never_matches_value_type

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/core/networking/dio_consumer.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/features/bottom_navigation-bar/ui/bottom_navigation_bar.dart';
import 'package:medical_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:medical_app/features/cart/ui/cart_screen.dart';
import 'package:medical_app/features/chatbot/ui/chatbot_screen.dart';
import 'package:medical_app/features/checkout/presentation/views/widget/cart_view_body.dart';
import 'package:medical_app/features/forget-password/ui/foget_password_screen.dart';
import 'package:medical_app/features/forget-password/ui/otp_screen.dart';
import 'package:medical_app/features/home/data/medicine_model.dart';
import 'package:medical_app/features/home/logic/cubit/medicine_cubit.dart';
import 'package:medical_app/features/home/ui/home_screen.dart';
import 'package:medical_app/features/home/ui/medicine_details_screen.dart';
import 'package:medical_app/features/lab-test/logic/cubit/lab_test_cubit.dart';
import 'package:medical_app/features/lab-test/ui/lab_test_screen.dart';
import 'package:medical_app/features/login/logic/cubit/login_cubit.dart';
import 'package:medical_app/features/login/ui/login_screen.dart';
import 'package:medical_app/features/onboarding/onboarding_screens.dart';
import 'package:medical_app/features/profile/logic/cubit/profile_cubit.dart';
import 'package:medical_app/features/profile/ui/profile_screen.dart';
import 'package:medical_app/features/sign_up/logic/cubit/sign_up_cubit.dart';
import 'package:medical_app/features/sign_up/ui/sign_up_screen.dart';
import 'package:medical_app/features/splashcheckonboarding/splash_screen.dart';
import 'package:medical_app/features/verify_email/logic/cubit/verify_email_cubit.dart';
import 'package:medical_app/features/verify_email/ui/email_verification_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
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
            create: (context) => LoginCubit(), //DioConsumer(dio: Dio())
            child: const LoginScreen(),
          ),
        );

      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SignUpCubit>(
            create: (context) => SignUpCubit(DioConsumer(dio: Dio())),
            child: const SignupScreen(),
          ),
        );

      case Routes.forgetPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => ForgetPassword(),
        );
      //********** Splash check */
      // case Routes.splashScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //         create: (context) => LoginCubit()..checkLoginStatus(),
      //         child: SplashScreen()),
      //   );
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<LoginCubit>(
                create: (context) => LoginCubit()..checkLoginStatus(),
              ),
              BlocProvider<MedicineCubit>(
                create: (context) => MedicineCubit(),
              ),
            ],
            child: SplashScreen(),
          ),
        );
      case Routes.emailVerification:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<VerifyEmailCubit>(
            create: (context) => VerifyEmailCubit(), //! DioConsumer(dio: Dio())
            child: const EmailVerificationScreen(),
          ),
        );
      case Routes.otpScreen:
        return MaterialPageRoute(
          builder: (_) => OtpScreen(),
        );
      //! old payment
      // case Routes.paymentCheckout:
      //   return MaterialPageRoute(
      //     builder: (_) => MyCartViewBody(),
      //   );
      case Routes.paymentCheckout:
        if (arguments != null &&
            arguments is Map &&
            arguments.containsKey('totalPrice')) {
          double totalPrice = arguments['totalPrice'];
          return MaterialPageRoute(
            builder: (_) => MyCartViewBody(totalPrice: totalPrice),
          );
        }
        return MaterialPageRoute(
          builder: (_) => MyCartViewBody(
              totalPrice: 0.0), // Default to 0.0 if totalPrice is not provided
        );
      //! New maps phase
      // case Routes.profile:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider<ProfileCubit>(
      //         create: (context) => ProfileCubit(), child: Profile()),
      //   );
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
          builder: (_) => HomeScreen(),
        );
      //! MedicineDetailsScreen
      case Routes.medicineDetailsScreen:
        if (arguments != null && arguments is Medicine) {
          return MaterialPageRoute(
            builder: (_) => MedicineDetailsScreen(medicine: arguments),
          );
        }
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("No medicine data provided for ${settings.name}"),
            ),
          ),
        );
      //! has been modified down
      case Routes.homeStartWithBottomNav:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<LoginCubit>(
                create: (context) => LoginCubit(),
              ),
              BlocProvider<MedicineCubit>(
                create: (context) => MedicineCubit(),
              ),
              BlocProvider<LabTestCubit>(
                create: (context) => LabTestCubit(Dio()),
              ),
            ],
            // create: (context) => MedicineCubit(),
            child: const HomeStartWithBottomNav(),
          ),
        );

      //* Chatbot Screen
      case Routes.chatbotScreen:
        return MaterialPageRoute(
          builder: (_) => const ChatbotScreen(),
        );
      case Routes.cart:
        return MaterialPageRoute(
          builder: (_) => const CartScreen(),
        );
      // case Routes.labTest:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider<LabTestCubit>(
      //       create: (context) => LabTestCubit(Dio()),
      //       child: LabTest(),
      //     ),
      //   );
      // default:
      //   return MaterialPageRoute(
      //     builder: (_) => Scaffold(
      //       body: Center(
      //         child: Text("No route defined for ${settings.name}"),
      //       ),
      //     ),
      //   );
    }
  }
}
