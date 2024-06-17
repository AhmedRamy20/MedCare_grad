import 'package:medical_app/features/profile/data/model/user_data.dart';

class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserData userData;

  ProfileSuccess({required this.userData});
}

class ProfileError extends ProfileState {
  final String errMsg;
  ProfileError({
    required this.errMsg,
  });
}

class ProfileNoInternet extends ProfileState {}
