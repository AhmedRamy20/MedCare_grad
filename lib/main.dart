import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:medical_app/core/networking/endpoints.dart';
import 'package:medical_app/core/routing/app_router.dart';
import 'package:medical_app/medcare_app.dart';

import 'package:medical_app/core/cache/cache_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ChacheHelper().init();
  Stripe.publishableKey = ApiKey.puplishableKey;
  runApp(
    MedcareApp(
      appRouter: AppRouter(),  
    ),
  );
}
