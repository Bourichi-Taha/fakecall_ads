import 'package:bordered_text/bordered_text.dart';
import 'package:fakecall/model_view/data_provider.dart';
import 'package:fakecall/utils/colors_utils.dart';
import 'package:fakecall/view/onboarding/widgets/indicator.dart';
import 'package:fakecall/view/onboarding/widgets/onboarding_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  //page controller
  final PageController controller = PageController(
    initialPage: 0,
  );
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) => Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.6,
                  child: PageView(
                    // physics: const NeverScrollableScrollPhysics(),
                    controller: controller,
                    children: [
                      for (var i = 0; i < value.data.intro!.length; i++)
                        onboardingItem(context, value, i),
                    ],
                    onPageChanged: (int index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2.6,
                  child: Column(
                    children: [
                      BorderedText(
                        strokeColor: Colors.white.withOpacity(0.2),
                        child: Text(
                          value.data.intro![currentPage].title.toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.skranji(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.90,
                          ),
                        ),
                      ),
                      Opacity(
                        opacity: 0.60,
                        child: Text(
                          value.data.intro![currentPage].description.toString(),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Abel',
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                      indicatorItems(value, currentPage),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 80,
                  child: Column(
                    children: [
                      if (currentPage == 0)
                        InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width - 48,
                            height: 51,
                            decoration: ShapeDecoration(
                              gradient: LinearGradient(
                                begin: const Alignment(-1.00, 0.00),
                                end: const Alignment(1, 0),
                                colors: [
                                  hexToColor(value.data.mainColor.toString())
                                      .withOpacity(0.800000011920929),
                                  hexToColor(value.data.mainColor.toString()),
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: hexToColor(
                                          value.data.mainColor.toString())
                                      .withOpacity(0.45),
                                  blurRadius: 50,
                                  offset: const Offset(0, 0),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Next',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.museoModerno(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (currentPage != 0) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: SizedBox(
                            height: 51,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(100),
                                  onTap: () {
                                    controller.previousPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeIn,
                                    );
                                  },
                                  child: Container(
                                    width: 51,
                                    height: 51,
                                    decoration: ShapeDecoration(
                                      color: const Color(0x19FFFAFA),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.arrow_back,
                                        size: 32,
                                        color: const Color(0xffB8B8B8)
                                            .withOpacity(0.800000011920929),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(100),
                                  onTap: () {
                                    if (currentPage ==
                                        value.data.intro!.length - 1) {
                                      Navigator.pushReplacementNamed(
                                          context, '/home');
                                    }
                                    if (currentPage <
                                        value.data.intro!.length - 1) {
                                      controller.nextPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeIn,
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: 130.80,
                                    height: 51,
                                    decoration: ShapeDecoration(
                                      gradient: LinearGradient(
                                        begin: const Alignment(-1.00, 0.00),
                                        end: const Alignment(1, 0),
                                        colors: [
                                          hexToColor(value.data.mainColor
                                                  .toString())
                                              .withOpacity(0.800000011920929),
                                          hexToColor(
                                              value.data.mainColor.toString()),
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      shadows: [
                                        BoxShadow(
                                          color: hexToColor(value.data.mainColor
                                                  .toString())
                                              .withOpacity(0.600000011920929),
                                          blurRadius: 50,
                                          offset: const Offset(0, 0),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    //next text child
                                    child: Center(
                                      child: Text(
                                        'Next',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.museoModerno(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.22,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ],
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
