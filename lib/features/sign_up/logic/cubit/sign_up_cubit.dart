import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/core/errors/exceptions.dart';
import 'package:medical_app/core/networking/api_consumer.dart';
import 'package:medical_app/core/networking/endpoints.dart';
import 'package:medical_app/features/sign_up/data/model/sign_up_model.dart';
import 'package:medical_app/features/sign_up/logic/cubit/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.api) : super(SignUpInitial());

  final ApiConsumer api;

  //Sign Up Form key
  GlobalKey<FormState> signUpFormKey = GlobalKey();

  //Sign up name
  TextEditingController signUpName = TextEditingController();
  //Sign up phone number
  TextEditingController signUpPhoneNumber = TextEditingController();
  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  //Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();
  //Sign up birthday controller
  TextEditingController signUpbirthday = TextEditingController();
  //Sign up gender controller
  TextEditingController genderController = TextEditingController();

  //! Signup fun

  signUp() async {
    try {
      emit(SignUpLoading());
      final response = await api.post(EndPoints.signUp, data: {
        ApiKey.displayName: signUpName.text,
        ApiKey.email: signUpEmail.text,
        ApiKey.phone: signUpPhoneNumber.text,
        ApiKey.password: signUpPassword.text,
        ApiKey.confirmPass: confirmPassword.text,
        ApiKey.birth: signUpbirthday.text, //added
        ApiKey.gender: genderController.text,
      });
      print('Response from signUp API: $response');
      final signUpModel = SignUpModel.fromJson(response);
      emit(SignUpSuccess());
    } on ApiException catch (e) {
      emit(SignUpFailure(errorMsg: e.errorModel.errorMessage));
    }
  }
}
