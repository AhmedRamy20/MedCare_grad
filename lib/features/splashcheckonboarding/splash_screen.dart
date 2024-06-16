// import 'package:flutter/material.dart';
// import 'package:medical_app/core/cache/cache_helper.dart';
// import 'package:medical_app/features/home/ui/home_screen.dart';
// import 'package:medical_app/features/login/logic/cubit/login_state.dart';
// import 'package:medical_app/features/login/ui/login_screen.dart';
// import 'package:medical_app/features/onboarding/onboarding_sec_screen.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medical_app/features/login/logic/cubit/login_cubit.dart';

// class SplashScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _navigateFromSplash(context),
//       builder: (context, snapshot) {
//         return Scaffold(
//           body: Center(
//             child: Image.asset('assets/images/splash.png'), // Your splash image
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _navigateFromSplash(BuildContext context) async {
//     await Future.delayed(
//         Duration(seconds: 2)); // Simulate a delay for splash screen

//     if (ChacheHelper().getData(key: 'onboarding_seen')) {
//       context.read<LoginCubit>().checkLoginStatus();
//       Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (_) => AuthCheckScreen()));
//     } else {
//       Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (_) => OnBoardingSecScreen()));
//     }
//   }
// }

// class AuthCheckScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LoginCubit, LoginState>(
//       builder: (context, state) {
//         if (state is SignInSuccess) {
//           return HomeScreen();
//         } else {
//           return LoginScreen();
//         }
//       },
//     );
//   }
// }

////!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/core/cache/cache_helper.dart';
import 'package:medical_app/features/bottom_navigation-bar/ui/bottom_navigation_bar.dart';
import 'package:medical_app/features/home/logic/cubit/medicine_cubit.dart';
import 'package:medical_app/features/home/ui/home_screen.dart';
import 'package:medical_app/features/login/logic/cubit/login_cubit.dart';
import 'package:medical_app/features/login/logic/cubit/login_state.dart';
import 'package:medical_app/features/login/ui/login_screen.dart';
import 'package:medical_app/features/onboarding/onboarding_screens.dart';
import 'package:medical_app/features/onboarding/onboarding_sec_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _navigateFromSplash(context),
      builder: (context, snapshot) {
        return Scaffold(
          body: Center(
            // child: Image.asset('assets/images/splash.png'),
            child: Image.asset('assets/images/splash2.png'),
          ),
        );
      },
    );
  }

  Future<void> _navigateFromSplash(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2)); // a delay for splash screen

    final bool onboardingSeen =
        ChacheHelper().getData(key: 'onboarding_seen') ?? false;

    if (onboardingSeen) {
      context.read<LoginCubit>().checkLoginStatus();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => AuthCheckScreen()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => AllOnboardingScreens()));
    }
  }
}

class AuthCheckScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit()..checkLoginStatus(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state is SignInSuccess) {
            return BlocProvider(
              create: (context) => MedicineCubit(),
              child: HomeStartWithBottomNav(),
            );
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
