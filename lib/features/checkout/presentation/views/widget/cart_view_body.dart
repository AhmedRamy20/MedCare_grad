import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/core/widgets/custome_button.dart';
import 'package:medical_app/features/checkout/data/repos/check_out_repo_impelementation.dart';
import 'package:medical_app/features/checkout/presentation/manager/cubit/payment_cubit.dart';
import 'package:medical_app/features/checkout/presentation/views/payment_details.dart';
import 'package:medical_app/features/checkout/presentation/views/widget/cart_info_item.dart';
import 'package:medical_app/features/checkout/presentation/views/widget/payment_method_list_view.dart';
import 'package:medical_app/features/checkout/presentation/views/widget/payment_methods_bottom_sheet.dart';
import 'package:medical_app/features/checkout/presentation/views/widget/total_price_widget.dart';

class MyCartViewBody extends StatelessWidget {
  const MyCartViewBody({super.key});

  // final double theTotalPrice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 18,
            ),
            Expanded(child: Image.asset('assets/images/basket_image.png')),
            const SizedBox(
              height: 25,
            ),
            const OrderInfoItem(
              title: 'Order Subtotal',
              value: r'42.97$',
            ),
            const SizedBox(
              height: 3,
            ),
            const OrderInfoItem(
              title: 'Discount',
              value: r'0$',
            ),
            const SizedBox(
              height: 3,
            ),
            const OrderInfoItem(
              title: 'Shipping',
              value: r'8$',
            ),
            const Divider(
              thickness: 2,
              height: 34,
              color: Color(0xffC7C7C7),
            ),
            // const TotalPrice(title: 'Total', value: r'$50.97'),  //!! modified
            TotalPrice(title: 'Total', value: '50.97'),
            //! "$theTotalPrice"
            const SizedBox(
              height: 16,
            ),
            CustomButton(
              text: 'Complete Payment',
              onTap: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) {
                //   return const PaymentDetailsView();
                // }));

                // showModalBottomSheet(
                //     context: context,
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(16)),
                //     builder: (context) {
                //       return BlocProvider(
                //         create: (context) => PaymentCubit(CheckoutRepoImpl()),
                //         child: const PaymentMethodsBottomSheet(),
                //       );
                //     });

                showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    builder: (context) {
                      return BlocProvider(
                        create: (context) => PaymentCubit(CheckoutRepoImpl()),
                        child: PaymentMethodsBottomSheet(),
                      );
                    });
              },
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
