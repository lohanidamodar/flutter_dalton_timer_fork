import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    let controller = self.window.rootViewController as! FlutterViewController
    
    let screenWakeLockChannel = FlutterMethodChannel(
        name: "pl.ukaszapps/screenwakelock",
        binaryMessenger:controller)
    
    screenWakeLockChannel.setMethodCallHandler({
        (call: FlutterMethodCall, result: FlutterResult) -> Void in
        if call.method == "setAwake" {
            self.requestScreenLock(result: result)
        }else{
            self.releaseScreenLock(result: result)
        }
    })
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func requestScreenLock(result: FlutterResult){
        UIApplication.shared.isIdleTimerDisabled = true
        result(nil)
    }
    private func releaseScreenLock(result: FlutterResult){
        UIApplication.shared.isIdleTimerDisabled = false
        result(nil)
    }
}

