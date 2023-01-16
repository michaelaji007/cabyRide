import 'package:meta/meta.dart';

part 'sign_in_state.dart';

// class SignInCubit extends Cubit<SignInState> {
//   final SignInApiService apiService;
//   SignInCubit({required this.apiService}) : super(SignUpInitial());

// void addDeviceToken() async {
//   DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
//   String token = (await FirebaseNotificationManager().deviceToken)!;
//   try {
//     var os = Platform.isAndroid ? "Android" : "iOS";
//     String? model = "";
//     if (Platform.isAndroid) {
//       var androidInfo = await deviceInfoPlugin.androidInfo;
//       model = androidInfo.model;
//     } else {
//       var iOSInfo = await deviceInfoPlugin.iosInfo;
//       model = iOSInfo.name;
//     }
//
//     var body = {
//       "token": token,
//       "meta": {
//         "os": os,
//         "model": model,
//       },
//     };
//     var res = await apiService.addDeviceToken(body);
//     if (res.isSuccessful) {
//       // Add to local storage that device token has been map to user.
//       LocalStorageUtils.write(AppConstants.deviceTokenAdded, "true");
//     }
//   } catch (ex) {
//     if (ex is DioError) {
//       String errorMessage;
//       errorMessage = networkErrorHandler(ex);
//       emit(LoginError(message: errorMessage));
//     } else {
//       emit(LoginError(message: ""));
//     }
//   }
// }

// Future<void> removeDeviceToken({required String userId}) async {
//   String token = (await FirebaseNotificationManager().deviceToken)!;
//   try {
//     var body = {
//       "token": token,
//       "user": userId,
//     };
//     var res = await apiService.removeDeviceToken(body);
//     if (res.isSuccessful) {
//       // Add to local storage that device token has been map to user.
//       LocalStorageUtils.write(AppConstants.deviceTokenAdded, "false");
//     }
//   } catch (ex) {
//     if (ex is DioError) {
//       String errorMessage;
//       errorMessage = networkErrorHandler(ex);
//       emit(RemovedTokenWithError(message: errorMessage));
//     } else {
//       emit(RemovedTokenWithError(message: AppConstants.anErrorOccurred));
//     }
//   }
// }
// }
