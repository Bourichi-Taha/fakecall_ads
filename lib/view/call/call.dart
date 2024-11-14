import 'dart:ui';

import 'package:bordered_text/bordered_text.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:fakecall/ad_manager/interstitial_ad.dart';
import 'package:fakecall/model/data.dart';
import 'package:fakecall/model_view/data_provider.dart';
import 'package:fakecall/utils/image_constants.dart';
import 'package:fakecall/view/call/audio_video.dart';
import 'package:fakecall/view/call/widget/call_items.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CallScreen extends StatefulWidget {
  final Content content;
  const CallScreen({super.key, required this.content});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) => Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  value.data.splashUrl.toString(),
                ),
                filterQuality: FilterQuality.high,
                fit: BoxFit.fill),
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 35.0, sigmaY: 35.0),
            child: Container(
              color: Colors.black.withOpacity(0.800000011920929),
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 45,
                    ),
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
                              opacity: 0.80,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.15000000596046448),
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
                      strokeColor: Colors.white.withOpacity(0.15000000596046448),
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
                    const SizedBox(
                      height: 20,
                    ),
                    callItem(context, 'Audio Call', ImageConstants.audio, onTap: () {
                      AppInterstitialAd.show();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return AudioVideo(
                              content: widget.content,
                              isAudio: true,
                            );
                          },
                        ),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                      child: DottedLine(
                        dashLength: 10,
                        dashColor: Colors.white.withOpacity(0.5),
                        lineThickness: 1,
                      ),
                    ),
                    callItem(context, 'Video Call', ImageConstants.video, onTap: () {
                      AppInterstitialAd.show();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return AudioVideo(
                              content: widget.content,
                              isAudio: false,
                            );
                          },
                        ),
                      );
                    }),
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
