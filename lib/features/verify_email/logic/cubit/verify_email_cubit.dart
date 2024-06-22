import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical_app/features/verify_email/logic/cubit/verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  VerifyEmailCubit() : super(VerifyEmailInitial());

  // final ApiConsumer api;
  final Dio dio = Dio();

  //verification email controller
  TextEditingController verifyEmail = TextEditingController();
  //verification Code controller
  TextEditingController verificationCode = TextEditingController();
  //verification email form controller
  GlobalKey<FormState> verifyKey = GlobalKey();

  //* Login request
  verifyEmailRequest() async {
    try {
      final response = await dio.post(
        "http://DawayaHealthCare777.somee.com/Account/Verify-Email",
        data: {
          "email": verifyEmail.text,
          "verificationCode": verificationCode.text,
        },
      );

      if (response.data == "Email Verified") {
        //Email Verification
        emit(VerifyEmailSuccess());
      } else {
        emit(VerifyEmailFailure(errorMsg: "Failed to verify email"));
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Server responded with ${e.response!.statusCode}');
        print('Response data: ${e.response!.data}');
        emit(VerifyEmailFailure(
            errorMsg: "${e.response!.data}")); //Failed to verify email:
      } else {
        print('Network error: ${e.message}');
        emit(VerifyEmailFailure(
            errorMsg: "Failed to verify email: Network error"));
        // emit(VerifyEmailSuccess());
      }
    } catch (e) {
      print('Error: $e');
      emit(VerifyEmailFailure(
          errorMsg: "Failed to verify email: Unexpected error"));
    }
  }
}
