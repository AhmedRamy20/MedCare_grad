// This will be the client app

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/core/routing/app_router.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:medical_app/features/checkout/presentation/views/widget/cart_view_body.dart';
import 'package:medical_app/core/theming/appTheme/cubit/app_theme_cubit.dart';
import 'package:medical_app/core/theming/appTheme/cubit/app_theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/core/cache/cache_helper.dart';

// class MedcareApp extends StatelessWidget {
//   const MedcareApp({super.key, required this.appRouter});
//   final AppRouter appRouter;
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(375, 812),
//       minTextAdapt: true,
//       child: BlocBuilder<AppThemeCubit, AppThemeState>(
//         builder: (context, themeState) {
//           return MaterialApp(
//             title: 'MedCare',
//             theme: themeState.themeData,
//             debugShowCheckedModeBanner: false,
//             onGenerateRoute: appRouter.generateRoute,
//             initialRoute: Routes.splashScreen,
//           );
//         },
//       ),
//     );
//   }
// }

//!!!!!!

// class MedcareApp extends StatelessWidget {
//   const MedcareApp(
//       {Key? key, required this.appRouter, required this.cacheHelper})
//       : super(key: key);
//   final AppRouter appRouter;
//   final ChacheHelper cacheHelper;

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(375, 812),
//       minTextAdapt: true,
//       child: BlocBuilder<AppThemeCubit, AppThemeState>(
//         builder: (context, themeState) {
//           return MultiBlocProvider(
//             providers: [
//               BlocProvider<AppThemeCubit>.value(
//                   value: context.read<AppThemeCubit>()),
//               BlocProvider<CartCubit>(
//                 create: (context) =>
//                     CartCubit(), // Initialize your CartCubit here
//               ),
//               // Add other BlocProviders if needed
//             ],
//             child: MaterialApp(
//               title: 'MedCare',
//               theme: themeState.themeData,
//               debugShowCheckedModeBanner: false,
//               onGenerateRoute: appRouter.generateRoute,
//               initialRoute: Routes.splashScreen,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

//! above is the right ///////////

class MedcareApp extends StatelessWidget {
  const MedcareApp(
      {Key? key, required this.appRouter, required this.cacheHelper})
      : super(key: key);
  final AppRouter appRouter;
  final ChacheHelper cacheHelper;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: BlocProvider(
        create: (context) => AppThemeCubit(cacheHelper),
        child: BlocBuilder<AppThemeCubit, AppThemeState>(
          builder: (context, themeState) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<AppThemeCubit>.value(
                    value: context.read<AppThemeCubit>()),
                BlocProvider<CartCubit>(
                  create: (context) =>
                      CartCubit(), // Initialize your CartCubit here
                ),
              ],
              child: MaterialApp(
                title: 'MedCare',
                theme: themeState.themeData,
                debugShowCheckedModeBanner: false,
                onGenerateRoute: appRouter.generateRoute,
                initialRoute: Routes.splashScreen,
              ),
            );
          },
        ),
      ),
    );
  }
}
