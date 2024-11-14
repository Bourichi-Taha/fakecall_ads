import UserNotifications
import Flutter


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
         SwiftFlutterForegroundTaskPlugin.setPluginRegistrantCallback(registerPlugins)
         ///package
        if #available(iOS 10.0, *) {
          UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        }
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        //package
        let foregroundChannel = FlutterMethodChannel(name: "foreground/notification",
                                                     binaryMessenger: controller.binaryMessenger)

        foregroundChannel.setMethodCallHandler({ [weak self]
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if call.method == "bringToForeground" {
                if let args = call.arguments as? [String: Any],
                   let title = args["title"] as? String,
                   let body = args["body"] as? String,
                   let imageName = args["image"] as? String {
                    self?.sendLocalNotification(title: title, body: body, imageName: imageName)
                }
                result(nil)
            } else {
                result(FlutterMethodNotImplemented)
            }
        })

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func sendLocalNotification(title: String, body: String, imageName: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        

        if let imageURL = Bundle.main.url(forResource: imageName, withExtension: nil) {
            if let attachment = try? UNNotificationAttachment(identifier: "image", url: imageURL, options: nil) {
                content.attachments = [attachment]
            }
        }

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "CallAlert", content: content, trigger: trigger)

        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
}
//packge
func registerPlugins(registry: FlutterPluginRegistry) {
  GeneratedPluginRegistrant.register(with: registry)
}
