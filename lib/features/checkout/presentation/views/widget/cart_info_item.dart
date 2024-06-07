import 'package:flutter/material.dart';
import 'package:medical_app/core/components/styles.dart';

class OrderInfoItem extends StatelessWidget {
  const OrderInfoItem({super.key, required this.title, required this.value});
  final String title, value;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    return Row(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: isDarkTheme
              ? const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                )
              : Styles.style18,
        ),
        const Spacer(),
        Text(
          value,
          textAlign: TextAlign.center,
          style: isDarkTheme
              ? const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                )
              : Styles.style18,
        )
      ],
    );
  }
}
