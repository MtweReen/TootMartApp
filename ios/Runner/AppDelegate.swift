import UIKit
import Flutter
import GoogleMaps
import FirebaseCore
@UIApplicationMain

@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GMSServices.provideAPIKey("AIzaSyBxCWZSLFx6zvcjHUGC268Mrkw0EREsyb8")
    GeneratedPluginRegistrant.register(with: self)
    return true
  }
}
