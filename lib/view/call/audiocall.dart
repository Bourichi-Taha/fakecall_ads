import 'dart:ui';
import 'package:fakecall/model/data.dart';
import 'package:fakecall/model_view/data_provider.dart';
import 'package:fakecall/view/call/audio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Audiocall extends StatefulWidget {
  final Content content;
  const Audiocall({super.key, required this.content});

  @override
  State<Audiocall> createState() => _AudiocallState();
}

class _AudiocallState extends State<Audiocall>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
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
              image: AssetImage(value.data.splashUrl.toString()),
              filterQuality: FilterQuality.high,
              fit: BoxFit.fill,
            ),
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
                          const SizedBox(height: 10),
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
                          const SizedBox(height: 10),
                          Text(
                            'is Calling...',
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        height: 107,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              const Spacer(),
                              ScaleTransition(
                                scale: _animation,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AudioPage(content: widget.content),
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
                              ),
                            ],
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
