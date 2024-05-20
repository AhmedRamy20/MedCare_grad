import 'package:flutter/material.dart';
import 'package:medical_app/core/routing/app_router.dart';
import 'package:medical_app/medcare_app.dart';

import 'package:medical_app/core/cache/cache_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ChacheHelper().init();
  runApp(
    MedcareApp(
      appRouter: AppRouter(),  
    ),
  );
}
