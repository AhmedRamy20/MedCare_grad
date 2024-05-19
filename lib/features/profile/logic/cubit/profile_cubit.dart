import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/features/profile/data/model/user_data.dart';
import 'package:medical_app/features/profile/logic/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final Dio dio = Dio();

  Future<void> fetchUserData() async {
    try {
      emit(ProfileLoading());
      final response = await dio
          .get('http://DawayaHealthCare.somee.com/api/Account/GetCurrentuser');
      final userData = UserData.fromJson(response.data);
      emit(ProfileSuccess(userData: userData));
    } catch (e) {
      emit(ProfileError(errMsg: e.toString()));
    }
  }
}
