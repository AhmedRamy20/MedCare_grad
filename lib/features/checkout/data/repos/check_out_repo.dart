
import 'package:dartz/dartz.dart';
import 'package:medical_app/core/errors/failure_payment.dart';
import 'package:medical_app/features/checkout/data/models/payment_intent_input_model.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel});
}
