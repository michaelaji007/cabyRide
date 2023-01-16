part of 'sign_in_cubit.dart';

@immutable
abstract class SignInState {}

class SignUpInitial extends SignInState {}

// States to Get Verification Code

class SendOtpLoading extends SignInState {}

class SendOtpSuccess extends SignInState {
  // final UserStoreModel user;
  // LoginSuccess({required this.user});
}

class SendOtpError extends SignInState {
  final String message;
  SendOtpError({required this.message});
}

class RemovedTokenWithError extends SignInState {
  final String message;
  RemovedTokenWithError({required this.message});
}

class VerifyOTPCodeLoading extends SignInState {}

class VerifyOTPCodeSuccess extends SignInState {
  final String tempToken;
  VerifyOTPCodeSuccess({required this.tempToken});
}

class VerifyOTPCodeError extends SignInState {
  final String message;
  VerifyOTPCodeError({required this.message});
}

class AddPersonalInfoLoading extends SignInState {}

class AddPersonalInfoSuccess extends SignInState {
  // final UserDetailsResponse userDetailsResponse;
  // UpdateUserDetailsSuccess({required this.userDetailsResponse});
}

class AddPersonalInfoError extends SignInState {
  final String message;
  AddPersonalInfoError({required this.message});
}

//Upload image
class UploadingImage extends SignInState {}

class UploadedImage extends SignInState {
  final String imageUrl;
  UploadedImage({required this.imageUrl});
}

class UploadedImageWithError extends SignInState {
  final String message;
  UploadedImageWithError({required this.message});
}

class GetCurrentPhaseLoading extends SignInState {}

class GetCurrentPhaseSuccess extends SignInState {
  final String message;
  GetCurrentPhaseSuccess({required this.message});
}

class GetCurrentPhaseError extends SignInState {
  final String message;
  GetCurrentPhaseError({required this.message});
}
