import 'package:flutter/material.dart';
import 'package:medical_app/core/widgets/custome_app_bar.dart';
import 'package:medical_app/features/checkout/presentation/views/widget/cart_view_body.dart';

class MyCartView extends StatelessWidget {
  // final double totalPrice;

  const MyCartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'My Cart'),
      body: MyCartViewBody(),
    );
  }
}
