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
        'http://DawayahealthCare1.somee.com/Account/GetCurrentuser',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final userData = UserData.fromJson(response.data);
      emit(ProfileSuccess(userData: userData));
    } catch (e) {
      emit(ProfileError(errMsg: e.toString()));
    }
  }

  //!! update

  Future<void> updateUserData({
    String? displayName,
    int? weight,
    int? height,
    String? pictureUrl,
    XFile? imageFile, //make it File
  }) async {
    try {
      emit(ProfileLoading());

      final token = ChacheHelper.sharedPreferences.getString('token');

      // Check if token is not null
      if (token == null) {
        throw Exception('No token found');
      }

      // FormData formData = FormData.fromMap({
      //   'DisplayName': displayName,
      //   'Weight': weight,
      //   'Height': height,
      //   'Image': await MultipartFile.fromFile(imageFile!.path,
      //       filename: 'image.jpg'),
      // });
      FormData formData = FormData();
      if (displayName != null) {
        formData.fields.add(MapEntry('DisplayName', displayName));
      }
      if (weight != null) {
        formData.fields.add(MapEntry('Weight', weight.toString()));
      }
      if (height != null) {
        formData.fields.add(MapEntry('Height', height.toString()));
      }
      if (imageFile != null) {
        formData.files.add(MapEntry(
          'Image',
          await MultipartFile.fromFile(imageFile.path, filename: 'image.jpg'),
        ));
      }
      // Add authorization header
      final response = await dio.put(
        'http://DawayahealthCare1.somee.com/Account/UpdateCurrentUser',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final userData = UserData.fromJson(response.data);
      emit(ProfileSuccess(userData: userData));
    } catch (e) {
      emit(ProfileError(errMsg: e.toString()));
    }
  }
}
