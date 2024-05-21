import 'package:flutter/material.dart';
import 'package:medical_app/features/checkout/presentation/views/widget/payment_method_item.dart';

class PaymentMethodsListView extends StatefulWidget {
  PaymentMethodsListView({super.key});

  @override
  State<PaymentMethodsListView> createState() => _PaymentMethodsListViewState();
}

class _PaymentMethodsListViewState extends State<PaymentMethodsListView> {
  final List paymentMethodsItem = [
    'assets/images/card.svg',
    // 'assets/images/paypal.svg',
  ];

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: paymentMethodsItem.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  activeIndex = index;
                });
              },
              child: PaymentMethodItem(
                image: paymentMethodsItem[index],
                isActive: activeIndex == index,
              ),
            ),
          );
        },
      ),
    );
  }
}
