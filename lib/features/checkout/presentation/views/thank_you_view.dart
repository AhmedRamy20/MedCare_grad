import 'package:flutter/material.dart';
import 'package:medical_app/core/widgets/custome_app_bar.dart';
import 'package:medical_app/features/checkout/presentation/views/widget/thank_you_view_body.dart';

class ThankYouView extends StatelessWidget {
  final double totalPrice;
  const ThankYouView({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Transform.translate(
          offset: const Offset(0, -16),
          child: ThankYouViewBody(
            totalPrice: totalPrice,
          )),
    );
  }
}
