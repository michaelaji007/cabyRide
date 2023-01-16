import 'package:dio/dio.dart';

import '../../../../configs/app_configs.dart';
import '../../../../shared/network/network_request.dart';

class SignUpApiService {
  final HttpService http;
  SignUpApiService({required this.http});

  Future<Response> getFCMToken(Object body) async {
    return HttpService(baseUrl: AppURL.baseMessagingUrl, hasAuthorization: true)
        .post("register-device", data: body);
  }

  Future<Response> verifyOTPCode(Object body) async {
    return http.post("otp/verify", data: body);
  }

  Future<Response> getProfile() async {
    return HttpService(baseUrl: AppURL.baseAccountUrl, hasAuthorization: true)
        .getRequest("me");
  }

  Future<Response> sendOTP(Object body) async {
    return http.post("otp/send", data: body);
  }
}
