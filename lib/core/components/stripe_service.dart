import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:medical_app/core/theming/colors.dart';

import '../../features/checkout/data/models/init_payment_sheet_input_model.dart';
import '../../features/checkout/data/models/payment_intent_input_model.dart';
import '../../features/checkout/data/models/payment_intent_model/payment_intent_model.dart';
import '../networking/endpoints.dart';
import 'api_service.dart';

class StripeService {
  final ApiService apiService = ApiService();
  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    var response = await apiService.post(
      body: paymentIntentInputModel.toJson(),
      contentType: Headers.formUrlEncodedContentType,
      url: 'https://api.stripe.com/v1/payment_intents',
      token: ApiKey.secretKey,
    );

    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);

    return paymentIntentModel;
  }

  Future initPaymentSheet({required String paymentIntentClientSecret}) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClientSecret,
        appearance: PaymentSheetAppearance(
          colors: PaymentSheetAppearanceColors(
            background: Colors.white,
            primary: ColorsProvider.primaryBink,
            componentBackground: Colors.white,
            componentBorder: Colors.black45,
            primaryText: Colors.black,
            secondaryText: Colors.black54,
            placeholderText: Colors.grey,
            icon: Colors.black,
            componentText: Colors.black,
          ),
        ),
        merchantDisplayName: 'ramy',
      ),
    );
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);

    await initPaymentSheet(
        paymentIntentClientSecret: paymentIntentModel.clientSecret!);
    await displayPaymentSheet();
  }
}
