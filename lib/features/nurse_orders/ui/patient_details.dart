import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/core/helpers/spacing.dart';
import 'package:medical_app/core/theming/styles.dart';

class PatientDetailsScreen extends StatelessWidget {
  const PatientDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 200.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "https://apollohealthlib.blob.core.windows.net/health-library/2021/07/shutterstock_1704731518-2048x1365.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            verticalSpace(10),
            Text(
              "Blood type",
              style: isDarkTheme
                  ? TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                    )
                  : TextStyles.font24BinkBold,
            ),
            verticalSpace(20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Patient location',
                border: OutlineInputBorder(),
              ),
            ),
            verticalSpace(10),
          ],
        ),
      ),
    );
  }
}
