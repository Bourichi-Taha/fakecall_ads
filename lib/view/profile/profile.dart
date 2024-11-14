import 'dart:io';
import 'dart:ui';
import 'package:bordered_text/bordered_text.dart';
import 'package:fakecall/main.dart';
import 'package:fakecall/model_view/data_provider.dart';
import 'package:fakecall/utils/image_constants.dart';
import 'package:fakecall/utils/utils.dart';
import 'package:fakecall/view/profile/widgets/builder_item.dart';
import 'package:fakecall/view/profile/widgets/profile_item.dart';
import 'package:fakecall/view/profile/webview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final InAppReview inAppReview = InAppReview.instance;
  @override
  void initState() {
    super.initState();
  }

  Future<void> openStoreListing() => inAppReview.openStoreListing(
      appStoreId: packageInfo!.packageName,
      microsoftStoreId: packageInfo!.packageName);

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
                child: SingleChildScrollView(
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
                                    image: AssetImage(
                                        value.data.appIcon.toString()),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: () {
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
                                      color: Colors.white
                                          .withOpacity(0.15000000596046448),
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
                        strokeColor:
                            Colors.white.withOpacity(0.15000000596046448),
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
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Opacity(
                            opacity: 0.70,
                            child: Text(
                              'Support us',
                              style: GoogleFonts.museoModerno(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.17,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      profileItem(context, 'Rate Us', ImageConstants.rateus,
                          () {
                        openStoreListing();
                        // _requestReview();
                      }),
                      profileItem(
                          context, 'Contact Us', ImageConstants.contactus, () {
                        final Uri emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: value.data.contact.toString(),
                          query: encodeQueryParameters(<String, String>{
                            'subject': 'Feedback',
                          }),
                        );
                        launchUrl(emailLaunchUri);
                      }),
                      profileItem(
                          context, 'Share with friends', ImageConstants.share,
                          () {
                        if (Platform.isIOS) {
                          Share.share(
                              'https://apps.apple.com/us/app/${packageInfo!.packageName}/id${packageInfo!.buildSignature}');
                        } else {
                          Share.share(
                              'https://play.google.com/store/apps/details?id=${packageInfo!.packageName}');
                        }
                      }),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Opacity(
                            opacity: 0.70,
                            child: Text(
                              'About the app',
                              style: GoogleFonts.museoModerno(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.17,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      profileItem(context, 'About us', ImageConstants.aboutus,
                          () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return WebviewScreen(
                              url: value.data.about.toString(),
                              title: 'About us');
                        }));
                      }),
                      profileItem(
                          context, 'Terms and Conditions', ImageConstants.trems,
                          () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return WebviewScreen(
                              url: value.data.terms.toString(),
                              title: 'Terms and Conditions');
                        }));
                      }),
                      profileItem(
                          context, 'Privacy Policy', ImageConstants.privacy,
                          () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return WebviewScreen(
                              url: value.data.privacy.toString(),
                              title: 'Privacy Policy');
                        }));
                      }),
                      const SizedBox(
                        height: 40,
                      ),
                      builderWidget(),
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
