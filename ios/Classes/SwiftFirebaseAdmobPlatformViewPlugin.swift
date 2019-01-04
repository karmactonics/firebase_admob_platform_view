import Flutter
import UIKit
import Firebase

class SwiftFirebaseAdmobPlatformViewPlugin: NSObject, FlutterPlugin {
    
    final let channel: FlutterMethodChannel
    final let registrar: FlutterPluginRegistrar
    
    init(channel: FlutterMethodChannel, registrar: FlutterPluginRegistrar) {
        self.channel = channel
        self.registrar = registrar
        FirebaseApp.configure()
    }
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "hokuto.ibe/firebase_admob_platform_view", binaryMessenger: registrar.messenger())
        let instance = SwiftFirebaseAdmobPlatformViewPlugin(channel: channel, registrar: registrar )
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "initialize"){
            callInitialize(call: call, result: result)
        }
    }
    
    private func callInitialize(call: FlutterMethodCall, result: FlutterResult ) {
        if let arguments = call.arguments as? Dictionary<String, String> {
            guard let appId = arguments["appId"] else {
                result(FlutterError.init(code: "no_app_id", message: "a null or empty AdMob appId was provided", details: nil))
                return
            }
            GADMobileAds.configure(withApplicationID: appId)
            registrar.register( MobileAdViewFactory.init(messenger: registrar.messenger()), withId: "MobileAdView")
            result(true)
        }
    }
    
    
    

}
