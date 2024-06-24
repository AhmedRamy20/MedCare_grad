import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:medical_app/core/widgets/custome_button.dart';
import 'package:medical_app/features/checkout/presentation/views/thank_you_view.dart';
import 'package:medical_app/features/checkout/presentation/views/widget/custome_credit_card.dart';
import 'package:medical_app/features/checkout/presentation/views/widget/payment_method_list_view.dart';

class PaymentDetailsViewBody extends StatefulWidget {
  final double totalPrice;
  const PaymentDetailsViewBody({super.key, required this.totalPrice});

  @override
  State<PaymentDetailsViewBody> createState() => _PaymentDetailsViewBodyState();
}

class _PaymentDetailsViewBodyState extends State<PaymentDetailsViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: PaymentMethodsListView(),
        ),
        SliverToBoxAdapter(
          child: CustomCreditCard(
            autovalidateMode: autovalidateMode,
            formKey: formKey,
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
                child: CustomButton(
                  onTap: () {
                    if (formKey.currentState != null) {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        log('payment');
                      }
                    } else {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ThankYouView(totalPrice: widget.totalPrice);
                      }));
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                    //!!!!!
                    // if (formKey.currentState!.validate()) {
                    //   formKey.currentState!.save();
                    //   log('payment');
                    // } else {
                    //   Navigator.of(context)
                    //       .push(MaterialPageRoute(builder: (context) {
                    //     return const ThankYouView();
                    //   }));
                    //   autovalidateMode = AutovalidateMode.always;
                    //   setState(() {});
                    // }

                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (context) {
                    //   return const ThankYouView();
                    // }));
                  },
                  text: 'Payment',
                ),
              )),
        ),
      ],
    );
  }
}
