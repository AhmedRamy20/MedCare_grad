import 'package:flutter/material.dart';
import 'package:medical_app/core/widgets/custome_app_bar.dart';
import 'package:medical_app/features/checkout/presentation/views/widget/payment_details_view_body.dart';

class PaymentDetailsView extends StatelessWidget {
  const PaymentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, title: 'Payment Details'),
        body: PaymentDetailsViewBody());
  }
}
