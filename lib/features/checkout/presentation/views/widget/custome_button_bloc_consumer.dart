import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:medical_app/core/widgets/custome_button.dart';
import 'package:medical_app/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:medical_app/features/checkout/presentation/manager/cubit/payment_cubit.dart';
import 'package:medical_app/features/checkout/presentation/views/thank_you_view.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  final double totalPrice;
  const CustomButtonBlocConsumer({
    super.key,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return ThankYouView(
              totalPrice: totalPrice,
            );
          }));
        }

        if (state is PaymentFailure) {
          Navigator.of(context).pop();
          // SnackBar snackBar = SnackBar(content: Text(state.errMessage));
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(
                  state.errMessage,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsProvider.primaryBink,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Got it",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      },
      builder: (context, state) {
        return CustomButton(
          onTap: () {
            // paymentIntentInputModel here we put the data of the order
            int totalPriceInCents = (totalPrice).round();
            PaymentIntentInputModel paymentIntentInputModel =
                PaymentIntentInputModel(
                    amount: totalPriceInCents.toString(), currency: 'USD');
            BlocProvider.of<PaymentCubit>(context)
                .makePayment(paymentIntentInputModel: paymentIntentInputModel);
          },
          isLoading: state is PaymentLoading ? true : false,
          text: "Continue",
        );
      },
    );
  }
}
