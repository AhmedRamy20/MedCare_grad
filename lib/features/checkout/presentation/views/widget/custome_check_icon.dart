import 'package:flutter/material.dart';
import 'package:medical_app/core/theming/colors.dart';

class CustomCheckIcon extends StatelessWidget {
  const CustomCheckIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 50,
      backgroundColor: Color(0xFFD9D9D9),
      child: CircleAvatar(
        radius: 40,
        backgroundColor: ColorsProvider.primaryBink, //Color(0xff34A853)
        child: Icon(
          Icons.check,
          size: 50,
        ),
      ),
    );
  }
}
