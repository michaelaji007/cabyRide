import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../../configs/app_configs.dart';
import '../../../../configs/app_startup.dart';
import '../../../../shared/network/network_request.dart';
import '../../../../shared/notifications/firebase_notification_manager.dart';
import '../../../../shared/utils/storage.dart';
import '../model/fcm_model.dart';
import '../model/user.dart';
import '../services/api_service.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpApiService apiService;
  SignUpCubit({required this.apiService}) : super(SignUpInitial());

  void getFCMToken(String? userId) async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    String token = (await FirebaseNotificationManager().deviceToken)!;
    emit(GetFcmTokenLoading());
    try {
      DeviceFCMModel model = DeviceFCMModel(
          deviceToken: token,
          deviceModel: Platform.isAndroid ? "Android" : "iOS",
          userId: userId);
      var res = await apiService.getFCMToken(model.toJson());
      if (res.isSuccessful) {
        emit(GetFcmTokenSuccess());
      } else {
        emit(GetFcmTokenError(message: AppConstants.anErrorOccurred));
      }
    } catch (ex) {
      if (ex is DioError) {
        var errorMessage = networkErrorHandler(ex);
        emit(GetFcmTokenError(message: errorMessage));
      } else {
        emit(GetFcmTokenError(message: AppConstants.anErrorOccurred));
      }
    }
  }

  void getProfile() async {
    emit(GetProfileLoading());
    try {
      var res = await apiService.getProfile();
      if (res.isSuccessful) {
        User userProfile = User.fromJson(res.data);
        LocalStorageUtils.saveObject<User>(
            AppConstants.userObject, userProfile);
        if (getIt.isRegistered<User>()) {
          getIt.unregister<User>();
        }
        getIt.registerSingleton<User>(userProfile);
        getFCMToken(userProfile.userId);
        emit(GetProfileSuccess(user: userProfile));
      } else {
        emit(GetProfileError(message: AppConstants.anErrorOccurred));
      }
    } catch (ex) {
      if (ex is DioError) {
        var errorMessage = networkErrorHandler(ex);
        emit(GetProfileError(message: errorMessage));
      } else {
        emit(GetProfileError(message: AppConstants.anErrorOccurred));
      }
    }
  }

  void verifyOTPCode(otp, phone) async {
    emit(VerifyOTPCodeLoading());
    var body = {
      "accountType": "RIDER",
      "oneTimeToken": otp,
      "phoneNumber": phone,
    };
    try {
      var res = await apiService.verifyOTPCode(body);

      if (res.isSuccessful) {
        UserTokenManager.insertAccessToken(res.data["token"]);
        getProfile();
        emit(VerifyOTPCodeSuccess());
      } else {
        var message = res.data["message"];
        emit(VerifyOTPCodeError(message: message));
      }
    } catch (ex) {
      if (ex is DioError) {
        if (ex.response?.statusCode == 400) {
          var message = ex.response!.data;
          emit(VerifyOTPCodeError(message: message));
        } else {
          var errorMessage = networkErrorHandler(ex);
          emit(VerifyOTPCodeError(message: errorMessage));
        }
      }
    }
  }

  void sendOTP(phone, existingAccount, {email}) async {
    emit(ResendOtpLoading());
    var body = {
      "email": email,
      "existingAccount": existingAccount,
      "phoneNumber": phone
    };

    try {
      var res = await apiService.sendOTP(body);

      if (res.isSuccessful) {
        // var data = res.data["data"];
        emit(ResendOtpSuccess());
      }
    } catch (ex) {
      if (ex is DioError) {
        var errorMessage = networkErrorHandler(ex);

        emit(ResendOtpError(message: errorMessage));
      }
    }
  }
}
