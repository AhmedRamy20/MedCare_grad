import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:medical_app/core/networking/endpoints.dart';
import 'package:medical_app/core/routing/app_router.dart';
import 'package:medical_app/medcare_app.dart';
import 'package:medical_app/core/theming/appTheme/cubit/app_theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/core/cache/cache_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ChacheHelper().init();
  Stripe.publishableKey = ApiKey.puplishableKey;
  runApp(
    BlocProvider<AppThemeCubit>(
      create: (context) => AppThemeCubit(),
      child: MedcareApp(
        appRouter: AppRouter(),
      ),
    ),
  );
}
