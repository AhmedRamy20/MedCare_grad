
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

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

  Future initPaymentSheet(
      {required String paymentIntentClientSecret }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClientSecret,
        // customerEphemeralKeySecret:
        // initiPaymentSheetInputModel.ephemeralKeySecret,
        // customerId: initiPaymentSheetInputModel.customerId,
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
    // var ephemeralKeyModel =
    // await createEphemeralKey(customerId: paymentIntentInputModel.cusomerId);
    // var initPaymentSheetInputModel = InitiPaymentSheetInputModel(
    //     clientSecret: paymentIntentModel.clientSecret!,
    //     customerId: paymentIntentInputModel.cusomerId,
    //     ephemeralKeySecret: ephemeralKeyModel.secret!);
    await initPaymentSheet(paymentIntentClientSecret: paymentIntentModel.clientSecret!);
    // await initPaymentSheet(
    //     initiPaymentSheetInputModel: initPaymentSheetInputModel);
    await displayPaymentSheet();
  }

  // Future<EphemeralKeyModel> createEphemeralKey(
  //     {required String customerId}) async {
  //   var response = await apiService.post(
  //       body: {'customer': customerId},
  //       contentType: Headers.formUrlEncodedContentType,
  //       url: 'https://api.stripe.com/v1/ephemeral_keys',
  //       token: ApiKey.secretKey,
  //       headers: {
  //         'Authorization': "Bearer ${ApiKey.secretKey}",
  //         'Stripe-Version': '2023-08-16',
  //       });
  //
  //   var ephermeralKey = EphemeralKeyModel.fromJson(response.data);
  //
  //   return ephermeralKey;
  // }
}
