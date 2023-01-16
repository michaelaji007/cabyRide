//
// class SignInApiService {
//   final HttpService http;
//   SignInApiService({required this.http});
//
//   Future<Response> sendOtp(Object body) async {
//     return http.post("otp/send", data: body);
//   }
//
//   Future<Response> getProfile() async {
//     return HttpService(baseUrl: AppURL.baseAccountUrl, hasAuthorization: true)
//         .getRequest("me");
//   }
//
//   Future<Response> addDeviceToken(body) async {
//     return http.post("", data: body);
//   }
//
//   Future<Response> removeDeviceToken(body) async {
//     return http.post("", data: body);
//   }
// }
