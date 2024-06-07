// This will be the client app

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/core/routing/app_router.dart';
import 'package:medical_app/core/routing/routes.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/features/checkout/presentation/views/widget/cart_view_body.dart';
import 'package:medical_app/core/theming/appTheme/cubit/app_theme_cubit.dart';
import 'package:medical_app/core/theming/appTheme/cubit/app_theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedcareApp extends StatelessWidget {
  const MedcareApp({super.key, required this.appRouter});
  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: BlocBuilder<AppThemeCubit, AppThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'MedCare',
            theme: themeState.themeData,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: appRouter.generateRoute,
            initialRoute: Routes.splashScreen,
          );
        },
      ),
    );
  }
}






// MaterialApp(
//         title: 'MedCare',
//         theme: ThemeData(
//           primaryColor: ColorsProvider.primaryBink,
//           scaffoldBackgroundColor: Colors.white,
//         ),
//         debugShowCheckedModeBanner: false,
//         onGenerateRoute: appRouter.generateRoute,
//         initialRoute: Routes.splashScreen,
//         // initialRoute: Routes.homeStartWithBottomNav,
//         // home: MyCartViewBody(),
//       ),