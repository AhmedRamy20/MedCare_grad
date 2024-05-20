
import 'package:dartz/dartz.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:medical_app/core/components/stripe_service.dart';
import 'package:medical_app/core/errors/failure_payment.dart';
import 'package:medical_app/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:medical_app/features/checkout/data/repos/check_out_repo.dart';

class CheckoutRepoImpl extends CheckoutRepo {
  final StripeService stripeService = StripeService();
  @override
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      await stripeService.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);

      return right(null);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}


// on StripeException catch (e) {
// return left(ServerFailure(
// errMessage: e.error.message ?? 'Oops there was an error'));
// }
