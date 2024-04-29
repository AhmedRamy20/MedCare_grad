import 'package:flutter/material.dart';
import 'package:medical_app/core/routing/app_router.dart';
import 'package:medical_app/medcare_app.dart';

void main() {
  // setupInjection();
  runApp(
    MedcareApp(
      appRouter: AppRouter(),
    ),
  );
}
