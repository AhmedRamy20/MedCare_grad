import 'package:flutter/material.dart';
import 'package:medical_app/core/widgets/custome_button.dart';
import 'package:medical_app/features/checkout/presentation/views/widget/custome_button_bloc_consumer.dart';
import 'package:medical_app/features/checkout/presentation/views/widget/payment_method_list_view.dart';

class PaymentMethodsBottomSheet extends StatelessWidget {
  final double totalPrice;
  const PaymentMethodsBottomSheet({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 16,
          ),
          PaymentMethodsListView(),
          const SizedBox(height: 30),
          // CustomButton(text: "Continue"),
          CustomButtonBlocConsumer(totalPrice: totalPrice),
        ],
      ),
    );
  }
}
