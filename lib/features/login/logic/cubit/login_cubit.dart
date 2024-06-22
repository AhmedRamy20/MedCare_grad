import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/core/networking/endpoints.dart';
import 'package:medical_app/features/login/data/model/sign_in_model.dart';
import 'package:medical_app/features/login/logic/cubit/login_state.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:medical_app/core/cache/cache_helper.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final Dio dio = Dio();
  SignInModel? user;
  GlobalKey<FormState> signInFormKey = GlobalKey();
  TextEditingController signInEmail = TextEditingController();
  TextEditingController signInPassword = TextEditingController();

  Future<void> checkLoginStatus() async {
    final token = ChacheHelper.sharedPreferences.getString('token');
    if (token != null && !JwtDecoder.isExpired(token)) {
      final decodedToken = JwtDecoder.decode(token);
      if (decodedToken['role'] == 'User') {
        // emit(NurseSignInSuccess());
        emit(SignInSuccess());
      } else {
        emit(NurseSignInSuccess());
        // emit(SignInSuccess());
      }
    } else {
      emit(LoginInitial());
    }
  }

  Future<void> signIn() async {
    try {
      emit(SignInLoading());
      final response = await dio.post(
        "http://DawayaHealthCare777.somee.com/Account/Login",
        data: {
          ApiKey.email: signInEmail.text,
          ApiKey.password: signInPassword.text,
        },
      );

      if (response.data ==
          "User is registered but the account is not activated") {
        emit(SignInFailure(
            errorMsg: "User is registered but the account is not activated"));
      } else {
        user = SignInModel.fromJson(response.data);
        final decodedToken = JwtDecoder.decode(user!.token);

        ChacheHelper().saveData(key: ApiKey.token, value: user!.token);
        ChacheHelper()
            .saveData(key: ApiKey.name, value: decodedToken[ApiKey.name]);

        if (decodedToken['role'] == 'User') {
          // emit(NurseSignInSuccess());
          emit(SignInSuccess());
        } else {
          emit(NurseSignInSuccess());
          // emit(SignInSuccess());
        }
      }
    } on DioError catch (e) {
      if (e.response != null) {
        emit(SignInFailure(errorMsg: "${e.response!.data}"));
      } else {
        emit(SignInFailure(errorMsg: "Failed to login due to network issue."));
      }
    } catch (e) {
      emit(SignInFailure(errorMsg: e.toString()));
    }
  }

  Future<void> clearUserData() async {
    await ChacheHelper().removeData(key: ApiKey.token);
    await ChacheHelper().removeData(key: ApiKey.name);
    // await ChacheHelper().removeThemePreference();
    // await ChacheHelper().saveThemePreference(false);
    await ChacheHelper().saveThemePreference(false);
    print("Theme preference set to light mode");
  }

  String? get loggedInUsername => user?.name;
}
