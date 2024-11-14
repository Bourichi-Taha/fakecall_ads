import 'package:fakecall/model_view/data_provider.dart';
import 'package:fakecall/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

InkWell itemOudioVideo(BuildContext context, DataProvider value, String icon,
    double height, String name, Function()? onTap, bool isLoading) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color:
            !isLoading ? Colors.white.withOpacity(0.07000000029802322) : null,
        borderRadius: BorderRadius.circular(100),
        gradient: isLoading
            ? LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  hexToColor(value.data.mainColor.toString())
                      .withOpacity(0.800000011920929),
                  hexToColor(value.data.mainColor.toString()),
                ],
              )
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 65,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15000000596046448),
                borderRadius: BorderRadius.circular(100),
              ),
              child: !isLoading
                  ? Center(
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icon),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    )
                  : const Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeCap: StrokeCap.square,
                          strokeWidth: 3,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    ),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: GoogleFonts.skranji(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.17,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward,
              color: Colors.white.withOpacity(0.5),
            ),
            const SizedBox(
              width: 15,
            )
          ],
        ),
      ),
    ),
  );
}
