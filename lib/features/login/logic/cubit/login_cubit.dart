import 'package:dio/dio.dart';
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
  LoginCubit() : super(LoginInitial());

  // final ApiConsumer api;
  final Dio dio = Dio();
  SignInModel? user;
  //Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();
  //Sign in email
  TextEditingController signInEmail = TextEditingController();
  //Sign in password
  TextEditingController signInPassword = TextEditingController();

  //* Check if the user is already logged in
  Future<void> checkLoginStatus() async {
    final token = ChacheHelper.sharedPreferences.getString('token');
    if (token != null && !JwtDecoder.isExpired(token)) {
      final decodedToken = JwtDecoder.decode(token);
      emit(SignInSuccess());
    } else {
      emit(LoginInitial());
    }
  }

  //* Login request
  signIn() async {
    // final dio = Dio;

    try {
      emit(SignInLoading());
      final response = await dio.post(
        "http://DawayaHealthCare.somee.com/api/Account/Login",
        data: {
          ApiKey.email: signInEmail.text,
          ApiKey.password: signInPassword.text,
        },
      );

      //*
      if (response.data ==
          "User is registered but the account is not activated") {
        emit(SignInVerifyEmail());
      } else {
        user = SignInModel.fromJson(response.data);

        final decodedToken = JwtDecoder.decode(user!.token);

        ChacheHelper().saveData(key: ApiKey.token, value: user!.token);
        ChacheHelper()
            .saveData(key: ApiKey.name, value: decodedToken[ApiKey.name]);

        emit(SignInSuccess());
      }
      //*

      // user = SignInModel.fromJson(response.data);

      // final decodedToken = JwtDecoder.decode(user!.token);

      // ChacheHelper().saveData(key: ApiKey.token, value: user!.token);
      // ChacheHelper()
      //     .saveData(key: ApiKey.name, value: decodedToken[ApiKey.name]);

      // emit(SignInSuccess());

      // print(response);
    } on DioError catch (e) {
      if (e.response != null) {
        // print('Server responded with ${e.response!.statusCode}');
        // print('Response data: ${e.response!.data}');
        emit(SignInFailure(errorMsg: "${e.response!.data}"));
      } else {
        // print('Network error: ${e.message}');
        emit(SignInFailure(errorMsg: "Failed to login Duo to Network issue.."));
        // emit(VerifyEmailSuccess());
      }
    } catch (e) {
      print('Error: $e');
      emit(SignInFailure(errorMsg: e.toString()));
    }
    // on ApiException catch (e) {
    //   emit(SignInFailure(errorMsg: e.errorModel.errorMessage));
    // }
  }

  //!! Method to clear cached user data
  Future<void> clearUserData() async {
    await ChacheHelper().removeData(key: ApiKey.token);
    await ChacheHelper().removeData(key: ApiKey.name);
  }

  //* Did not use it though ...
  String? get loggedInUsername => user?.name;
}




// {
//   "email": "ahmedramyars@gmail.com",
//   "password": "123456789a#"
// }







//* old method
// signIn() async {
//     // final dio = Dio;

//     try {
//       emit(SignInLoading());
//       final response = await api.post(
//         EndPoints.signIn,
//         data: {
//           ApiKey.email: signInEmail.text,
//           ApiKey.password: signInPassword.text,
//         },
//       );

//       //*
//       if (response.data == "User is registered but the account is not activated") {
//         emit(SignInVerifyEmail());
//       }
//       //*

//       user = SignInModel.fromJson(response);

//       final decodedToken = JwtDecoder.decode(user!.token);

//       ChacheHelper().saveData(key: ApiKey.token, value: user!.token);
//       ChacheHelper()
//           .saveData(key: ApiKey.name, value: decodedToken[ApiKey.name]);

//       emit(SignInSuccess());

//       // print(response);
//     } on ApiException catch (e) {
//       emit(SignInFailure(errorMsg: e.errorModel.errorMessage));
//     }
//   }