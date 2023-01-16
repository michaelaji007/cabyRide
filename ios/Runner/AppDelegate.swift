import UIKit
import Flutter
import GoogleMaps
import Firebase
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override init() {
          FirebaseApp.configure()

      }
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyC3YyrFK6D5Zc8iOQhuDxeuoCySmO3qkss")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
