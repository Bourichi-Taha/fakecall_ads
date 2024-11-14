import 'dart:io';
import 'dart:ui';

import 'package:bordered_text/bordered_text.dart';
import 'package:fakecall/ad_manager/interstitial_ad.dart';
import 'package:fakecall/model/data.dart';
import 'package:fakecall/model_view/data_provider.dart';
import 'package:fakecall/utils/image_constants.dart';
import 'package:fakecall/view/call/audiocall.dart';
import 'package:fakecall/view/call/videocall.dart';
import 'package:fakecall/view/call/widget/call_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
// import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AudioVideo extends StatefulWidget {
  final Content content;
  final bool isAudio;

  const AudioVideo({super.key, required this.content, required this.isAudio});

  @override
  State<AudioVideo> createState() => _AudioVideoState();
}

class _AudioVideoState extends State<AudioVideo> {
  int _time = 0;
  int _delay = 0;
  int _isRunning = 0;

  final List<int> delayTimes = [5, 30, 60]; // Add more times as needed

  @override
  void initState() {
    super.initState();
    initForegroundTask();
  }

  void initForegroundTask() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'notification_channel_id',
        channelName: 'Foreground Notification',
        channelDescription: 'This notification appears when the foreground service is running.',
        channelImportance: NotificationChannelImportance.HIGH,
        priority: NotificationPriority.HIGH,
        playSound: true,
        enableVibration: true,
        showWhen: true,
        showBadge: true,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: true,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.once(),
        autoRunOnBoot: true,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

  @override
  void dispose() {
    FlutterForegroundTask.stopService();
    super.dispose();
  }

  void _navigateToCallPage() {
    final page = widget.isAudio
        ? Audiocall(content: widget.content)
        : VideocallScreen(content: widget.content);
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  void _handleDelayedNavigation(int delayInSeconds) {
    _countdown();
    AppInterstitialAd.show();

    setState(() {
      _time = delayInSeconds;
    });
    //here i pass the arguments to the method channel
    // final arguments = <String, dynamic>{
    //   'title': 'Call from ${widget.content.name}',
    //   'body': widget.content.number,
    //   'image': 'brand', // Replace with actual image file name in assets
    // };
    //here i call my method channel
    // const platform = MethodChannel('foreground/notification');
    Future.delayed(Duration(seconds: delayInSeconds), () async {
      if (mounted && _time == delayInSeconds) {
        setState(() {
          _time = 0;
          _isRunning = 0;
        });
        //i check if the platform is ios
        if (Platform.isIOS) {
          if (await FlutterForegroundTask.isRunningService) {
            await FlutterForegroundTask.restartService();
          } else {
            await FlutterForegroundTask.startService(
              notificationTitle: 'Call from ${widget.content.name}',
              notificationText: widget.content.number!,
              notificationButtons: const [
                NotificationButton(id: '1', text: 'Call', textColor: Colors.green),
                NotificationButton(id: '1', text: 'Reject', textColor: Colors.red),
              ],
              notificationIcon: const NotificationIconData(
                  resType: ResourceType.mipmap,
                  resPrefix: ResourcePrefix.img,
                  name: 'brand',
                  backgroundColor: Colors.amber),
            );
          }
        }
        // try {
        //   //here i call my method channel
        //    await platform.invokeMethod('bringToForeground', arguments);
        // } catch (e) {
        //   e;
        // }
        // // }
        try {
          FlutterForegroundTask.launchApp();
        } catch (e) {
          e;
        }
        _navigateToCallPage();
      }
    });
  }

  void _countdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_delay > 0) {
        setState(() {
          _delay--;
        });
        _countdown();
      }
    });
  }

  Widget _buildCallButton(String imagePath, String text, VoidCallback onPressed, bool isLoading) {
    return itemOudioVideo(
      context,
      Provider.of<DataProvider>(context),
      isLoading ? ImageConstants.loading : imagePath,
      50,
      text,
      onPressed,
      isLoading,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) => Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(value.data.splashUrl.toString()),
              filterQuality: FilterQuality.high,
              fit: BoxFit.fill,
            ),
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 35.0, sigmaY: 35.0),
            child: Container(
              color: Colors.black.withOpacity(0.8),
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 45),
                    SizedBox(
                      height: 130,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 111,
                              width: 111,
                              decoration: BoxDecoration(
                                color: Colors.grey[300]!,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(widget.content.icon.toString()),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              AppInterstitialAd.show();

                              Navigator.pop(context);
                            },
                            child: Opacity(
                              opacity: 0.8,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.15),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    BorderedText(
                      strokeColor: Colors.white.withOpacity(0.15),
                      child: Text(
                        widget.content.name.toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.skranji(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.60,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildCallButton(
                      ImageConstants.time,
                      widget.isAudio ? 'Make Audio Call now' : 'Make Video Call now',
                      () {
                        if (_time == 0) {
                          _navigateToCallPage();
                        }
                      },
                      false,
                    ),
                    for (int i = 0; i < delayTimes.length; i++)
                      _buildCallButton(
                        _time == delayTimes[i] ? ImageConstants.loading : ImageConstants.time,
                        _isRunning == i + 1 ? 'after $_delay sec' : 'after ${delayTimes[i]} sec',
                        () {
                          if (_time == 0) {
                            initForegroundTask();
                            setState(() {
                              _isRunning = i + 1;
                              _delay = delayTimes[i];
                            });
                            _handleDelayedNavigation(delayTimes[i]);
                          }
                        },
                        _time == delayTimes[i],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
