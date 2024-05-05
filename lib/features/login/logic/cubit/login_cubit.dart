import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/core/errors/exceptions.dart';
import 'package:medical_app/core/networking/api_consumer.dart';
import 'package:medical_app/core/networking/endpoints.dart';
import 'package:medical_app/features/login/data/model/sign_in_model.dart';
import 'package:medical_app/features/login/logic/cubit/login_state.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:medical_app/core/cache/cache_helper.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.api) : super(LoginInitial());

  final ApiConsumer api;
  SignInModel? user;
  //Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();
  //Sign in email
  TextEditingController signInEmail = TextEditingController();
  //Sign in password
  TextEditingController signInPassword = TextEditingController();

  //* Login request
  signIn() async {
    // final dio = Dio;

    try {
      emit(SignInLoading());
      final response = await api.post(
        EndPoints.signIn,
        data: {
          ApiKey.email: signInEmail.text,
          ApiKey.password: signInPassword.text,
        },
      );

      user = SignInModel.fromJson(response);

      final decodedToken = JwtDecoder.decode(user!.token);

      ChacheHelper().saveData(key: ApiKey.token, value: user!.token);
      ChacheHelper()
          .saveData(key: ApiKey.name, value: decodedToken[ApiKey.name]);

      emit(SignInSuccess());

      // print(response);
    } on ApiException catch (e) {
      emit(SignInFailure(errorMsg: e.errorModel.errorMessage));
    }
  }

  //* Did not use it though ...
  String? get loggedInUsername => user?.name;
}




// {
//   "email": "ahmedramyars@gmail.com",
//   "password": "123456789a#"
// }