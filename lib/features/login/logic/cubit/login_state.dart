class LoginState {}

final class LoginInitial extends LoginState {}

final class SignInSuccess extends LoginState {}

final class SignInLoading extends LoginState {}
final class SignInVerifyEmail extends LoginState {}

final class SignInFailure extends LoginState {
  final String errorMsg;

  SignInFailure({required this.errorMsg});
}
