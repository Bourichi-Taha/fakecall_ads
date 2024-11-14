import 'dart:io';
import 'dart:ui';

import 'package:bordered_text/bordered_text.dart';
import 'package:fakecall/ad_manager/banner_ad.dart';
import 'package:fakecall/ad_manager/interstitial_ad.dart';
import 'package:fakecall/ad_manager/native_ad.dart';
import 'package:fakecall/model_view/data_provider.dart';
import 'package:fakecall/view/call/call.dart';
import 'package:fakecall/view/home/widget/home_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final InAppReview inAppReview = InAppReview.instance;

  @override
  void initState() {
    super.initState();
    AppInterstitialAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.black.withOpacity(0.8),
                title: Text(
                  'Exit',
                  style: GoogleFonts.skranji(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                content: Text(
                  'Are you sure you want to exit?',
                  style: GoogleFonts.skranji(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('No',
                        style: GoogleFonts.skranji(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                  TextButton(
                    onPressed: () {
                      if (Platform.isAndroid) {
                        SystemNavigator.pop();
                      } else if (Platform.isIOS) {
                        exit(0);
                      }
                    },
                    child: Text(
                      'Yes',
                      style: GoogleFonts.skranji(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      inAppReview.requestReview(); // Fixed requestReview method
                    },
                    child: Text(
                      'Rate Us',
                      style: GoogleFonts.skranji(
                        color: Colors.yellow,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              );
            });
        return Future.value(false);
      },
      child: Consumer<DataProvider>(
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
                                    image: AssetImage(value.data.appIcon.toString()),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                AppInterstitialAd.show();
                                Navigator.pushNamed(context, '/profile');
                              },
                              child: Opacity(
                                opacity: 0.80,
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
                                        Icons.person_outline_outlined,
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
                          value.data.appName.toString(),
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
                      Expanded(
                        child: ListView.separated(
                          itemCount: value.data.content!.length,
                          itemBuilder: (context, index) {
                            return homeItem(
                              context,
                              value.data.content![index].name.toString(),
                              value.data.content![index].number.toString(),
                              value.data.content![index].icon.toString(),
                              () {
                                AppInterstitialAd.show();
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return CallScreen(
                                      content: value.data.content![index],
                                    );
                                  },
                                ));
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return index == 0 ? const AppNativeAd() : const SizedBox();
                          },
                        ),
                      ),
                      const AppBannerAd(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
