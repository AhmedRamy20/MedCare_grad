class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpSuccess extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpFailure extends SignUpState {
  final String errorMsg;

  SignUpFailure({required this.errorMsg});
}
