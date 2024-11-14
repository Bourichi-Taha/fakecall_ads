import 'package:fakecall/main.dart';
import 'package:fakecall/model/data.dart';
import 'package:fakecall/model_view/data_provider.dart';
import 'package:fakecall/view/call/video.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideocallScreen extends StatefulWidget {
  final Content content;
  const VideocallScreen({super.key, required this.content});

  @override
  State<VideocallScreen> createState() => _VideocallScreenState();
}

class _VideocallScreenState extends State<VideocallScreen> {
  late VideoPlayerController controller;
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 0),
      () {
        controller =
            VideoPlayerController.asset(widget.content.video.toString())
              ..initialize().then((v) {
              });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
          child: Stack(
            children: [
              // if (cameras.isNotEmpty) CameraApp(),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
                child: cameras.isNotEmpty
                    ? const CameraApp()
                    : const Center(
                        child: Text(
                          'No Camera Found',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
              ),
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
                            image: AssetImage(widget.content.icon.toString()),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.content.name.toString(),
                        style: GoogleFonts.skranji(
                          fontSize: 20,
                          color: Colors.white,
                          letterSpacing: 0.60,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Video Callig..',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.museoModerno(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          letterSpacing: -0.17,
                          shadows: [
                            const Shadow(
                              color: Colors.black,
                              offset: Offset(1, 1),
                              blurRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 107,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 66,
                            width: 66,
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
                        Container(
                          height: 66,
                          width: 66,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.mic_off,
                              size: 28,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          height: 66,
                          width: 66,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.videocam,
                              size: 28,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideoScreen(
                                  content: widget.content,
                                  controller: controller,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 66,
                            width: 66,
                            decoration: const BoxDecoration(
                              color: Color(0xff0FD717),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.call,
                                size: 28,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
