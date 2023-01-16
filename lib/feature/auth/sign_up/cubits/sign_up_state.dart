part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class GettingVerificationCode extends SignUpState {}

class VerificationCodeSent extends SignUpState {
  final String tempToken;
  final bool isProfileSetup;
  VerificationCodeSent({required this.tempToken, required this.isProfileSetup});
}

class VerificationCodeWithError extends SignUpState {
  final String message;
  VerificationCodeWithError({required this.message});
}

class VerifyOTPCodeLoading extends SignUpState {}

class VerifyOTPCodeSuccess extends SignUpState {}

class VerifyOTPCodeError extends SignUpState {
  final String message;
  VerifyOTPCodeError({required this.message});
}

class RegistrationLoading extends SignUpState {}

class RegistrationSuccess extends SignUpState {}

class RegistrationError extends SignUpState {
  final String message;
  RegistrationError({required this.message});
}

class UploadDocLoading extends SignUpState {}

class UploadDocSuccess extends SignUpState {}

class UploadDocError extends SignUpState {
  final String message;
  UploadDocError({required this.message});
}

class GetProfileLoading extends SignUpState {}

class GetProfileSuccess extends SignUpState {
  final User? user;
  GetProfileSuccess({this.user});
}

class GetProfileError extends SignUpState {
  final String message;
  GetProfileError({required this.message});
}

class GetFcmTokenLoading extends SignUpState {}

class GetFcmTokenSuccess extends SignUpState {
  // final User? user;
  // GetProfileSuccess({this.user});
}

class GetFcmTokenError extends SignUpState {
  final String message;
  GetFcmTokenError({required this.message});
}

class ResendOtpLoading extends SignUpState {}

class ResendOtpSuccess extends SignUpState {}

class ResendOtpError extends SignUpState {
  final String message;
  ResendOtpError({required this.message});
}
