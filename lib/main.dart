import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:fakecall/model/data.dart';
import 'package:fakecall/model_view/data_provider.dart';
import 'package:fakecall/view/Splash.dart';
import 'package:fakecall/view/brand.dart';
import 'package:fakecall/view/home/home.dart';
import 'package:fakecall/view/onboarding/onboarding.dart';
import 'package:fakecall/view/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

enum AdNetwork { admob, facebook, unity, applovin }

AdNetwork selectedAdNetwork = AdNetwork.facebook;

///creat by Mfagri
Data data = Data();
//testing git clone
//this for camera
late List<CameraDescription> cameras;
//this for package info
PackageInfo? packageInfo = PackageInfo(
  appName: 'Unknown',
  packageName: 'Unknown',
  version: 'Unknown',
  buildNumber: 'Unknown',
);

bool firstTime = false;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Future.wait([
    MobileAds.instance.initialize(),
    FacebookAudienceNetwork.init(
      testingId: "bfe47acb-dd50-43d6-8d3c-a65f0a6cee42",
    ),
    UnityAds.init(
      gameId: "5712423",
      testMode: true,
      onComplete: () {},
      onFailed: (error, message) {},
    ),
  ]);
  FlutterForegroundTask.initCommunicationPort();
  packageInfo = await PackageInfo.fromPlatform();
  //read json file from assets
  final json = await rootBundle.loadString('assets/db.json');
  final config = jsonDecode(json);
  data = Data.fromJson(config);
  //camera permission
  SharedPreferences prefs = await SharedPreferences.getInstance();
  firstTime = (prefs.getBool('isfirsttime') ?? false);
  if (!firstTime) {
    prefs.setBool('isfirsttime', true);
  }
  await Permission.camera.request();
  requestPermissions();

  //camera initialization
  cameras = await availableCameras();

  // Load interstitial ad (so it's ready when needed)
  //await UnityAds.loadInterstitialAd();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          scaffoldBackgroundColor: const Color(0xff0F0E0E),
          useMaterial3: true,
        ),
        initialRoute: '/brand',
        routes: {
          '/': (context) => const SplashScreen(),
          '/brand': (context) => const BrandScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
          '/home': (context) => const HomeScreen(),
          '/profile': (context) => const Profile(),
        },
      ),
    );
  }
}

@pragma('vm:entry-point')
void startCallback() {
  // The setTaskHandler function must be called to handle the task in the background.
  // FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

// class MyTaskHandler extends TaskHandler {
//   // Called when the task is started.
//   @override
//   // void onStart(DateTime timestamp) {}

//   // Called by eventAction in [ForegroundTaskOptions].
//   // - nothing() : Not use onRepeatEvent callback.
//   // - once() : Call onRepeatEvent only once.
//   // - repeat(interval) : Call onRepeatEvent at milliseconds interval.
//   @override
//   void onRepeatEvent(DateTime timestamp) {
//     // Send data to main isolate.
//     final Map<String, dynamic> data = {
//       "timestampMillis": timestamp.millisecondsSinceEpoch,
//     };
//     FlutterForegroundTask.sendDataToMain(data);
//   }

//   // Called when the task is destroyed.
//   @override
//   void onDestroy(DateTime timestamp) {}

//   // Called when data is sent using [FlutterForegroundTask.sendDataToTask].
//   @override
//   void onReceiveData(Object data) {}

//   // Called when the notification button is pressed.
//   @override
//   void onNotificationButtonPressed(String id) {}

//   // Called when the notification itself is pressed.
//   //
//   // AOS: "android.permission.SYSTEM_ALERT_WINDOW" permission must be granted
//   // for this function to be called.
//   @override
//   void onNotificationPressed() {
//     FlutterForegroundTask.launchApp('/');
//   }

//   //
//   // AOS: only work Android 14+
//   // iOS: only work iOS 10+
//   @override
//   void onNotificationDismissed() {}
// }

Future<void> requestPermissions() async {
  final NotificationPermission notificationPermissionStatus =
      await FlutterForegroundTask.checkNotificationPermission();
  if (notificationPermissionStatus != NotificationPermission.granted) {
    await FlutterForegroundTask.requestNotificationPermission();
  }

  if (Platform.isAndroid) {
    if (!await FlutterForegroundTask.canDrawOverlays) {
      await FlutterForegroundTask.openSystemAlertWindowSettings();
    }
    if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
      await FlutterForegroundTask.requestIgnoreBatteryOptimization();
    }
    if (!await FlutterForegroundTask.canScheduleExactAlarms) {
      await FlutterForegroundTask.openAlarmsAndRemindersSettings();
    }
  }
}
