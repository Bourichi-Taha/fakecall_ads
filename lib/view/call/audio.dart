import 'dart:async';
import 'dart:ui';
import 'package:fakecall/model/data.dart';
import 'package:fakecall/model_view/data_provider.dart';
import 'package:fakecall/utils/image_constants.dart';
import 'package:fakecall/view/call/widget/audio_items.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPage extends StatefulWidget {
  final Content content;
  const AudioPage({super.key, required this.content});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  int seconds = 0;
  Timer? _timer;
  final player = AudioPlayer();
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 0),
      () async {
        player.setReleaseMode(ReleaseMode.stop);
        //play audio from assets
        await player.setSource(AssetSource(
          widget.content.vocal.toString(),
        ));
        await player.resume();
      },
    );
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        seconds++;
      });
    });
  }

  @override
  void dispose() {
    player.dispose();
    _timer?.cancel();
    super.dispose();
  }

  String formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) => Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  value.data.splashUrl.toString(),
                ),
                filterQuality: FilterQuality.high,
                fit: BoxFit.fill),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Stack(
                children: [
                  SafeArea(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Container(
                            height: 111,
                            width: 111,
                            decoration: BoxDecoration(
                              color: Colors.grey[300]!,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image:
                                    AssetImage(widget.content.icon.toString()),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.content.name.toString(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.museoModerno(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.96,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            formatDuration(seconds),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.museoModerno(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 5),
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 2.5,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  oudioItem('mute', ImageConstants.micOff),
                                  oudioItem('keypad', ImageConstants.keypad),
                                  oudioItem('audio', ImageConstants.speaker),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  oudioItem('add call', ImageConstants.addCall),
                                  oudioItem('FaceTime', ImageConstants.video1),
                                  oudioItem('Contacts', ImageConstants.contact),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 107,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Center(
                              child: Container(
                                height: 81,
                                width: 81,
                                decoration: const BoxDecoration(
                                  color: Color(0xffFF0000),
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.call_end,
                                    size: 28,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
