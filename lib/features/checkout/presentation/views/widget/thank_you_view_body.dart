import 'package:flutter/material.dart';
import 'package:medical_app/features/checkout/presentation/views/widget/custome_check_icon.dart';
import 'package:medical_app/features/checkout/presentation/views/widget/custome_dashed_line.dart';
import 'package:medical_app/features/checkout/presentation/views/widget/thank_you_card.dart';

class ThankYouViewBody extends StatelessWidget {
  final double totalPrice;
  const ThankYouViewBody({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ThankYouCard(totalPrice: totalPrice),
          Positioned(
            bottom: MediaQuery.sizeOf(context).height * .2 + 20,
            left: 20 + 8,
            right: 20 + 8,
            child: const CustomDashedLine(),
          ),
          Positioned(
              left: -20,
              bottom: MediaQuery.sizeOf(context).height * .2,
              child: const CircleAvatar(
                backgroundColor: Colors.white,
              )),
          Positioned(
              right: -20,
              bottom: MediaQuery.sizeOf(context).height * .2,
              child: const CircleAvatar(
                backgroundColor: Colors.white,
              )),
          const Positioned(
            top: -50,
            left: 0,
            right: 0,
            child: CustomCheckIcon(),
          ),
        ],
      ),
    );
  }
}
