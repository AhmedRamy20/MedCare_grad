class VerifyEmailState {}

final class VerifyEmailInitial extends VerifyEmailState {}

final class VerifyEmailSuccess extends VerifyEmailState {}

final class VerifyEmailLoading extends VerifyEmailState {}

final class VerifyEmailFailure extends VerifyEmailState {
  final String errorMsg;

  VerifyEmailFailure({required this.errorMsg});
}
