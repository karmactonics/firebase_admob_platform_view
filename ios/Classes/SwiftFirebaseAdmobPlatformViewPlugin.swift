import Flutter
import UIKit

public class SwiftFirebaseAdmobPlatformViewPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "firebase_admob_platform_view", binaryMessenger: registrar.messenger())
    let instance = SwiftFirebaseAdmobPlatformViewPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
