enum Environment { staging, production }

class AppConfig {
  static const String MAPAPIKEY = "AIzaSyB5j--N6hE0oMw2icYFWhduwwcyJkkWHGc";
  // "AIzaSyC3YyrFK6D5Zc8iOQhuDxeuoCySmO3qkss";
  static const int resendOtpTime = 120;
  static late String version;
}

class AppURL {
  static late Environment environment;
  static const String baseAccountUrl = 'http://dev-api.gocaby.com/account/v1/';
  static const String baseMessagingUrl =
      'http://dev-api.gocaby.com/messaging/v1/';
  static const String basePaymentUrl = 'http://dev-api.gocaby.com/payment/v1/';
  static const String baseTripUrl = 'http://dev-api.gocaby.com/trip/v1/';
  static const String baseRequestUrl = 'http://dev-api.gocaby.com/request/v1/';
  static const String baseRatingUrl = 'http://dev-api.gocaby.com/rating/v1/';
  static const String baseTrackerUrl = 'http://dev-api.gocaby.com/tracker/v1/';
}
// http://dev-api.gocaby.com/request/v2/api-docs

class AppConstants {
  static late Environment environment;
  static String payStackKeys =
      "pk_test_9ea3d8b011e43c9aad765eb8e5412eab10a1f003";
  static const String appPackageAndroid = "";
  static const String deviceTokenAdded = "deviceTokenAdded";
  static const String isUserFirstTime = "isUserFirstTime";
  static const String userObject = "userObject";
  static const String userToken = "userToken";
  static const String email = "email";
  static const String password = "password";
  static const String anErrorOccurred = "An Error Occurred";
  static const String thisFieldIsRequired = "This Field Is Required";
  static const String termsAndCondition = "";
  static const String agoraAppID = "86b2743dd79346dcb9b8aab329b4ad9a";

  static const String fcm = "";
  // "AAAAm_p53H0:APA91bE65LshhbrC7_Cg0FBZ-_UCUxjG8saepQ41GIEHv9F0Au6thqExxDaJ3QhCE2W5FX0oi_jhEsz45FPsXEyxRy24cQCGUC63gdFbpmvXGLxr1W6LkEIjnhMnfxfzVcKPjMWvuxxq";
  // "AAAANXTQmEk:APA91bFp6vpY-14PDGZxDm3U-lqspP0gZD_iAJoysqvqn141DpP40XhjFKYtHcww1geMslbUuEaP-qIDj-cABGX3QH40vGM0mqqdxuLheCIZIDKzsS9U8XL903nlSYzkJNAOd2Fb7w4_";
  static const String appIDIOS = "";

  AppConstants() {
    if (AppConstants.environment == Environment.production) {
      payStackKeys = "";
    }
  }
}
