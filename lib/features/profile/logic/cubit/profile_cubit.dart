import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_app/features/profile/data/model/user_data.dart';
import 'package:medical_app/features/profile/logic/cubit/profile_state.dart';
import 'package:medical_app/core/cache/cache_helper.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final Dio dio = Dio();

  Future<void> fetchUserData() async {
    try {
      emit(ProfileLoading());

      //* Retrieve the token from secure storage or any other source
      // String? token = await chacheHel;
      final token = ChacheHelper.sharedPreferences.getString('token');

      // Check if token is not null
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await dio.get(
        'http://DawayahealthCare2.somee.com/Account/GetCurrentuser',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final userData = UserData.fromJson(response.data);

      // Retrieve the saved image URL from SharedPreferences
      // final savedImageUrl = await ChacheHelper().getImageUrl();
      // if (savedImageUrl != null) {
      //   userData.pictureUrl = savedImageUrl;
      // }
      // Save the image URL to shared preferences
      if (userData.pictureUrl != null) {
        await ChacheHelper().saveImageUrl(userData.pictureUrl!);
      }
      emit(ProfileSuccess(userData: userData));
    } on DioError catch (e) {
      // if (e.message!.contains('Connection failed') ||
      //     e.message!.contains('Connection refused') ||
      //     e.message!.contains('Connection reset') ||
      //     e.message!.contains('SocketException')) {
      //   emit(ProfileError(errMsg: 'No internet connection'));
      // } else {
      //   emit(ProfileError(errMsg: 'Error: ${e.message}'));
      // }
      if (_isConnectionError(e)) {
        emit(ProfileNoInternet());
      } else {
        emit(ProfileError(errMsg: 'Error: ${e.message}'));
      }
    } catch (e) {
      emit(ProfileError(errMsg: e.toString()));
    }
  }

  bool _isConnectionError(DioError e) {
    return e.error is SocketException ||
        e.error is HttpException ||
        e.error is TimeoutException;
  }

  //!! update

  Future<void> updateUserData({
    required String displayName,
    required int weight,
    required int height,
    XFile? imageFile, //make it File
  }) async {
    try {
      emit(ProfileLoading());

      final token = ChacheHelper.sharedPreferences.getString('token');

      // Check if token is not null
      if (token == null) {
        throw Exception('No token found');
      }
      FormData formData = FormData();
      formData.fields.add(MapEntry('DisplayName', displayName));
      formData.fields.add(MapEntry('Weight', weight.toString()));
      formData.fields.add(MapEntry('Height', height.toString()));
      if (imageFile != null) {
        formData.files.add(MapEntry(
          'Image',
          await MultipartFile.fromFile(imageFile.path, filename: 'image.jpg'),
        ));
      }
      // Add authorization header
      final response = await dio.put(
        'http://DawayahealthCare2.somee.com/Account/UpdateCurrentUser',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.data != 'User updated successfully') {
        throw Exception('Error: ${response.data}');
      }

      //final userData = UserData.fromJson(response.data);
      //if (userData.pictureUrl != null) {
      //await ChacheHelper().saveImageUrl(userData.pictureUrl!);
      //}
      final userData = UserData(
        displayName: displayName,
        weight: weight,
        height: height,
        pictureUrl:
            imageFile != null ? await ChacheHelper().getImageUrl() : null,
        email: '',
      );

      // Save the image URL to shared preferences if a new image is uploaded
      if (userData.pictureUrl != null) {
        await ChacheHelper().saveImageUrl(userData.pictureUrl!);
      }
      emit(ProfileSuccess(userData: userData));
    } catch (e) {
      emit(ProfileError(errMsg: e.toString()));
    }
  }
}
